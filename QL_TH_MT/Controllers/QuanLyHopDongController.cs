using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using QL_TH_MT.Data;
using QL_TH_MT.Models;
using QL_TH_MT.ViewModels;

namespace QL_TH_MT.Controllers
{
    [Authorize(Roles = "PhongDaoTao,Admin")]
    public class QuanLyHopDongController : Controller
    {
        private readonly NewAppDbContext _context;

        public QuanLyHopDongController(NewAppDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var hopDongs = await _context.HopDongs
                .Include(h => h.GiangVien)
                .Include(h => h.HocKy)
                .Include(h => h.HopDongMonHocs)
                    .ThenInclude(m => m.MonHoc)
                .OrderByDescending(h => h.NgayTao)
                .ToListAsync();

            var viewModels = hopDongs.Select(h => new HopDongViewModel
            {
                Id = h.Id,
                MaHopDong = h.SoHopDong,
                GiangVienId = h.GiangVienId,
                TenGiangVien = h.GiangVien != null ? h.GiangVien.HoTen : "",
                LoaiGiangVien = h.GiangVien?.LoaiGiangVien?.ToString() ?? "",
                HocKyId = h.HocKyId,
                TenHocKy = h.HocKy != null ? h.HocKy.TenHocKy : "",
                TenMonHoc = h.HopDongMonHocs != null 
                    ? string.Join(", ", h.HopDongMonHocs.Select(m => m.MonHoc?.TenMonHoc ?? "")) 
                    : "",
                SoHocPhan = h.HopDongMonHocs?.Count ?? 0,
                GhiChu = h.GhiChu,
                TrangThai = h.TrangThai
            }).ToList();

            return View(viewModels);
        }

