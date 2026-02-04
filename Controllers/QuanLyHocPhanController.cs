using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using QL_TH_MT.Data;
using QL_TH_MT.Models;
using QL_TH_MT.ViewModels;
using QL_TH_MT.Services;

namespace QL_TH_MT.Controllers
{
    /// <summary>
    /// Controller quản lý học phần - Phòng đào tạo
    /// </summary>
    [Authorize]
    public class QuanLyHocPhanController : Controller
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;

        public QuanLyHocPhanController(NewAppDbContext context, HocKyServiceNew hocKyService)
        {
            _context = context;
            _hocKyService = hocKyService;
        }

        // GET: /QuanLyHocPhan
        public async Task<IActionResult> Index(int? hocKyId)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocKy = hocKyId.HasValue
                ? await _context.HocKys.FindAsync(hocKyId)
                : await _hocKyService.GetHocKyHienTaiAsync();

            if (hocKy == null)
            {
                TempData["Error"] = "Chưa có học kỳ";
                return RedirectToAction("Index", "QuanLyHocKy");
            }

            var hocPhans = await _context.HocPhans
                .Include(hp => hp.MonHoc)
                .Include(hp => hp.GiangVien)
                .Where(hp => hp.HocKyId == hocKy.Id)
                .OrderBy(hp => hp.MaHocPhan)
                .ToListAsync();

            var danhSach = hocPhans.Select(hp => new HocPhanViewModel
            {
                Id = hp.Id,
                MaHocPhan = hp.MaHocPhan,
                TenMonHoc = hp.MonHoc?.TenMonHoc ?? "",
                TenGiangVien = hp.GiangVien?.HoTen ?? "Chưa phân công",
                LoaiGiangVien = hp.GiangVien?.LoaiGiangVien?.ToString() ?? "",
                TenHocKy = hocKy.TenHocKy,
                SiSo = hp.SiSo,
                TrangThaiHoatDong = hp.TrangThaiHoatDong
            }).ToList();

            ViewBag.HocKy = hocKy;
            ViewBag.DanhSachHocKy = await _context.HocKys.OrderByDescending(h => h.NgayTao).ToListAsync();

