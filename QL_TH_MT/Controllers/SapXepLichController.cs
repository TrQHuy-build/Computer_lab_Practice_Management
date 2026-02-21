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
    /// Controller sắp xếp lịch thực hành - Phòng đào tạo
    /// Sử dụng trong Tuần 3: Sắp xếp lịch
    /// </summary>
    [Authorize]
    public class SapXepLichController : Controller
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;
        private readonly SapXepLichServiceNew _sapXepLichService;
        private readonly ThongBaoServiceNew _thongBaoService;

        public SapXepLichController(
            NewAppDbContext context,
            HocKyServiceNew hocKyService,
            SapXepLichServiceNew sapXepLichService,
            ThongBaoServiceNew thongBaoService)
        {
            _context = context;
            _hocKyService = hocKyService;
            _sapXepLichService = sapXepLichService;
            _thongBaoService = thongBaoService;
        }

        // GET: /SapXepLich
        public async Task<IActionResult> Index()
        {
            if (!KiemTraQuyenPDT())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            if (hocKy == null)
            {
                TempData["Error"] = "Chưa có học kỳ nào được kích hoạt";
                return RedirectToAction("Index", "TrangChu");
            }

            var giaiDoan = _hocKyService.XacDinhGiaiDoan(hocKy);
            var danhSachHocPhan = await _sapXepLichService.GetDanhSachHocPhanCanXepLich(hocKy.Id);

            // Lấy lịch đã xếp
            var lichDaXep = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                .Include(l => l.PhongThucHanh)
                .Where(l => l.HocKyId == hocKy.Id)
                .OrderBy(l => l.NgayThucHanh)
                .ThenBy(l => l.CaHoc)
                .ToListAsync();

            // Tính thống kê
            var tongHocPhan = danhSachHocPhan.Count;
            var hocPhanDaXep = lichDaXep.Select(l => l.HocPhanId).Distinct().Count();
            
            var viewModel = new SapXepLichViewModel
            {
                HocKyId = hocKy.Id,
                TenHocKy = hocKy.TenHocKy,
                DanhSachHocPhan = danhSachHocPhan,
                DanhSachPhong = await _context.PhongThucHanhs.Where(p => p.TrangThaiHoatDong).ToListAsync(),
                KetQuaXepLich = lichDaXep,
                ChoPhepXepLich = giaiDoan == GiaiDoanHocKy.Tuan3_SapXepLich,
                TongHocPhan = tongHocPhan,
                DaXepLich = hocPhanDaXep,
                ChuaXepLich = tongHocPhan - hocPhanDaXep
            };

            return View(viewModel);
        }

        // POST: /SapXepLich/TuDong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> TuDong()
        {
            if (!KiemTraQuyenPDT())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            if (!await _hocKyService.ChoPhepSapXepLich())
            {
                return Json(new { success = false, message = "Không trong giai đoạn sắp xếp lịch (Tuần 3)" });
            }

            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            if (hocKy == null)
            {
                return Json(new { success = false, message = "Không tìm thấy học kỳ" });
            }

            // Xóa lịch cũ (nếu có)
            var lichCu = await _context.LichThucHanhs
                .Where(l => l.HocKyId == hocKy.Id && l.TrangThai == 0)
                .ToListAsync();
            _context.LichThucHanhs.RemoveRange(lichCu);
            await _context.SaveChangesAsync();

            // Chạy thuật toán sắp xếp
            var ketQua = await _sapXepLichService.TuDongSapXepLich(hocKy.Id, GetUserId());

            return Json(new
            {
                success = ketQua.ThanhCong,
                message = ketQua.ThanhCong
                    ? $"Đã xếp lịch cho {ketQua.LichDaXep.Count} buổi thực hành"
                    : "Có lỗi khi xếp lịch",
                soLichXep = ketQua.LichDaXep.Count,
                canhBao = ketQua.CanhBao
            });
        }

        // GET: /SapXepLich/XemLich
        public async Task<IActionResult> XemLich(int? tuanHoc)
        {
            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            if (hocKy == null)
            {
                return PartialView("_BangLich", new LichTuanViewModel());
            }

            var lichThucHanh = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                    .ThenInclude(hp => hp!.GiangVien)
                .Include(l => l.PhongThucHanh)
                .Where(l => l.HocKyId == hocKy.Id && (!tuanHoc.HasValue || l.TuanHoc == tuanHoc))
                .ToListAsync();

            var viewModel = new LichTuanViewModel
            {
                TuanHoc = tuanHoc ?? 1,
                NgayDauTuan = hocKy.BatDauHocKy.AddDays((tuanHoc ?? 1 - 1) * 7),
                BangLich = new OLichViewModel[7, 6]
            };

            // Khởi tạo bảng lịch
            for (int thu = 0; thu < 7; thu++)
            {
                for (int ca = 0; ca < 6; ca++)
                {
                    viewModel.BangLich[thu, ca] = new OLichViewModel();
                }
            }

            // Điền dữ liệu
            foreach (var lich in lichThucHanh)
            {
                var thuIndex = lich.ThuTrongTuan - 2; // 2->0, 3->1, ...
                var caIndex = lich.CaHoc - 1;

                if (thuIndex >= 0 && thuIndex < 7 && caIndex >= 0 && caIndex < 6)
                {
                    viewModel.BangLich[thuIndex, caIndex] = new OLichViewModel
                    {
                        DaDangKy = true,
                        ThongTin = $"{lich.HocPhan?.TenHocPhan}\n{lich.PhongThucHanh?.TenPhong}",
                        LichThucHanhId = lich.Id
                    };
                }
            }

            return PartialView("_BangLich", viewModel);
        }

        // POST: /SapXepLich/GuiDuyet - Gửi lịch sang TTDT duyệt
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> GuiDuyet()
        {
            if (!KiemTraQuyenPDT())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            if (hocKy == null)
            {
                return Json(new { success = false, message = "Không tìm thấy học kỳ" });
            }

            // Cập nhật trạng thái lịch = 1 (Chờ TTDT duyệt)
            var lichCanDuyet = await _context.LichThucHanhs
                .Where(l => l.HocKyId == hocKy.Id && l.TrangThai == 0)
                .ToListAsync();

            foreach (var lich in lichCanDuyet)
            {
                lich.TrangThai = 1;
            }

            await _context.SaveChangesAsync();

            // Thông báo đến TTDT
            await _thongBaoService.GuiThongBaoTheoVaiTro(
                "Lịch thực hành cần duyệt",
                $"Có {lichCanDuyet.Count} lịch thực hành mới cần được xác nhận.",
                "YeuCauDuyet",
                LoaiVaiTro.TrungTamDaoTaoThucHanh,
                GetUserId(),
                "/LichThucHanh/DanhSachChoDuyet");

            return Json(new { success = true, message = $"Đã gửi {lichCanDuyet.Count} lịch sang TTDT duyệt!" });
        }

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
