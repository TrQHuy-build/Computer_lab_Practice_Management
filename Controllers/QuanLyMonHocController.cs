using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using QL_TH_MT.Data;
using QL_TH_MT.Models;
using QL_TH_MT.ViewModels;

namespace QL_TH_MT.Controllers
{
    /// <summary>
    /// Controller quản lý môn học - Phòng đào tạo
    /// </summary>
    [Authorize]
    public class QuanLyMonHocController : Controller
    {
        private readonly NewAppDbContext _context;

        public QuanLyMonHocController(NewAppDbContext context)
        {
            _context = context;
        }

        // GET: /QuanLyMonHoc
        public async Task<IActionResult> Index()
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var danhSach = await _context.MonHocs
                .OrderBy(m => m.MaMonHoc)
                .Select(m => new MonHocViewModel
                {
                    Id = m.Id,
                    MaMonHoc = m.MaMonHoc,
                    TenMonHoc = m.TenMonHoc,
                    SoTinChi = m.SoTinChi,
                    SoBuoiThucHanh = m.SoBuoiThucHanh,
                    MoTa = m.MoTa,
                    DangHoatDong = m.TrangThaiHoatDong
                })
                .ToListAsync();

            return View(danhSach);
        }

        // GET: /QuanLyMonHoc/Tao
        [HttpGet]
        public IActionResult Tao()
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            return View(new MonHocCreateViewModel { SoBuoiThucHanh = 3 });
        }

        // POST: /QuanLyMonHoc/Tao
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Tao(MonHocCreateViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            if (await _context.MonHocs.AnyAsync(m => m.MaMonHoc == model.MaMonHoc))
            {
                ModelState.AddModelError("MaMonHoc", "Mã môn học đã tồn tại");
                return View(model);
            }

            var monHoc = new MonHocNew
            {
                MaMonHoc = model.MaMonHoc,
                TenMonHoc = model.TenMonHoc,
                SoTinChi = model.SoTinChi,
                SoBuoiThucHanh = model.SoBuoiThucHanh,
                MoTa = model.MoTa,
                TrangThaiHoatDong = true,
                NgayTao = DateTime.Now
            };

            _context.MonHocs.Add(monHoc);
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Tạo môn học {model.MaMonHoc} thành công!";
            return RedirectToAction("Index");
        }

        // GET: /QuanLyMonHoc/Sua/5
        [HttpGet]
        public async Task<IActionResult> Sua(int id)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var monHoc = await _context.MonHocs.FindAsync(id);
            if (monHoc == null)
            {
                return NotFound();
            }

            var model = new MonHocViewModel
            {
                Id = monHoc.Id,
                MaMonHoc = monHoc.MaMonHoc,
                TenMonHoc = monHoc.TenMonHoc,
                SoTinChi = monHoc.SoTinChi,
                SoBuoiThucHanh = monHoc.SoBuoiThucHanh,
                MoTa = monHoc.MoTa,
                TrangThaiHoatDong = monHoc.TrangThaiHoatDong,
                DangHoatDong = monHoc.TrangThaiHoatDong
            };

            return View(model);
        }

        // POST: /QuanLyMonHoc/Sua/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Sua(int id, MonHocViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var monHoc = await _context.MonHocs.FindAsync(id);
            if (monHoc == null)
            {
                return NotFound();
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            monHoc.TenMonHoc = model.TenMonHoc;
            monHoc.SoTinChi = model.SoTinChi;
            monHoc.SoBuoiThucHanh = model.SoBuoiThucHanh;
            monHoc.MoTa = model.MoTa;
            monHoc.TrangThaiHoatDong = model.TrangThaiHoatDong;

            await _context.SaveChangesAsync();

            TempData["Success"] = "Cập nhật môn học thành công!";
            return RedirectToAction("Index");
        }

        // POST: /QuanLyMonHoc/Xoa/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Xoa(int id)
        {
            if (!KiemTraQuyen())
            {
                TempData["Error"] = "Không có quyền thực hiện thao tác này!";
                return RedirectToAction("Index");
            }

            var monHoc = await _context.MonHocs.FindAsync(id);
            if (monHoc == null)
            {
                TempData["Error"] = "Không tìm thấy môn học!";
                return RedirectToAction("Index");
            }

            var coHopDong = await _context.HopDongMonHocs.AnyAsync(h => h.MonHocId == id);
            if (coHopDong)
            {
                TempData["Error"] = "Không thể xóa vì đã có hợp đồng liên quan!";
                return RedirectToAction("Index");
            }

            // Soft delete - chuyển trạng thái về 0 thay vì xóa hoàn toàn
            monHoc.TrangThaiHoatDong = false;
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Đã xóa môn học {monHoc.MaMonHoc} - {monHoc.TenMonHoc} thành công!";
            return RedirectToAction("Index");
        }

        private bool KiemTraQuyen()
        {
            return User.IsInRole(LoaiVaiTro.PhongDaoTao.ToString()) ||
                   User.IsInRole(LoaiVaiTro.Admin.ToString());
        }
    }
}
