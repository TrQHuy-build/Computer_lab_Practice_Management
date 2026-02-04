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
    /// Controller đăng ký lịch giảng dạy - Giảng viên thỉnh giảng
    /// Sử dụng trong Tuần 2: Đăng ký lịch
    /// </summary>
    [Authorize]
    public class DangKyLichController : Controller
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;
        private readonly ThongBaoServiceNew _thongBaoService;

        public DangKyLichController(NewAppDbContext context, HocKyServiceNew hocKyService, ThongBaoServiceNew thongBaoService)
        {
            _context = context;
            _hocKyService = hocKyService;
            _thongBaoService = thongBaoService;
        }

        // GET: /DangKyLich - Danh sách hợp đồng cần đăng ký
        public async Task<IActionResult> Index()
        {
            var userId = GetUserId();
            var user = await _context.TaiKhoans.FindAsync(userId);

            // Kiểm tra phải là GV thỉnh giảng
            if (user?.LoaiGiangVien != LoaiGiangVien.ThinhGiang)
            {
                TempData["Error"] = "Chỉ giảng viên thỉnh giảng mới cần đăng ký lịch";
                return RedirectToAction("Index", "TrangChu");
            }

            // Kiểm tra giai đoạn
            if (!await _hocKyService.ChoPhepDangKyLich())
            {
                TempData["Warning"] = "Không trong giai đoạn đăng ký lịch (Tuần 2)";
            }

            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            if (hocKy == null)
            {
                TempData["Error"] = "Chưa có học kỳ nào được kích hoạt";
                return RedirectToAction("Index", "TrangChu");
            }

            // Lấy các hợp đồng của GV
            var hopDongs = await _context.HopDongs
                .Include(h => h.HopDongMonHocs)
                    .ThenInclude(m => m.MonHoc)
                .Include(h => h.DangKyLichs)
                .Where(h => h.GiangVienId == userId && h.HocKyId == hocKy.Id && h.TrangThai == 1)
                .ToListAsync();

            ViewBag.HocKy = hocKy;
            ViewBag.ChoPhepDangKy = await _hocKyService.ChoPhepDangKyLich();

            return View(hopDongs);
        }

        // GET: /DangKyLich/Form/5 - Form đăng ký cho 1 hợp đồng
        [HttpGet]
        public async Task<IActionResult> Form(int hopDongId)
        {
            if (!await _hocKyService.ChoPhepDangKyLich())
            {
                TempData["Error"] = "Không trong giai đoạn đăng ký lịch";
                return RedirectToAction("Index");
            }

            var userId = GetUserId();
            var hopDong = await _context.HopDongs
                .Include(h => h.HopDongMonHocs)
                    .ThenInclude(m => m.MonHoc)
                .Include(h => h.HocKy)
                .FirstOrDefaultAsync(h => h.Id == hopDongId && h.GiangVienId == userId);

            if (hopDong == null)
            {
                return NotFound();
            }

            var firstMonHoc = hopDong.HopDongMonHocs?.FirstOrDefault()?.MonHoc;

            var viewModel = new FormDangKyLichViewModel
            {
                HopDongId = hopDong.Id,
                TenMonHoc = firstMonHoc?.TenMonHoc ?? "",
                TenHocKy = hopDong.HocKy?.TenHocKy ?? "",
                SoHocPhan = hopDong.HopDongMonHocs?.Count ?? 0,
                DanhSachCa = new List<CaDangKyViewModel>()
            };

            // Mỗi học phần cần 1 bộ ca (3 tuần liên tiếp cùng ngày, cùng ca)
            int soHocPhan = hopDong.HopDongMonHocs?.Count ?? 0;
            for (int i = 0; i < soHocPhan; i++)
            {
                viewModel.DanhSachCa.Add(new CaDangKyViewModel());
            }

            return View(viewModel);
        }

        // POST: /DangKyLich/Form
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Form(FormDangKyLichViewModel model)
        {
            if (!await _hocKyService.ChoPhepDangKyLich())
            {
                TempData["Error"] = "Không trong giai đoạn đăng ký lịch";
                return RedirectToAction("Index");
            }

            var userId = GetUserId();
            var hopDong = await _context.HopDongs
                .Include(h => h.HocKy)
                .FirstOrDefaultAsync(h => h.Id == model.HopDongId && h.GiangVienId == userId);

            if (hopDong == null)
            {
                return NotFound();
            }

            if (!ModelState.IsValid || model.DanhSachCa == null || !model.DanhSachCa.Any())
            {
                return View(model);
            }

            // Xóa đăng ký cũ (nếu có)
            var dangKyCu = await _context.DangKyLichThinhGiangs
                .Where(d => d.HopDongId == model.HopDongId)
                .ToListAsync();
            _context.DangKyLichThinhGiangs.RemoveRange(dangKyCu);

            // Thêm đăng ký mới
            foreach (var ca in model.DanhSachCa)
            {
                if (ca.ThuTrongTuan >= 2 && ca.ThuTrongTuan <= 8 && ca.CaHoc >= 1 && ca.CaHoc <= 6)
                {
                    var dangKy = new DangKyLichThinhGiangNew
                    {
                        HopDongId = model.HopDongId,
                        GiangVienId = userId,
                        HocKyId = hopDong.HocKyId,
                        ThuTrongTuan = ca.ThuTrongTuan,
                        CaHoc = ca.CaHoc,
                        TuanBatDau = ca.TuanBatDau,
                        SoTuanLienTiep = 3,
                        GhiChu = ca.GhiChu,
                        TrangThai = 0, // Chờ duyệt
                        NgayDangKy = DateTime.Now
                    };

                    _context.DangKyLichThinhGiangs.Add(dangKy);
                }
            }

            await _context.SaveChangesAsync();

            // Thông báo đến Phòng đào tạo
            await _thongBaoService.ThongBaoYeuCauDuyet("đăng ký lịch", model.HopDongId, userId, LoaiVaiTro.PhongDaoTao);

            TempData["Success"] = "Đăng ký lịch thành công! Vui lòng chờ Phòng đào tạo xác nhận.";
            return RedirectToAction("Index");
        }

        // GET: /DangKyLich/ChiTiet/5
        public async Task<IActionResult> ChiTiet(int id)
        {
            var dangKy = await _context.DangKyLichThinhGiangs
                .Include(d => d.HopDong)
                    .ThenInclude(h => h!.HopDongMonHocs)
                        .ThenInclude(m => m.MonHoc)
                .Include(d => d.GiangVien)
                .Include(d => d.NguoiDuyet)
                .FirstOrDefaultAsync(d => d.Id == id);

            if (dangKy == null)
            {
                return NotFound();
            }

            return View(dangKy);
        }

        #region Phòng đào tạo - Duyệt đăng ký

        // GET: /DangKyLich/DanhSachChoDuyet
        public async Task<IActionResult> DanhSachChoDuyet()
        {
            if (!KiemTraQuyenPDT())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            if (hocKy == null)
            {
                return View(new List<DangKyLichThinhGiangNew>());
            }

            var danhSach = await _context.DangKyLichThinhGiangs
                .Include(d => d.HopDong)
                    .ThenInclude(h => h!.HopDongMonHocs)
                        .ThenInclude(m => m.MonHoc)
                .Include(d => d.GiangVien)
                .Where(d => d.HocKyId == hocKy.Id && d.TrangThai == 0)
                .OrderBy(d => d.NgayDangKy)
                .ToListAsync();

            return View(danhSach);
        }

        // POST: /DangKyLich/Duyet/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Duyet(int id, bool duyet, string? ghiChu)
        {
            if (!KiemTraQuyenPDT())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var dangKy = await _context.DangKyLichThinhGiangs
                .Include(d => d.GiangVien)
                .FirstOrDefaultAsync(d => d.Id == id);

            if (dangKy == null)
            {
                return Json(new { success = false, message = "Không tìm thấy đăng ký" });
            }

            dangKy.TrangThai = duyet ? 1 : 2; // 1-Duyệt, 2-Từ chối
            dangKy.NguoiDuyetId = GetUserId();
            dangKy.NgayDuyet = DateTime.Now;
            dangKy.LyDoTuChoi = duyet ? null : ghiChu;

            await _context.SaveChangesAsync();

            // Thông báo đến giảng viên
            var tieuDe = duyet ? "Đăng ký lịch được duyệt" : "Đăng ký lịch bị từ chối";
            var noiDung = duyet
                ? "Đăng ký lịch giảng dạy của bạn đã được Phòng đào tạo chấp thuận."
                : $"Đăng ký lịch giảng dạy của bạn đã bị từ chối. Lý do: {ghiChu}";

            await _thongBaoService.GuiThongBao(tieuDe, noiDung, "YeuCauDuyet", dangKy.GiangVienId, GetUserId());

            return Json(new { success = true, message = duyet ? "Đã duyệt!" : "Đã từ chối!" });
        }

        #endregion

        #region Helper

        private bool KiemTraQuyenPDT()
        {
            return User.IsInRole(LoaiVaiTro.PhongDaoTao.ToString()) ||
                   User.IsInRole(LoaiVaiTro.Admin.ToString());
        }

        private int GetUserId()
        {
            return int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
        }

        #endregion
    }
}
