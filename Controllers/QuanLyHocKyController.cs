using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using QL_TH_MT.Data;
using QL_TH_MT.Models;
using QL_TH_MT.ViewModels;
using QL_TH_MT.Services;

namespace QL_TH_MT.Controllers
{
    /// <summary>
    /// Controller quản lý học kỳ - Phòng đào tạo
    /// </summary>
    [Authorize]
    public class QuanLyHocKyController : Controller
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;

        public QuanLyHocKyController(NewAppDbContext context, HocKyServiceNew hocKyService)
        {
            _context = context;
            _hocKyService = hocKyService;
        }

        // GET: /QuanLyHocKy
        public async Task<IActionResult> Index()
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocKys = await _context.HocKys
                .OrderByDescending(h => h.NgayTao)
                .ToListAsync();

            var danhSach = hocKys.Select(h => new HocKyViewModel
            {
                Id = h.Id,
                TenHocKy = h.TenHocKy,
                NamHoc = h.NamHoc,
                NgayBatDau = h.BatDauHocKy,
                NgayKetThuc = h.KetThucHocKy,
                GiaiDoanHienTai = _hocKyService.GetTenGiaiDoan(_hocKyService.XacDinhGiaiDoan(h)),
                DangHoatDong = h.TrangThai == 1
            }).ToList();