            return View(danhSach);
        }

        // GET: /QuanLyHocPhan/Tao
        [HttpGet]
        public async Task<IActionResult> Tao()
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var model = new HocPhanCreateViewModel();
            await LoadDropdowns(model);
            return View(model);
        }

        // POST: /QuanLyHocPhan/Tao
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Tao(HocPhanCreateViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            if (!ModelState.IsValid)
            {
                await LoadDropdowns(model);
                return View(model);
            }

            if (await _context.HocPhans.AnyAsync(hp => hp.MaHocPhan == model.MaHocPhan))
            {
                ModelState.AddModelError("MaHocPhan", "Mã học phần đã tồn tại");
                await LoadDropdowns(model);
                return View(model);
            }

            // Lấy tên môn học để tạo tên học phần
            var monHoc = await _context.MonHocs.FindAsync(model.MonHocId);
            var tenHocPhan = monHoc != null 
                ? monHoc.TenMonHoc + (string.IsNullOrEmpty(model.Nhom) ? "" : " - Nhóm " + model.Nhom)
                : model.MaHocPhan;

            var hocPhan = new HocPhanNew
            {
                MaHocPhan = model.MaHocPhan,
                TenHocPhan = tenHocPhan,
                Nhom = model.Nhom,
                SiSo = model.SiSo,
                MonHocId = model.MonHocId,
                HocKyId = model.HocKyId,
                GiangVienId = model.GiangVienId,
                TrangThaiHoatDong = true,
                NgayTao = DateTime.Now
            };

            _context.HocPhans.Add(hocPhan);
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Tạo học phần {model.MaHocPhan} thành công!";
            return RedirectToAction("Index");
        }

        // GET: /QuanLyHocPhan/Sua/5
        [HttpGet]
        public async Task<IActionResult> Sua(int id)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocPhan = await _context.HocPhans.FindAsync(id);
            if (hocPhan == null)
            {
                return NotFound();
            }

            var model = new HocPhanViewModel
            {
                Id = hocPhan.Id,
                MaHocPhan = hocPhan.MaHocPhan,
                TenHocPhan = hocPhan.TenHocPhan,
                Nhom = hocPhan.Nhom,
                SiSo = hocPhan.SiSo,
                MonHocId = hocPhan.MonHocId,
                HocKyId = hocPhan.HocKyId,
                GiangVienId = hocPhan.GiangVienId
            };

            await LoadDropdowns();
            return View(model);
        }

        // POST: /QuanLyHocPhan/Sua/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Sua(int id, HocPhanViewModel model)
        {
            if (!KiemTraQuyen())
            {
                return RedirectToAction("TuChoiTruyCap", "TaiKhoan");
            }

            var hocPhan = await _context.HocPhans.FindAsync(id);
            if (hocPhan == null)
            {
                return NotFound();
            }

            if (!ModelState.IsValid)
            {
                await LoadDropdowns();
                return View(model);
            }

            hocPhan.TenHocPhan = model.TenHocPhan;
            hocPhan.Nhom = model.Nhom;
            hocPhan.SiSo = model.SiSo;
            hocPhan.MonHocId = model.MonHocId;
            hocPhan.HocKyId = model.HocKyId;
            hocPhan.GiangVienId = model.GiangVienId;

            await _context.SaveChangesAsync();

            TempData["Success"] = "Cập nhật học phần thành công!";
            return RedirectToAction("Index");
        }

        // POST: /QuanLyHocPhan/TaoTuHopDong - Tạo học phần từ hợp đồng
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> TaoTuHopDong()
        {
            try
            {
                if (!KiemTraQuyen())
                {
                    return Json(new { success = false, message = "Không có quyền" });
                }

                var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
                if (hocKy == null)
                {
                    return Json(new { success = false, message = "Không có học kỳ hiện tại. Vui lòng kích hoạt một học kỳ trước." });
                }

                // Đếm hợp đồng theo trạng thái
                var tongHopDong = await _context.HopDongs.CountAsync(h => h.HocKyId == hocKy.Id);
                var hopDongChuaDuyet = await _context.HopDongs.CountAsync(h => h.HocKyId == hocKy.Id && h.TrangThai == 0);

                // Lấy tất cả hợp đồng đã duyệt trong học kỳ
                var hopDongs = await _context.HopDongs
                    .Include(h => h.GiangVien)
                    .Include(h => h.HopDongMonHocs)
                        .ThenInclude(m => m.MonHoc)
                    .Where(h => h.HocKyId == hocKy.Id && h.TrangThai == 1)
                    .ToListAsync();

                if (!hopDongs.Any())
                {
                    if (tongHopDong == 0)
                    {
                        return Json(new { success = false, message = $"Không có hợp đồng nào trong học kỳ '{hocKy.TenHocKy}'. Vui lòng tạo hợp đồng trước." });
                    }
                    else
                    {
                        return Json(new { success = false, message = $"Có {hopDongChuaDuyet} hợp đồng chưa duyệt trong học kỳ '{hocKy.TenHocKy}'. Vui lòng duyệt hợp đồng trước khi tạo học phần." });
                    }
                }

                // Lấy danh sách mã học phần đã tồn tại để tránh trùng
                var maHocPhanDaTonTai = await _context.HocPhans
                    .Where(hp => hp.HocKyId == hocKy.Id)
                    .Select(hp => hp.MaHocPhan)
                    .ToListAsync();

                // Lấy danh sách cặp (GiangVienId, MonHocId) đã tồn tại trong học kỳ này
                // 1 GV chỉ được dạy 1 lớp học phần của 1 môn trong 1 kỳ
                var giangVienMonHocDaTonTai = await _context.HocPhans
                    .Where(hp => hp.HocKyId == hocKy.Id && hp.GiangVienId != null)
                    .Select(hp => new { hp.GiangVienId, hp.MonHocId })
                    .ToListAsync();

                // Dictionary để đếm số nhóm mới thêm trong vòng lặp này
                var demNhomMoi = new Dictionary<int, int>(); // MonHocId -> số nhóm đã thêm
                
                // HashSet để track cặp (GiangVienId, MonHocId) đã thêm trong batch này
                var giangVienMonHocMoi = new HashSet<(int?, int)>();

                int soHocPhanTao = 0;
                int soHocPhanDaTonTai = 0;
                int hopDongKhongCoMonHoc = 0;
                int giangVienDaDayMon = 0;
                var danhSachHocPhanMoi = new List<HocPhanNew>();

                foreach (var hd in hopDongs)
                {
                    var monHocs = hd.HopDongMonHocs?.ToList() ?? new List<HopDongMonHocNew>();
                    if (!monHocs.Any())
                    {
                        hopDongKhongCoMonHoc++;
                        continue;
                    }

                    foreach (var hdmh in monHocs)
                    {
                        var monHoc = hdmh.MonHoc;
                        if (monHoc == null) continue;

                        // Kiểm tra GV đã dạy môn này trong kỳ chưa (trong DB hoặc batch này)
                        var daDayTrongDB = giangVienMonHocDaTonTai.Any(x => 
                            x.GiangVienId == hd.GiangVienId && x.MonHocId == monHoc.Id);
                        var daDayTrongBatch = giangVienMonHocMoi.Contains((hd.GiangVienId, monHoc.Id));
                        
                        if (daDayTrongDB || daDayTrongBatch)
                        {
                            giangVienDaDayMon++;
                            continue; // 1 GV chỉ được dạy 1 lớp của 1 môn trong 1 kỳ
                        }

                        // Đếm số nhóm hiện tại trong DB cho môn học này
                        var soNhomTrongDB = await _context.HocPhans
                            .Where(hp => hp.MonHocId == monHoc.Id && hp.HocKyId == hocKy.Id)
                            .CountAsync();

                        // Cộng thêm số nhóm đã thêm trong vòng lặp này
                        if (!demNhomMoi.ContainsKey(monHoc.Id))
                            demNhomMoi[monHoc.Id] = 0;

                        var nhomMoi = (soNhomTrongDB + demNhomMoi[monHoc.Id] + 1).ToString("D2");

                        // Tạo mã học phần unique
                        var maGV = hd.GiangVien?.Id.ToString("D2") ?? "00";
                        var maHocPhan = $"{monHoc.MaMonHoc}_HK{hocKy.SoHocKy}_{nhomMoi}_GV{maGV}";

                        // Kiểm tra mã học phần đã tồn tại trong DB hoặc trong batch này chưa
                        if (maHocPhanDaTonTai.Contains(maHocPhan) || 
                            danhSachHocPhanMoi.Any(hp => hp.MaHocPhan == maHocPhan))
                        {
                            soHocPhanDaTonTai++;
                            continue;
                        }

                        var tenGiangVien = hd.GiangVien?.HoTen ?? "Chưa phân công";
                        var hocPhan = new HocPhanNew
                        {
                            MaHocPhan = maHocPhan,
                            TenHocPhan = $"{monHoc.TenMonHoc} - Nhóm {nhomMoi} ({tenGiangVien})",
                            Nhom = nhomMoi,
                            SiSo = 40,
                            MonHocId = hdmh.MonHocId,
                            HocKyId = hocKy.Id,
                            GiangVienId = hd.GiangVienId,
                            TrangThaiHoatDong = true,
                            NgayTao = DateTime.Now
                        };

                        danhSachHocPhanMoi.Add(hocPhan);
                        demNhomMoi[monHoc.Id]++;
                        giangVienMonHocMoi.Add((hd.GiangVienId, monHoc.Id)); // Track cặp GV-MonHoc
                        soHocPhanTao++;
                    }
                }

                // Thêm tất cả học phần mới vào context
                if (danhSachHocPhanMoi.Any())
                {
                    _context.HocPhans.AddRange(danhSachHocPhanMoi);
                    await _context.SaveChangesAsync();
                }

                var message = "";
                if (soHocPhanTao > 0)
                {
                    message = $"Đã tạo {soHocPhanTao} học phần từ {hopDongs.Count} hợp đồng!";
                }
                else if (giangVienDaDayMon > 0 && soHocPhanDaTonTai == 0)
                {
                    message = $"Không tạo thêm được học phần. {giangVienDaDayMon} trường hợp giảng viên đã được phân công dạy môn này trong kỳ.";
                }
                else if (soHocPhanDaTonTai > 0)
                {
                    message = $"Tất cả {soHocPhanDaTonTai} học phần đã tồn tại, không có học phần mới được tạo.";
                }
                else if (hopDongKhongCoMonHoc > 0)
                {
                    return Json(new { success = false, message = $"Có {hopDongKhongCoMonHoc} hợp đồng không có môn học. Vui lòng thêm môn học vào hợp đồng." });
                }
                else
                {
                    return Json(new { success = false, message = "Không thể tạo học phần. Vui lòng kiểm tra lại dữ liệu hợp đồng." });
                }

                // Thêm thông tin chi tiết
                var chiTiet = new List<string>();
                if (soHocPhanDaTonTai > 0 && soHocPhanTao > 0)
                {
                    chiTiet.Add($"{soHocPhanDaTonTai} mã học phần đã tồn tại");
                }
                if (giangVienDaDayMon > 0 && soHocPhanTao > 0)
                {
                    chiTiet.Add($"{giangVienDaDayMon} GV đã dạy môn trong kỳ");
                }
                if (chiTiet.Any())
                {
                    message += $" ({string.Join(", ", chiTiet)})";
                }

                return Json(new { success = true, message = message });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = $"Lỗi: {ex.Message}" });
            }
        }

        // POST: /QuanLyHocPhan/Xoa/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Xoa(int id)
        {
            if (!KiemTraQuyen())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var hocPhan = await _context.HocPhans.FindAsync(id);
            if (hocPhan == null)
            {
                return Json(new { success = false, message = "Không tìm thấy học phần" });
            }

            var coLich = await _context.LichThucHanhs.AnyAsync(l => l.HocPhanId == id);
            if (coLich)
            {
                return Json(new { success = false, message = "Không thể xóa vì đã có lịch thực hành" });
            }

            _context.HocPhans.Remove(hocPhan);
            await _context.SaveChangesAsync();

            return Json(new { success = true, message = "Xóa học phần thành công!" });
        }

        private async Task LoadDropdowns()
        {
            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            
            var monHocs = await _context.MonHocs
                .Where(m => m.TrangThaiHoatDong)
                .OrderBy(m => m.TenMonHoc)
                .ToListAsync();

            var giangViens = await _context.TaiKhoans
                .Where(t => t.VaiTro == LoaiVaiTro.GiangVien && t.TrangThaiHoatDong)
                .OrderBy(t => t.HoTen)
                .ToListAsync();

            var hocKys = await _context.HocKys
                .OrderByDescending(h => h.NamHoc)
                .ThenByDescending(h => h.SoHocKy)
                .ToListAsync();

            ViewBag.MonHocs = new SelectList(monHocs, "Id", "TenMonHoc");
            ViewBag.GiangViens = new SelectList(giangViens, "Id", "HoTen");
            ViewBag.HocKys = new SelectList(hocKys, "Id", "TenHocKy");
            ViewBag.HocKyId = hocKy?.Id ?? 0;
            ViewBag.TenHocKy = hocKy?.TenHocKy ?? "";
        }

        private async Task LoadDropdowns(HocPhanCreateViewModel model)
        {
            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            
            model.HocKyId = hocKy?.Id ?? 0;
            model.DanhSachHocKy = await _context.HocKys
                .OrderByDescending(h => h.NamHoc)
                .ThenByDescending(h => h.SoHocKy)
                .ToListAsync();

            model.DanhSachMonHoc = await _context.MonHocs
                .Where(m => m.TrangThaiHoatDong)
                .OrderBy(m => m.TenMonHoc)
                .ToListAsync();

            model.DanhSachGiangVien = await _context.TaiKhoans
                .Where(t => t.VaiTro == LoaiVaiTro.GiangVien && t.TrangThaiHoatDong)
                .OrderBy(t => t.HoTen)
                .ToListAsync();
        }

        private bool KiemTraQuyen()
        {
            return User.IsInRole(LoaiVaiTro.PhongDaoTao.ToString()) ||
                   User.IsInRole(LoaiVaiTro.Admin.ToString());
        }
    }
}