        [HttpGet]
        public async Task<IActionResult> Tao()
        {
            var model = new HopDongCreateViewModel();
            await LoadDropdowns(model);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Tao(HopDongCreateViewModel model)
        {
            // Kiem tra chon it nhat 1 mon hoc
            if (model.MonHocIds == null || model.MonHocIds.Count == 0)
            {
                ModelState.AddModelError("MonHocIds", "Vui long chon it nhat mot mon hoc");
            }

            // Kiem tra ma hop dong da ton tai chua
            if (await _context.HopDongs.AnyAsync(h => h.SoHopDong == model.MaHopDong))
            {
                ModelState.AddModelError("MaHopDong", "Ma hop dong da ton tai");
            }

            if (!ModelState.IsValid)
            {
                await LoadDropdowns(model);
                return View(model);
            }

            // Tao hop dong
            var hopDong = new HopDongNew
            {
                SoHopDong = model.MaHopDong,
                GiangVienId = model.GiangVienId,
                HocKyId = model.HocKyId,
                GhiChu = model.GhiChu,
                TrangThai = 0, // Cho duyet
                NgayTao = DateTime.Now,
                NguoiTaoId = 1 // TODO: Lay tu user dang nhap
            };

            _context.HopDongs.Add(hopDong);
            await _context.SaveChangesAsync();

            // Them cac mon hoc vao hop dong
            foreach (var monHocId in model.MonHocIds)
            {
                var hopDongMonHoc = new HopDongMonHocNew
                {
                    HopDongId = hopDong.Id,
                    MonHocId = monHocId
                };
                _context.HopDongMonHocs.Add(hopDongMonHoc);
            }
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Tao hop dong thanh cong voi " + model.MonHocIds.Count + " mon hoc!";
            return RedirectToAction(nameof(Index));
        }

        [HttpGet]
        public async Task<IActionResult> Sua(int id)
        {
            var hopDong = await _context.HopDongs
                .Include(h => h.HopDongMonHocs)
                .FirstOrDefaultAsync(h => h.Id == id);

            if (hopDong == null)
            {
                return NotFound();
            }

            var model = new HopDongCreateViewModel
            {
                Id = hopDong.Id,
                MaHopDong = hopDong.SoHopDong,
                GiangVienId = hopDong.GiangVienId,
                MonHocIds = hopDong.HopDongMonHocs?.Select(m => m.MonHocId).ToList() ?? new List<int>(),
                HocKyId = hopDong.HocKyId,
                GhiChu = hopDong.GhiChu
            };

            await LoadDropdowns(model);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Sua(int id, HopDongCreateViewModel model)
        {
            if (id != model.Id)
            {
                return NotFound();
            }

            if (model.MonHocIds == null || model.MonHocIds.Count == 0)
            {
                ModelState.AddModelError("MonHocIds", "Vui long chon it nhat mot mon hoc");
            }

            if (!ModelState.IsValid)
            {
                await LoadDropdowns(model);
                return View(model);
            }

            var hopDong = await _context.HopDongs
                .Include(h => h.HopDongMonHocs)
                .FirstOrDefaultAsync(h => h.Id == id);

            if (hopDong == null)
            {
                return NotFound();
            }

            // Cap nhat thong tin hop dong
            hopDong.SoHopDong = model.MaHopDong;
            hopDong.GiangVienId = model.GiangVienId;
            hopDong.HocKyId = model.HocKyId;
            hopDong.GhiChu = model.GhiChu;

            // Xoa mon hoc cu
            if (hopDong.HopDongMonHocs != null && hopDong.HopDongMonHocs.Any())
            {
                _context.HopDongMonHocs.RemoveRange(hopDong.HopDongMonHocs);
            }

            // Them mon hoc moi
            foreach (var monHocId in model.MonHocIds)
            {
                var hopDongMonHoc = new HopDongMonHocNew
                {
                    HopDongId = hopDong.Id,
                    MonHocId = monHocId
                };
                _context.HopDongMonHocs.Add(hopDongMonHoc);
            }

            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Cap nhat hop dong thanh cong!";
            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Duyet(int id)
        {
            var hopDong = await _context.HopDongs.FindAsync(id);
            if (hopDong == null)
            {
                return NotFound();
            }

            hopDong.TrangThai = 1; // Da duyet
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Duyet hop dong thanh cong!";
            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Xoa(int id)
        {
            var hopDong = await _context.HopDongs
                .Include(h => h.HopDongMonHocs)
                .FirstOrDefaultAsync(h => h.Id == id);

            if (hopDong == null)
            {
                return NotFound();
            }

            if (hopDong.HopDongMonHocs != null && hopDong.HopDongMonHocs.Any())
            {
                _context.HopDongMonHocs.RemoveRange(hopDong.HopDongMonHocs);
            }

            _context.HopDongs.Remove(hopDong);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Xoa hop dong thanh cong!";
            return RedirectToAction(nameof(Index));
        }

        private async Task LoadDropdowns(HopDongCreateViewModel model)
        {
            model.DanhSachGiangVien = await _context.TaiKhoans
                .Where(t => t.VaiTro == LoaiVaiTro.GiangVien && t.TrangThaiHoatDong)
                .OrderBy(t => t.HoTen)
                .ToListAsync();

            model.DanhSachMonHoc = await _context.MonHocs
                .Where(m => m.TrangThaiHoatDong)
                .OrderBy(m => m.TenMonHoc)
                .ToListAsync();

            model.DanhSachHocKy = await _context.HocKys
                .OrderByDescending(h => h.NamHoc)
                .ThenByDescending(h => h.SoHocKy)
                .ToListAsync();

            // Lay hoc ky hien tai lam mac dinh
            var hocKyHienTai = await _context.HocKys
                .Where(h => h.TrangThai == 1)
                .OrderByDescending(h => h.NgayTao)
                .FirstOrDefaultAsync();
            
            if (hocKyHienTai != null && model.HocKyId == 0)
            {
                model.HocKyId = hocKyHienTai.Id;
            }
        }
    }
}
