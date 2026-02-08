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
    /// Controller quản lý phòng thực hành - Trung tâm đào tạo thực hành
    /// </summary>
    [Authorize]
    public class QuanLyPhongController : Controller
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;

        public QuanLyPhongController(NewAppDbContext context, HocKyServiceNew hocKyService)
        {
            _context = context;
            _hocKyService = hocKyService;
        }

        // GET: /QuanLyPhong
        public async Task<IActionResult> Index()
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var danhSach = await _context.PhongThucHanhs
                .Include(p => p.NguoiKiemKe)
                .OrderBy(p => p.MaPhong)
                .Select(p => new PhongThucHanhViewModel
                {
                    Id = p.Id,
                    MaPhong = p.MaPhong,
                    TenPhong = p.TenPhong,
                    ViTri = p.ViTri,
                    SucChua = p.SucChua,
                    SoMayHoatDong = p.SoMayHoatDong,
                    DangHoatDong = p.TrangThaiHoatDong,
                    NgayKiemKeGanNhat = p.NgayKiemKeGanNhat
                })
                .ToListAsync();

            return View(danhSach);
        }

        // GET: /QuanLyPhong/ChiTiet/5
        public async Task<IActionResult> ChiTiet(int id)
        {
            var phong = await _context.PhongThucHanhs
                .Include(p => p.NguoiKiemKe)
                .Include(p => p.PhanMems!)
                    .ThenInclude(pm => pm.PhanMem)
                .FirstOrDefaultAsync(p => p.Id == id);

            if (phong == null)
            {
                return NotFound();
            }

            var viewModel = new PhongThucHanhViewModel
            {
                Id = phong.Id,
                MaPhong = phong.MaPhong,
                TenPhong = phong.TenPhong,
                ViTri = phong.ViTri,
                SucChua = phong.SucChua,
                SoMayHoatDong = phong.SoMayHoatDong,
                MoTa = phong.MoTa,
                TrangThaiHoatDong = phong.TrangThaiHoatDong,
                DangHoatDong = phong.TrangThaiHoatDong,
                NgayKiemKeGanNhat = phong.NgayKiemKeGanNhat,
                TenNguoiKiemKe = phong.NguoiKiemKe?.HoTen,
                DanhSachPhanMem = phong.PhanMems?.Select(pm => new PhanMemTrongPhongViewModel
                {
                    PhanMemId = pm.PhanMemId,
                    TenPhanMem = pm.PhanMem?.TenPhanMem ?? "",
                    PhienBan = pm.PhanMem?.PhienBan,
                    NgayCaiDat = pm.NgayCaiDat
                }).ToList() ?? new List<PhanMemTrongPhongViewModel>()
            };

            return View(viewModel);
        }

        // GET: /QuanLyPhong/Tao
        [HttpGet]
        public IActionResult Tao()
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            return View(new PhongThucHanhCreateViewModel());
        }

        // POST: /QuanLyPhong/Tao
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Tao(PhongThucHanhCreateViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // Kiểm tra trùng mã phòng
            if (await _context.PhongThucHanhs.AnyAsync(p => p.MaPhong == model.MaPhong))
            {
                ModelState.AddModelError("MaPhong", "Mã phòng đã tồn tại");
                return View(model);
            }

            var phong = new PhongThucHanhNew
            {
                MaPhong = model.MaPhong,
                TenPhong = model.TenPhong,
                ViTri = model.ViTri,
                SucChua = model.SucChua,
                SoMayHoatDong = model.SoMayHoatDong,
                MoTa = model.MoTa,
                TrangThaiHoatDong = model.TrangThaiHoatDong,
                NgayTao = DateTime.Now
            };

            _context.PhongThucHanhs.Add(phong);
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Tạo phòng {model.MaPhong} thành công!";
            return RedirectToAction("Index");
        }

        // GET: /QuanLyPhong/Sua/5
        [HttpGet]
        public async Task<IActionResult> Sua(int id)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var phong = await _context.PhongThucHanhs.FindAsync(id);
            if (phong == null)
            {
                return NotFound();
            }

            var model = new PhongThucHanhViewModel
            {
                Id = phong.Id,
                MaPhong = phong.MaPhong,
                TenPhong = phong.TenPhong,
                ViTri = phong.ViTri,
                SucChua = phong.SucChua,
                SoMayHoatDong = phong.SoMayHoatDong,
                MoTa = phong.MoTa,
                TrangThaiHoatDong = phong.TrangThaiHoatDong
            };

            return View(model);
        }

        // POST: /QuanLyPhong/Sua/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Sua(int id, PhongThucHanhViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var phong = await _context.PhongThucHanhs.FindAsync(id);
            if (phong == null)
            {
                return NotFound();
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            phong.TenPhong = model.TenPhong;
            phong.ViTri = model.ViTri;
            phong.SucChua = model.SucChua;
            phong.SoMayHoatDong = model.SoMayHoatDong;
            phong.MoTa = model.MoTa;
            phong.TrangThaiHoatDong = model.TrangThaiHoatDong;
            phong.NgayCapNhat = DateTime.Now;

            await _context.SaveChangesAsync();

            TempData["Success"] = "Cập nhật phòng thành công!";
            return RedirectToAction("Index");
        }

        // GET: /QuanLyPhong/KiemKe - Danh sách kiểm kê
        public async Task<IActionResult> KiemKe()
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            var giaiDoan = _hocKyService.XacDinhGiaiDoan(hocKy);

            ViewBag.ChoPhepKiemKe = giaiDoan == GiaiDoanHocKy.Tuan1_NhapHopDong;
            ViewBag.HocKy = hocKy;

            var danhSach = await _context.PhongThucHanhs
                .Include(p => p.NguoiKiemKe)
                .OrderBy(p => p.NgayKiemKeGanNhat ?? DateTime.MinValue)
                .Select(p => new PhongThucHanhViewModel
                {
                    Id = p.Id,
                    MaPhong = p.MaPhong,
                    TenPhong = p.TenPhong,
                    ViTri = p.ViTri,
                    SucChua = p.SucChua,
                    SoMayHoatDong = p.SoMayHoatDong,
                    TrangThaiHoatDong = p.TrangThaiHoatDong,
                    DangHoatDong = p.TrangThaiHoatDong,
                    NgayKiemKeGanNhat = p.NgayKiemKeGanNhat,
                    TenNguoiKiemKe = p.NguoiKiemKe != null ? p.NguoiKiemKe.HoTen : null
                })
                .ToListAsync();

            return View(danhSach);
        }

        // POST: /QuanLyPhong/KiemKe/5
        [HttpPost]
        public async Task<IActionResult> KiemKe([FromBody] KiemKePhongViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return Json(new { success = false, message = "Không có quyền thực hiện kiểm kê" });
            }

            // Validate input
            if (model.SoMayHoatDong < 0)
            {
                return Json(new { success = false, message = "Số máy hoạt động không hợp lệ" });
            }

            var phong = await _context.PhongThucHanhs.FindAsync(model.PhongId);
            if (phong == null)
            {
                return Json(new { success = false, message = "Không tìm thấy phòng" });
            }

            // Validate số máy không vượt quá sức chứa
            if (model.SoMayHoatDong > phong.SucChua)
            {
                return Json(new { success = false, message = $"Số máy hoạt động không được vượt quá sức chứa ({phong.SucChua} máy)" });
            }

            phong.SoMayHoatDong = model.SoMayHoatDong;
            phong.TrangThaiHoatDong = model.TrangThaiHoatDong;
            phong.NgayKiemKeGanNhat = DateTime.Now;
            phong.NguoiKiemKeId = GetUserId();
            phong.NgayCapNhat = DateTime.Now;

            await _context.SaveChangesAsync();

            return Json(new { 
                success = true, 
                message = $"Đã kiểm kê phòng {phong.MaPhong} thành công!",
                data = new {
                    soMayHoatDong = phong.SoMayHoatDong,
                    trangThai = phong.TrangThaiHoatDong ? "Hoạt động" : "Ngừng",
                    ngayKiemKe = phong.NgayKiemKeGanNhat.Value.ToString("dd/MM/yyyy HH:mm")
                }
            });
        }

        // POST: /QuanLyPhong/Xoa/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Xoa(int id)
        {
            if (!KiemTraQuyen())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var phong = await _context.PhongThucHanhs.FindAsync(id);
            if (phong == null)
            {
                return Json(new { success = false, message = "Không tìm thấy phòng" });
            }

            // Kiểm tra có lịch không
            var coLich = await _context.LichThucHanhs.AnyAsync(l => l.PhongThucHanhId == id);
            if (coLich)
            {
                return Json(new { success = false, message = "Không thể xóa vì phòng đã có lịch thực hành" });
            }

            _context.PhongThucHanhs.Remove(phong);
            await _context.SaveChangesAsync();

            return Json(new { success = true, message = "Xóa phòng thành công!" });
        }

        private bool KiemTraQuyen()
        {
            return User.IsInRole(LoaiVaiTro.TrungTamDaoTaoThucHanh.ToString()) ||
                   User.IsInRole(LoaiVaiTro.Admin.ToString());
        }

        private int GetUserId()
        {
            return int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
        }
    }
}