            return View(danhSach);
        }

        // GET: /QuanLyHocKy/ChiTiet/5
        public async Task<IActionResult> ChiTiet(int id)
        {
            var hocKy = await _context.HocKys
                .Include(h => h.NguoiTao)
                .FirstOrDefaultAsync(h => h.Id == id);

            if (hocKy == null)
            {
                return NotFound();
            }

            var giaiDoan = _hocKyService.XacDinhGiaiDoan(hocKy);

            var viewModel = new ChiTietHocKyViewModel
            {
                HocKy = hocKy,
                GiaiDoanHienTai = giaiDoan,
                TenGiaiDoan = _hocKyService.GetTenGiaiDoan(giaiDoan),
                TongHopDong = await _context.HopDongs.CountAsync(h => h.HocKyId == id),
                TongDangKyLich = await _context.DangKyLichThinhGiangs.CountAsync(d => d.HocKyId == id),
                TongLichThucHanh = await _context.LichThucHanhs.CountAsync(l => l.HocKyId == id),
                LichDaDuyet = await _context.LichThucHanhs.CountAsync(l => l.HocKyId == id && l.TrangThai >= 2)
            };

            return View(viewModel);
        }

        // GET: /QuanLyHocKy/Tao
        [HttpGet]
        public IActionResult Tao()
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var model = new HocKyCreateViewModel
            {
                TienHocKy = DateTime.Now.Date,
                NgayBatDauTienHocKy = DateTime.Now.Date,
                BatDauHocKy = DateTime.Now.Date.AddDays(28), // 4 tuần sau
                NgayBatDau = DateTime.Now.Date.AddDays(28),
                KetThucHocKy = DateTime.Now.Date.AddDays(140), // ~20 tuần
                NgayKetThuc = DateTime.Now.Date.AddDays(140)
            };

            return View(model);
        }

        // POST: /QuanLyHocKy/Tao
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Tao(HocKyCreateViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // Validate: TienHocKy < BatDauHocKy < KetThucHocKy
            if (model.TienHocKy >= model.BatDauHocKy)
            {
                ModelState.AddModelError("BatDauHocKy", "Ngày bắt đầu phải sau ngày tiền học kỳ");
                return View(model);
            }

            if (model.BatDauHocKy >= model.KetThucHocKy)
            {
                ModelState.AddModelError("KetThucHocKy", "Ngày kết thúc phải sau ngày bắt đầu");
                return View(model);
            }

            // Validate: Tiền học kỳ phải cách bắt đầu ít nhất 4 tuần
            if ((model.BatDauHocKy - model.TienHocKy).TotalDays < 28)
            {
                ModelState.AddModelError("TienHocKy", "Giai đoạn trước học kỳ cần ít nhất 4 tuần");
                return View(model);
            }

            var hocKy = new HocKyNew
            {
                TenHocKy = model.TenHocKy ?? $"Học kỳ {model.SoHocKy}",
                NamHoc = model.NamHoc,
                SoHocKy = model.SoHocKy,
                TienHocKy = model.TienHocKy,
                BatDauHocKy = model.BatDauHocKy,
                KetThucHocKy = model.KetThucHocKy,
                TrangThai = 1, // Mặc định là hoạt động
                NguoiTaoId = GetUserId(),
                NgayTao = DateTime.Now
            };

            await _hocKyService.TaoHocKyMoi(hocKy);

            TempData["Success"] = "Tạo học kỳ thành công!";
            return RedirectToAction("Index");
        }

        // GET: /QuanLyHocKy/Sua/5
        [HttpGet]
        public async Task<IActionResult> Sua(int id)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocKy = await _context.HocKys.FindAsync(id);
            if (hocKy == null)
            {
                return NotFound();
            }

            var model = new HocKyViewModel
            {
                Id = hocKy.Id,
                TenHocKy = hocKy.TenHocKy,
                NamHoc = hocKy.NamHoc,
                SoHocKy = hocKy.SoHocKy,
                TienHocKy = hocKy.TienHocKy,
                BatDauHocKy = hocKy.BatDauHocKy,
                KetThucHocKy = hocKy.KetThucHocKy,
                TrangThai = hocKy.TrangThai
            };

            return View(model);
        }

        // POST: /QuanLyHocKy/Sua/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Sua(int id, HocKyViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocKy = await _context.HocKys.FindAsync(id);
            if (hocKy == null)
            {
                return NotFound();
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            hocKy.TenHocKy = model.TenHocKy;
            hocKy.NamHoc = model.NamHoc;
            hocKy.SoHocKy = model.SoHocKy;
            hocKy.TienHocKy = model.TienHocKy;
            hocKy.BatDauHocKy = model.BatDauHocKy;
            hocKy.KetThucHocKy = model.KetThucHocKy;
            hocKy.TrangThai = model.TrangThai;

            // Tính lại các mốc thời gian
            hocKy.KetThucNhapHopDong = model.TienHocKy.AddDays(7);
            hocKy.KetThucDangKyLich = model.TienHocKy.AddDays(14);
            hocKy.KetThucSapXepLich = model.TienHocKy.AddDays(21);
            hocKy.KetThucThongBao = model.BatDauHocKy;

            await _context.SaveChangesAsync();

            TempData["Success"] = "Cập nhật học kỳ thành công!";
            return RedirectToAction("Index");
        }

        // POST: /QuanLyHocKy/KichHoat/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> KichHoat(int id)
        {
            if (!KiemTraQuyen())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            await _hocKyService.KichHoatHocKy(id);

            return Json(new { success = true, message = "Kích hoạt học kỳ thành công!" });
        }

        // POST: /QuanLyHocKy/Xoa/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Xoa(int id)
        {
            if (!KiemTraQuyen())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var hocKy = await _context.HocKys.FindAsync(id);
            if (hocKy == null)
            {
                return Json(new { success = false, message = "Không tìm thấy học kỳ" });
            }

            // Kiểm tra có dữ liệu liên quan không
            var coLich = await _context.LichThucHanhs.AnyAsync(l => l.HocKyId == id);
            if (coLich)
            {
                return Json(new { success = false, message = "Không thể xóa vì đã có lịch thực hành" });
            }

            _context.HocKys.Remove(hocKy);
            await _context.SaveChangesAsync();

            return Json(new { success = true, message = "Xóa học kỳ thành công!" });
        }

        private bool KiemTraQuyen()
        {
            return User.IsInRole(LoaiVaiTro.PhongDaoTao.ToString()) ||
                   User.IsInRole(LoaiVaiTro.Admin.ToString());
        }

        private int GetUserId()
        {
            return int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
        }
    }
}
