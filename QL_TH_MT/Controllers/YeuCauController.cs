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
    /// Controller xử lý yêu cầu mượn bù và đổi phòng
    /// Sử dụng trong Tuần 4 và giai đoạn học kỳ
    /// </summary>
    [Authorize]
    public class YeuCauController : Controller
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;
        private readonly SapXepLichServiceNew _sapXepLichService;
        private readonly ThongBaoServiceNew _thongBaoService;

        public YeuCauController(
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

        #region Giảng viên - Tạo yêu cầu

        // GET: /YeuCau/MuonBu
        [HttpGet]
        public async Task<IActionResult> MuonBu()
        {
            var userId = GetUserId();

            if (!await _hocKyService.ChoPhepDoiLich())
            {
                TempData["Error"] = "Không trong giai đoạn cho phép thay đổi lịch";
                return RedirectToAction("Index", "TrangChu");
            }

            // Lấy danh sách lịch của GV
            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            var lichCuaToi = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                .Include(l => l.PhongThucHanh)
                .Where(l => l.HocKyId == hocKy!.Id
                    && l.HocPhan!.GiangVienId == userId
                    && l.TrangThai == 2 // Đã xác nhận
                    && l.NgayThucHanh >= DateTime.Today)
                .OrderBy(l => l.NgayThucHanh)
                .ToListAsync();

            ViewBag.DanhSachLich = lichCuaToi;

            return View(new YeuCauMuonBuViewModel());
        }

        // POST: /YeuCau/MuonBu
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> MuonBu(YeuCauMuonBuViewModel model)
        {
            var userId = GetUserId();

            if (!await _hocKyService.ChoPhepDoiLich())
            {
                TempData["Error"] = "Không trong giai đoạn cho phép thay đổi lịch";
                return RedirectToAction("Index", "TrangChu");
            }

            if (!ModelState.IsValid)
            {
                await LoadDanhSachLich(userId);
                return View(model);
            }

            // Kiểm tra ngày mới trong vòng 1 tuần
            var khoangCach = Math.Abs((model.NgayMoi - model.NgayGoc).TotalDays);
            if (khoangCach > 7)
            {
                ModelState.AddModelError("NgayMoi", "Ngày mới phải trong vòng 1 tuần so với ngày gốc");
                await LoadDanhSachLich(userId);
                return View(model);
            }

            // Kiểm tra xung đột lịch
            var lichGoc = await _context.LichThucHanhs.FindAsync(model.LichThucHanhGocId);
            if (lichGoc == null)
            {
                return NotFound();
            }

            var caHoc = model.CaHocMoi ?? lichGoc.CaHoc;
            if (await _sapXepLichService.KiemTraXungDot(model.NgayMoi, caHoc, lichGoc.PhongThucHanhId))
            {
                ModelState.AddModelError("NgayMoi", "Ngày/ca mới đã có lịch khác");
                await LoadDanhSachLich(userId);
                return View(model);
            }

            var yeuCau = new YeuCauMuonBuNew
            {
                LichThucHanhGocId = model.LichThucHanhGocId,
                GiangVienId = userId,
                NgayGoc = model.NgayGoc,
                NgayMoi = model.NgayMoi,
                CaHocMoi = model.CaHocMoi,
                LyDo = model.LyDo,
                TrangThai = 0, // Chờ PDT duyệt
                NgayTao = DateTime.Now
            };

            _context.YeuCauMuonBus.Add(yeuCau);
            await _context.SaveChangesAsync();

            // Thông báo đến PDT
            await _thongBaoService.ThongBaoYeuCauDuyet("mượn bù", yeuCau.Id, userId, LoaiVaiTro.PhongDaoTao);

            TempData["Success"] = "Gửi yêu cầu mượn bù thành công! Vui lòng chờ duyệt.";
            return RedirectToAction("DanhSachCuaToi");
        }

        // GET: /YeuCau/DoiPhong
        [HttpGet]
        public async Task<IActionResult> DoiPhong()
        {
            var userId = GetUserId();

            if (!await _hocKyService.ChoPhepDoiLich())
            {
                TempData["Error"] = "Không trong giai đoạn cho phép thay đổi lịch";
                return RedirectToAction("Index", "TrangChu");
            }

            await LoadDanhSachLich(userId);
            ViewBag.DanhSachPhong = await _context.PhongThucHanhs.Where(p => p.TrangThaiHoatDong).ToListAsync();

            return View(new YeuCauDoiPhongViewModel());
        }

        // POST: /YeuCau/DoiPhong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DoiPhong(YeuCauDoiPhongViewModel model)
        {
            var userId = GetUserId();

            if (!await _hocKyService.ChoPhepDoiLich())
            {
                TempData["Error"] = "Không trong giai đoạn cho phép thay đổi lịch";
                return RedirectToAction("Index", "TrangChu");
            }

            if (!ModelState.IsValid)
            {
                await LoadDanhSachLich(userId);
                ViewBag.DanhSachPhong = await _context.PhongThucHanhs.Where(p => p.TrangThaiHoatDong).ToListAsync();
                return View(model);
            }

            var lichGoc = await _context.LichThucHanhs.FindAsync(model.LichThucHanhGocId);
            if (lichGoc == null)
            {
                return NotFound();
            }

            // Kiểm tra xung đột
            var ngayMoi = model.NgayThucHanhMoi ?? lichGoc.NgayThucHanh;
            var caMoi = model.CaHocMoi ?? lichGoc.CaHoc;
            var phongMoi = model.PhongMoiId ?? lichGoc.PhongThucHanhId;

            if (await _sapXepLichService.KiemTraXungDot(ngayMoi, caMoi, phongMoi))
            {
                ModelState.AddModelError("", "Thời gian/phòng mới đã có lịch khác");
                await LoadDanhSachLich(userId);
                ViewBag.DanhSachPhong = await _context.PhongThucHanhs.Where(p => p.TrangThaiHoatDong).ToListAsync();
                return View(model);
            }

            var yeuCau = new YeuCauDoiPhongNew
            {
                LichThucHanhGocId = model.LichThucHanhGocId,
                GiangVienId = userId,
                NgayThucHanhGoc = lichGoc.NgayThucHanh,
                CaHocGoc = lichGoc.CaHoc,
                PhongGocId = lichGoc.PhongThucHanhId,
                NgayThucHanhMoi = model.NgayThucHanhMoi,
                CaHocMoi = model.CaHocMoi,
                PhongMoiId = model.PhongMoiId,
                LyDo = model.LyDo,
                TrangThai = 0,
                NgayTao = DateTime.Now
            };

            _context.YeuCauDoiPhongs.Add(yeuCau);
            await _context.SaveChangesAsync();

            await _thongBaoService.ThongBaoYeuCauDuyet("đổi phòng", yeuCau.Id, userId, LoaiVaiTro.PhongDaoTao);

            TempData["Success"] = "Gửi yêu cầu đổi phòng thành công!";
            return RedirectToAction("DanhSachCuaToi");
        }

        // GET: /YeuCau/DanhSachCuaToi
        public async Task<IActionResult> DanhSachCuaToi()
        {
            var userId = GetUserId();

            var muonBus = await _context.YeuCauMuonBus
                .Include(y => y.LichThucHanhGoc)
                    .ThenInclude(l => l!.HocPhan)
                .Where(y => y.GiangVienId == userId)
                .OrderByDescending(y => y.NgayTao)
                .ToListAsync();

            var doiPhongs = await _context.YeuCauDoiPhongs
                .Include(y => y.LichThucHanhGoc)
                    .ThenInclude(l => l!.HocPhan)
                .Include(y => y.PhongGoc)
                .Include(y => y.PhongMoi)
                .Where(y => y.GiangVienId == userId)
                .OrderByDescending(y => y.NgayTao)
                .ToListAsync();

            var viewModel = new DanhSachYeuCauViewModel
            {
                YeuCauMuonBus = muonBus,
                YeuCauDoiPhongs = doiPhongs
            };

            return View(viewModel);
        }

        #endregion

        #region PDT/TTDT - Duyệt yêu cầu

        // GET: /YeuCau/DanhSachChoDuyet
        public async Task<IActionResult> DanhSachChoDuyet()
        {
            if (!KiemTraQuyenDuyet())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var isPDT = User.IsInRole(LoaiVaiTro.PhongDaoTao.ToString());
            var isTTDT = User.IsInRole(LoaiVaiTro.TrungTamDaoTaoThucHanh.ToString());

            var muonBuQuery = _context.YeuCauMuonBus
                .Include(y => y.LichThucHanhGoc)
                    .ThenInclude(l => l!.HocPhan)
                .Include(y => y.GiangVien)
                .AsQueryable();

            var doiPhongQuery = _context.YeuCauDoiPhongs
                .Include(y => y.LichThucHanhGoc)
                    .ThenInclude(l => l!.HocPhan)
                .Include(y => y.GiangVien)
                .Include(y => y.PhongGoc)
                .AsQueryable();

            if (isPDT)
            {
                muonBuQuery = muonBuQuery.Where(y => y.TrangThai == 0); // Chờ PDT
                doiPhongQuery = doiPhongQuery.Where(y => y.TrangThai == 0);
            }
            else if (isTTDT)
            {
                muonBuQuery = muonBuQuery.Where(y => y.TrangThai == 1); // PDT đã duyệt, chờ TTDT
                doiPhongQuery = doiPhongQuery.Where(y => y.TrangThai == 1);
            }

            var viewModel = new DanhSachYeuCauViewModel
            {
                YeuCauMuonBus = await muonBuQuery.OrderBy(y => y.NgayTao).ToListAsync(),
                YeuCauDoiPhongs = await doiPhongQuery.OrderBy(y => y.NgayTao).ToListAsync()
            };

            return View(viewModel);
        }

        // POST: /YeuCau/DuyetMuonBu
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DuyetMuonBu(int id, bool duyet, string? ghiChu)
        {
            if (!KiemTraQuyenDuyet())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var yeuCau = await _context.YeuCauMuonBus
                .Include(y => y.LichThucHanhGoc)
                .FirstOrDefaultAsync(y => y.Id == id);

            if (yeuCau == null)
            {
                return Json(new { success = false, message = "Không tìm thấy yêu cầu" });
            }

            var userId = GetUserId();
            var isPDT = User.IsInRole(LoaiVaiTro.PhongDaoTao.ToString());

            if (isPDT && yeuCau.TrangThai == 0)
            {
                // PDT duyệt đầu tiên
                yeuCau.NguoiDuyetPDTId = userId;
                yeuCau.NgayDuyetPDT = DateTime.Now;
                yeuCau.KetQuaDuyetPDT = duyet;
                yeuCau.GhiChuPDT = ghiChu;
                yeuCau.TrangThai = duyet ? 1 : 3; // 1-Chờ TTDT, 3-Từ chối

                if (duyet)
                {
                    // Thông báo đến TTDT
                    await _thongBaoService.ThongBaoYeuCauDuyet("mượn bù", id, userId, LoaiVaiTro.TrungTamDaoTaoThucHanh);
                }
            }
            else if (!isPDT && yeuCau.TrangThai == 1)
            {
                // TTDT duyệt
                yeuCau.NguoiDuyetTTDTId = userId;
                yeuCau.NgayDuyetTTDT = DateTime.Now;
                yeuCau.KetQuaDuyetTTDT = duyet;
                yeuCau.GhiChuTTDT = ghiChu;
                yeuCau.TrangThai = duyet ? 2 : 3; // 2-Hoàn thành, 3-Từ chối

                if (duyet && yeuCau.LichThucHanhGoc != null)
                {
                    // Cập nhật lịch
                    yeuCau.LichThucHanhGoc.NgayThucHanh = yeuCau.NgayMoi;
                    if (yeuCau.CaHocMoi.HasValue)
                    {
                        yeuCau.LichThucHanhGoc.CaHoc = yeuCau.CaHocMoi.Value;
                    }
                }
            }

            await _context.SaveChangesAsync();

            // Thông báo đến giảng viên
            var tieuDe = duyet ? "Yêu cầu mượn bù được duyệt" : "Yêu cầu mượn bù bị từ chối";
            await _thongBaoService.GuiThongBao(tieuDe, ghiChu ?? "", "YeuCauDuyet", yeuCau.GiangVienId, userId);

            return Json(new { success = true, message = duyet ? "Đã duyệt!" : "Đã từ chối!" });
        }

        // POST: /YeuCau/DuyetDoiPhong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DuyetDoiPhong(int id, bool duyet, string? ghiChu)
        {
            if (!KiemTraQuyenDuyet())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var yeuCau = await _context.YeuCauDoiPhongs
                .Include(y => y.LichThucHanhGoc)
                .FirstOrDefaultAsync(y => y.Id == id);

            if (yeuCau == null)
            {
                return Json(new { success = false, message = "Không tìm thấy yêu cầu" });
            }

            var userId = GetUserId();
            var isPDT = User.IsInRole(LoaiVaiTro.PhongDaoTao.ToString());

            if (isPDT && yeuCau.TrangThai == 0)
            {
                yeuCau.NguoiDuyetPDTId = userId;
                yeuCau.NgayDuyetPDT = DateTime.Now;
                yeuCau.KetQuaDuyetPDT = duyet;
                yeuCau.GhiChuPDT = ghiChu;
                yeuCau.TrangThai = duyet ? 1 : 3;

                if (duyet)
                {
                    await _thongBaoService.ThongBaoYeuCauDuyet("đổi phòng", id, userId, LoaiVaiTro.TrungTamDaoTaoThucHanh);
                }
            }
            else if (!isPDT && yeuCau.TrangThai == 1)
            {
                yeuCau.NguoiDuyetTTDTId = userId;
                yeuCau.NgayDuyetTTDT = DateTime.Now;
                yeuCau.KetQuaDuyetTTDT = duyet;
                yeuCau.GhiChuTTDT = ghiChu;
                yeuCau.TrangThai = duyet ? 2 : 3;

                if (duyet && yeuCau.LichThucHanhGoc != null)
                {
                    // Cập nhật lịch
                    if (yeuCau.NgayThucHanhMoi.HasValue)
                        yeuCau.LichThucHanhGoc.NgayThucHanh = yeuCau.NgayThucHanhMoi.Value;
                    if (yeuCau.CaHocMoi.HasValue)
                        yeuCau.LichThucHanhGoc.CaHoc = yeuCau.CaHocMoi.Value;
                    if (yeuCau.PhongMoiId.HasValue)
                        yeuCau.LichThucHanhGoc.PhongThucHanhId = yeuCau.PhongMoiId.Value;
                }
            }

            await _context.SaveChangesAsync();

            var tieuDe = duyet ? "Yêu cầu đổi phòng được duyệt" : "Yêu cầu đổi phòng bị từ chối";
            await _thongBaoService.GuiThongBao(tieuDe, ghiChu ?? "", "YeuCauDuyet", yeuCau.GiangVienId, userId);

            return Json(new { success = true, message = duyet ? "Đã duyệt!" : "Đã từ chối!" });
        }

        #endregion

        #region Helper

        private async Task LoadDanhSachLich(int userId)
        {
            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            ViewBag.DanhSachLich = await _context.LichThucHanhs
                .Include(l => l.HocPhan)
                .Include(l => l.PhongThucHanh)
                .Where(l => l.HocKyId == hocKy!.Id
                    && l.HocPhan!.GiangVienId == userId
                    && l.TrangThai == 2
                    && l.NgayThucHanh >= DateTime.Today)
                .OrderBy(l => l.NgayThucHanh)
                .ToListAsync();
        }

        private bool KiemTraQuyenDuyet()
        {
            return User.IsInRole(LoaiVaiTro.PhongDaoTao.ToString()) ||
                   User.IsInRole(LoaiVaiTro.TrungTamDaoTaoThucHanh.ToString()) ||
                   User.IsInRole(LoaiVaiTro.Admin.ToString());
        }

        private int GetUserId()
        {
            return int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
        }

        public static string GetTrangThaiYeuCau(int trangThai)
        {
            return trangThai switch
            {
                0 => "Chờ PDT duyệt",
                1 => "Chờ TTDT duyệt",
                2 => "Đã hoàn thành",
                3 => "Bị từ chối",
                _ => "Không xác định"
            };
        }

        #endregion
    }
}
