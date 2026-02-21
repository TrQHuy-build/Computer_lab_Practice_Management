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
    /// Controller xem và duyệt lịch thực hành
    /// </summary>
    [Authorize]
    public class LichThucHanhController : Controller
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;
        private readonly ThongBaoServiceNew _thongBaoService;

        public LichThucHanhController(NewAppDbContext context, HocKyServiceNew hocKyService, ThongBaoServiceNew thongBaoService)
        {
            _context = context;
            _hocKyService = hocKyService;
            _thongBaoService = thongBaoService;
        }

        // GET: /LichThucHanh - Xem tất cả lịch
        public async Task<IActionResult> Index(int? hocKyId, int? giangVienId, int? phongId, int? tuanHoc)
        {
            var hocKy = hocKyId.HasValue
                ? await _context.HocKys.FindAsync(hocKyId)
                : await _hocKyService.GetHocKyHienTaiAsync();

            if (hocKy == null)
            {
                TempData["Error"] = "Chưa có học kỳ";
                return View(new DanhSachLichThucHanhViewModel());
            }

            var query = _context.LichThucHanhs
                .Include(l => l.HocPhan)
                    .ThenInclude(hp => hp!.GiangVien)
                .Include(l => l.PhongThucHanh)
                .Where(l => l.HocKyId == hocKy.Id);

            if (giangVienId.HasValue)
            {
                query = query.Where(l => l.HocPhan!.GiangVienId == giangVienId);
            }

            if (phongId.HasValue)
            {
                query = query.Where(l => l.PhongThucHanhId == phongId);
            }

            if (tuanHoc.HasValue)
            {
                query = query.Where(l => l.TuanHoc == tuanHoc);
            }

            var danhSach = await query
                .OrderBy(l => l.NgayThucHanh)
                .ThenBy(l => l.CaHoc)
                .ToListAsync();

            var viewModel = new DanhSachLichThucHanhViewModel
            {
                HocKyId = hocKy.Id,
                TenHocKy = hocKy.TenHocKy,
                GiangVienId = giangVienId,
                PhongId = phongId,
                TuanHoc = tuanHoc,
                DanhSachLich = danhSach,
                DanhSachGiangVien = await _context.TaiKhoans
                    .Where(t => t.VaiTro == LoaiVaiTro.GiangVien && t.TrangThaiHoatDong)
                    .ToListAsync(),
                DanhSachPhong = await _context.PhongThucHanhs.Where(p => p.TrangThaiHoatDong).ToListAsync()
            };

            // Dropdown học kỳ
            ViewBag.DanhSachHocKy = await _context.HocKys.OrderByDescending(h => h.NgayTao).ToListAsync();

            return View(viewModel);
        }

        // GET: /LichThucHanh/CuaToi - Lịch của giảng viên hiện tại
        public async Task<IActionResult> CuaToi()
        {
            var userId = GetUserId();
            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();

            if (hocKy == null)
            {
                TempData["Error"] = "Chưa có học kỳ";
                return View("Index", new DanhSachLichThucHanhViewModel());
            }

            var danhSach = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                    .ThenInclude(hp => hp!.MonHoc)
                .Include(l => l.PhongThucHanh)
                .Where(l => l.HocKyId == hocKy.Id && l.HocPhan!.GiangVienId == userId)
                .OrderBy(l => l.NgayThucHanh)
                .ThenBy(l => l.CaHoc)
                .ToListAsync();

            ViewBag.TieuDe = "Lịch giảng dạy của tôi";

            return View("DanhSachCuaToi", danhSach);
        }

        // GET: /LichThucHanh/ChiTiet/5
        public async Task<IActionResult> ChiTiet(int id)
        {
            var lich = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                    .ThenInclude(hp => hp!.MonHoc)
                .Include(l => l.HocPhan)
                    .ThenInclude(hp => hp!.GiangVien)
                .Include(l => l.PhongThucHanh)
                .Include(l => l.HocKy)
                .Include(l => l.NguoiTao)
                .Include(l => l.NguoiDuyetTTDT)
                .FirstOrDefaultAsync(l => l.Id == id);

            if (lich == null)
            {
                return NotFound();
            }

            return View(lich);
        }

        #region TTDT - Duyệt lịch

        // GET: /LichThucHanh/DanhSachChoDuyet
        public async Task<IActionResult> DanhSachChoDuyet()
        {
            if (!KiemTraQuyenTTDT())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            if (hocKy == null)
            {
                return View(new List<LichChoDuyetViewModel>());
            }

            var danhSach = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                    .ThenInclude(hp => hp!.GiangVien)
                .Include(l => l.PhongThucHanh)
                .Where(l => l.HocKyId == hocKy.Id && l.TrangThai == 1) // Chờ TTDT duyệt
                .OrderBy(l => l.NgayThucHanh)
                .ThenBy(l => l.CaHoc)
                .Select(l => new LichChoDuyetViewModel
                {
                    Id = l.Id,
                    MaHocPhan = l.HocPhan != null ? l.HocPhan.MaHocPhan : "",
                    TenGiangVien = l.HocPhan != null && l.HocPhan.GiangVien != null ? l.HocPhan.GiangVien.HoTen : "",
                    LoaiGV = l.HocPhan != null && l.HocPhan.GiangVien != null && l.HocPhan.GiangVien.LoaiGiangVien.HasValue 
                        ? (l.HocPhan.GiangVien.LoaiGiangVien.Value == LoaiGiangVien.ThinhGiang ? "TG" : "CH") : "",
                    TenPhong = l.PhongThucHanh != null ? l.PhongThucHanh.TenPhong : "",
                    Thu = l.ThuTrongTuan,
                    Ca = l.CaHoc,
                    Tuan = l.TuanHoc,
                    NgayGui = l.NgayTao
                })
                .ToListAsync();

            return View(danhSach);
        }

        // POST: /LichThucHanh/DuyetTatCa
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DuyetTatCa()
        {
            if (!KiemTraQuyenTTDT())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            if (hocKy == null)
            {
                return Json(new { success = false, message = "Không tìm thấy học kỳ" });
            }

            var lichCanDuyet = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                .Where(l => l.HocKyId == hocKy.Id && l.TrangThai == 1)
                .ToListAsync();

            var userId = GetUserId();
            var now = DateTime.Now;

            // Nhóm theo giảng viên để gửi thông báo
            var nhomTheoGV = new Dictionary<int, List<LichThucHanhNew>>();

            foreach (var lich in lichCanDuyet)
            {
                lich.TrangThai = 2; // Đã duyệt
                lich.NguoiDuyetTTDTId = userId;
                lich.NgayDuyetTTDT = now;

                if (lich.HocPhan?.GiangVienId.HasValue == true)
                {
                    var gvId = lich.HocPhan.GiangVienId.Value;
                    if (!nhomTheoGV.ContainsKey(gvId))
                    {
                        nhomTheoGV[gvId] = new List<LichThucHanhNew>();
                    }
                    nhomTheoGV[gvId].Add(lich);
                }
            }

            await _context.SaveChangesAsync();

            // Gửi thông báo đến từng giảng viên
            foreach (var kvp in nhomTheoGV)
            {
                var gvId = kvp.Key;
                var lichs = kvp.Value;

                var tieuDe = "Lịch thực hành đã được xác nhận";
                var noiDung = $"Có {lichs.Count} lịch thực hành của bạn đã được TTDT xác nhận. Vui lòng kiểm tra lịch.";

                await _thongBaoService.GuiThongBao(tieuDe, noiDung, "LichThucHanh", gvId, userId, "/LichThucHanh/CuaToi");
            }

            return Json(new { success = true, message = $"Đã duyệt {lichCanDuyet.Count} lịch thực hành!" });
        }

        // POST: /LichThucHanh/Duyet/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Duyet(int id, bool duyet, string? ghiChu)
        {
            if (!KiemTraQuyenTTDT())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var lich = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                .FirstOrDefaultAsync(l => l.Id == id);

            if (lich == null)
            {
                return Json(new { success = false, message = "Không tìm thấy lịch" });
            }

            lich.TrangThai = duyet ? 2 : 4; // 2-Duyệt, 4-Hủy
            lich.NguoiDuyetTTDTId = GetUserId();
            lich.NgayDuyetTTDT = DateTime.Now;
            lich.GhiChu = duyet ? lich.GhiChu : ghiChu;

            await _context.SaveChangesAsync();

            // Thông báo đến giảng viên
            if (lich.HocPhan?.GiangVienId.HasValue == true)
            {
                var tieuDe = duyet ? "Lịch thực hành được xác nhận" : "Lịch thực hành bị hủy";
                var noiDung = duyet
                    ? "Lịch thực hành của bạn đã được TTDT xác nhận."
                    : $"Lịch thực hành của bạn đã bị hủy. Lý do: {ghiChu}";

                await _thongBaoService.GuiThongBao(tieuDe, noiDung, "LichThucHanh",
                    lich.HocPhan.GiangVienId.Value, GetUserId());
            }

            return Json(new { success = true, message = duyet ? "Đã duyệt!" : "Đã hủy!" });
        }

        #endregion

        #region Helper

        private bool KiemTraQuyenTTDT()
        {
            return User.IsInRole(LoaiVaiTro.TrungTamDaoTaoThucHanh.ToString()) ||
                   User.IsInRole(LoaiVaiTro.Admin.ToString());
        }

        private int GetUserId()
        {
            return int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
        }

        public static string GetTenThu(int thu)
        {
            return thu switch
            {
                2 => "Thứ 2",
                3 => "Thứ 3",
                4 => "Thứ 4",
                5 => "Thứ 5",
                6 => "Thứ 6",
                7 => "Thứ 7",
                8 => "Chủ nhật",
                _ => $"Thứ {thu}"
            };
        }

        public static string GetTenCa(int ca)
        {
            return ca switch
            {
                1 => "Ca 1 (7h00-9h30)",
                2 => "Ca 2 (9h30-12h00)",
                3 => "Ca 3 (12h30-15h00)",
                4 => "Ca 4 (15h00-17h30)",
                5 => "Ca 5 (17h30-20h00)",
                6 => "Ca 6 (20h00-22h30)",
                _ => $"Ca {ca}"
            };
        }

        public static string GetTrangThaiLich(int trangThai)
        {
            return trangThai switch
            {
                0 => "Dự kiến",
                1 => "Chờ TTDT duyệt",
                2 => "Đã xác nhận",
                3 => "Hoàn thành",
                4 => "Đã hủy",
                _ => "Không xác định"
            };
        }

        #endregion
    }
}
