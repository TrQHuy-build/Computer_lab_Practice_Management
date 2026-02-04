using Microsoft.EntityFrameworkCore;
using QL_TH_MT.Data;
using QL_TH_MT.Models;
using QL_TH_MT.ViewModels;

namespace QL_TH_MT.Services
{
    /// <summary>
    /// Service sắp xếp lịch thực hành tự động
    /// Ưu tiên: 1. GV Thỉnh giảng, 2. GV Cố hữu
    /// Ràng buộc: 3 tuần liên tiếp cùng ngày, cùng ca
    /// </summary>
    public class SapXepLichServiceNew
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;

        public SapXepLichServiceNew(NewAppDbContext context, HocKyServiceNew hocKyService)
        {
            _context = context;
            _hocKyService = hocKyService;
        }

        /// <summary>
        /// Lấy danh sách học phần cần xếp lịch theo độ ưu tiên
        /// </summary>
        public async Task<List<HocPhanCanXepLichViewModel>> GetDanhSachHocPhanCanXepLich(int hocKyId)
        {
            var hocKy = await _context.HocKys.FindAsync(hocKyId);
            if (hocKy == null) return new List<HocPhanCanXepLichViewModel>();

            var danhSach = await _context.HocPhans
                .Include(hp => hp.MonHoc)
                .Include(hp => hp.GiangVien)
                .Where(hp => hp.HocKyId == hocKyId && hp.TrangThaiHoatDong)
                .ToListAsync();

            var result = new List<HocPhanCanXepLichViewModel>();

            foreach (var hp in danhSach)
            {
                var gv = hp.GiangVien;
                var laThinhGiang = gv?.LoaiGiangVien == LoaiGiangVien.ThinhGiang;

                var vm = new HocPhanCanXepLichViewModel
                {
                    HocPhanId = hp.Id,
                    MaHocPhan = hp.MaHocPhan,
                    TenHocPhan = hp.TenHocPhan,
                    TenGiangVien = gv?.HoTen ?? "Chưa phân công",
                    LaThinhGiang = laThinhGiang,
                    DoUuTien = laThinhGiang ? 1 : 2,
                    TuanBatDauThucHanh = _hocKyService.TinhSoTuanLyThuyet(hp.MonHoc?.SoTinChi ?? 3) + 1,
                    SoBuoiThucHanh = hp.MonHoc?.SoBuoiThucHanh ?? 3
                };

                // Nếu là thỉnh giảng, lấy các ca đã đăng ký
                if (laThinhGiang && gv != null)
                {
                    var dangKyLich = await _context.DangKyLichThinhGiangs
                        .Where(dk => dk.GiangVienId == gv.Id && dk.HocKyId == hocKyId && dk.TrangThai == 1)
                        .ToListAsync();

                    vm.CaDaDangKy = dangKyLich.Select(dk => new CaDaDangKyViewModel
                    {
                        ThuTrongTuan = dk.ThuTrongTuan,
                        CaHoc = dk.CaHoc,
                        TuanBatDau = dk.TuanBatDau ?? vm.TuanBatDauThucHanh
                    }).ToList();
                }

                result.Add(vm);
            }

            // Sắp xếp theo độ ưu tiên
            return result.OrderBy(x => x.DoUuTien).ThenBy(x => x.TenHocPhan).ToList();
        }

        /// <summary>
        /// Tự động sắp xếp lịch thực hành
        /// </summary>
        public async Task<SapXepLichResult> TuDongSapXepLich(int hocKyId, int nguoiTaoId)
        {
            var result = new SapXepLichResult();

            var hocKy = await _context.HocKys.FindAsync(hocKyId);
            if (hocKy == null)
            {
                result.CanhBao.Add("Không tìm thấy học kỳ");
                return result;
            }

            // Lấy danh sách phòng
            var danhSachPhong = await _context.PhongThucHanhs
                .Where(p => p.TrangThaiHoatDong)
                .ToListAsync();

            if (!danhSachPhong.Any())
            {
                result.CanhBao.Add("Không có phòng thực hành nào khả dụng");
                return result;
            }

            // Lấy danh sách học phần cần xếp
            var danhSachHocPhan = await GetDanhSachHocPhanCanXepLich(hocKyId);

            // Tính ngày bắt đầu học kỳ
            var ngayBatDau = hocKy.BatDauHocKy.Date;

            // Tính ngày kết thúc (trừ 3 tuần ôn tập)
            var ngayKetThuc = hocKy.KetThucHocKy.AddDays(-21).Date;

            // Ma trận lịch: [NgàyThucHanh][CaHoc][PhongId] = đã dùng?
            var lichDaSuDung = new Dictionary<(DateTime, int, int), bool>();

            // Xếp lịch cho từng học phần
            foreach (var hp in danhSachHocPhan)
            {
                var lichXepDuoc = await XepLichChoHocPhan(hp, hocKy, danhSachPhong, lichDaSuDung, nguoiTaoId);

                if (lichXepDuoc.Any())
                {
                    result.LichDaXep.AddRange(lichXepDuoc);
                }
                else
                {
                    result.CanhBao.Add($"Không xếp được lịch cho học phần: {hp.TenHocPhan}");
                }
            }

            return result;
        }

        /// <summary>
        /// Xếp lịch cho một học phần cụ thể
        /// </summary>
        private async Task<List<LichThucHanhNew>> XepLichChoHocPhan(
            HocPhanCanXepLichViewModel hp,
            HocKyNew hocKy,
            List<PhongThucHanhNew> danhSachPhong,
            Dictionary<(DateTime, int, int), bool> lichDaSuDung,
            int nguoiTaoId)
        {
            var lichXep = new List<LichThucHanhNew>();
            var ngayBatDau = hocKy.BatDauHocKy.Date;

            // Nếu là thỉnh giảng và có ca đăng ký
            if (hp.LaThinhGiang && hp.CaDaDangKy.Any())
            {
                foreach (var ca in hp.CaDaDangKy)
                {
                    var ketQua = TimLichTheoYeuCau(hp, hocKy, danhSachPhong, lichDaSuDung,
                        ca.ThuTrongTuan, ca.CaHoc, ca.TuanBatDau, nguoiTaoId);

                    if (ketQua != null)
                    {
                        lichXep.AddRange(ketQua);
                        foreach (var lich in ketQua)
                        {
                            lichDaSuDung[(lich.NgayThucHanh, lich.CaHoc, lich.PhongThucHanhId)] = true;
                        }
                    }
                }
            }
            else
            {
                // GV cố hữu: tìm slot trống bất kỳ
                var ketQua = TimLichTrong(hp, hocKy, danhSachPhong, lichDaSuDung, nguoiTaoId);
                if (ketQua != null)
                {
                    lichXep.AddRange(ketQua);
                    foreach (var lich in ketQua)
                    {
                        lichDaSuDung[(lich.NgayThucHanh, lich.CaHoc, lich.PhongThucHanhId)] = true;
                    }
                }
            }

            // Lưu vào database
            if (lichXep.Any())
            {
                _context.LichThucHanhs.AddRange(lichXep);
                await _context.SaveChangesAsync();
            }

            return lichXep;
        }

        /// <summary>
        /// Tìm lịch theo yêu cầu của GV thỉnh giảng (thứ, ca cụ thể)
        /// </summary>
        private List<LichThucHanhNew>? TimLichTheoYeuCau(
            HocPhanCanXepLichViewModel hp,
            HocKyNew hocKy,
            List<PhongThucHanhNew> danhSachPhong,
            Dictionary<(DateTime, int, int), bool> lichDaSuDung,
            int thuTrongTuan,
            int caHoc,
            int tuanBatDau,
            int nguoiTaoId)
        {
            var ngayBatDau = hocKy.BatDauHocKy.Date;
            var ngayKetThuc = hocKy.KetThucHocKy.AddDays(-21).Date;

            // Tìm ngày đầu tiên của tuần bắt đầu
            var ngayTuanBatDau = ngayBatDau.AddDays((tuanBatDau - 1) * 7);

            // Tìm ngày theo thứ
            var thuHienTai = (int)ngayTuanBatDau.DayOfWeek;
            if (thuHienTai == 0) thuHienTai = 7; // Chủ nhật = 7
            thuHienTai += 1; // Chuyển sang format 2-8

            var dayOffset = thuTrongTuan - thuHienTai;
            if (dayOffset < 0) dayOffset += 7;

            var ngayThucHanhDauTien = ngayTuanBatDau.AddDays(dayOffset);

            // Tìm phòng trống cho 3 tuần liên tiếp
            foreach (var phong in danhSachPhong)
            {
                var lichThu = new List<LichThucHanhNew>();
                var coTheDung = true;

                for (int buoi = 0; buoi < hp.SoBuoiThucHanh; buoi++)
                {
                    var ngayThucHanh = ngayThucHanhDauTien.AddDays(buoi * 7);

                    // Kiểm tra còn trong kỳ học không
                    if (ngayThucHanh > ngayKetThuc)
                    {
                        coTheDung = false;
                        break;
                    }

                    // Kiểm tra đã có ai dùng chưa
                    if (lichDaSuDung.ContainsKey((ngayThucHanh, caHoc, phong.Id)))
                    {
                        coTheDung = false;
                        break;
                    }

                    var tuanHoc = (int)((ngayThucHanh - ngayBatDau).TotalDays / 7) + 1;

                    lichThu.Add(new LichThucHanhNew
                    {
                        HocPhanId = hp.HocPhanId,
                        PhongThucHanhId = phong.Id,
                        HocKyId = hocKy.Id,
                        TuanHoc = tuanHoc,
                        ThuTrongTuan = thuTrongTuan,
                        CaHoc = caHoc,
                        NgayThucHanh = ngayThucHanh,
                        BuoiThu = buoi + 1,
                        TrangThai = 0,
                        NguoiTaoId = nguoiTaoId,
                        NgayTao = DateTime.Now
                    });
                }

                if (coTheDung && lichThu.Count == hp.SoBuoiThucHanh)
                {
                    return lichThu;
                }
            }

            return null;
        }

        /// <summary>
        /// Tìm slot trống cho GV cố hữu
        /// </summary>
        private List<LichThucHanhNew>? TimLichTrong(
            HocPhanCanXepLichViewModel hp,
            HocKyNew hocKy,
            List<PhongThucHanhNew> danhSachPhong,
            Dictionary<(DateTime, int, int), bool> lichDaSuDung,
            int nguoiTaoId)
        {
            var ngayBatDau = hocKy.BatDauHocKy.Date;
            var ngayKetThuc = hocKy.KetThucHocKy.AddDays(-21).Date;

            // Tính tuần bắt đầu thực hành
            var tuanBatDau = hp.TuanBatDauThucHanh;
            var ngayTuanBatDau = ngayBatDau.AddDays((tuanBatDau - 1) * 7);

            // Duyệt qua từng thứ (2-7, tránh CN)
            for (int thu = 2; thu <= 7; thu++)
            {
                // Duyệt qua từng ca (1-6)
                for (int ca = 1; ca <= 6; ca++)
                {
                    // Tính ngày đầu tiên theo thứ
                    var thuHienTai = (int)ngayTuanBatDau.DayOfWeek;
                    if (thuHienTai == 0) thuHienTai = 7;
                    thuHienTai += 1;

                    var dayOffset = thu - thuHienTai;
                    if (dayOffset < 0) dayOffset += 7;

                    var ngayThucHanhDauTien = ngayTuanBatDau.AddDays(dayOffset);

                    // Tìm phòng trống
                    foreach (var phong in danhSachPhong)
                    {
                        var lichThu = new List<LichThucHanhNew>();
                        var coTheDung = true;

                        for (int buoi = 0; buoi < hp.SoBuoiThucHanh; buoi++)
                        {
                            var ngayThucHanh = ngayThucHanhDauTien.AddDays(buoi * 7);

                            if (ngayThucHanh > ngayKetThuc)
                            {
                                coTheDung = false;
                                break;
                            }

                            if (lichDaSuDung.ContainsKey((ngayThucHanh, ca, phong.Id)))
                            {
                                coTheDung = false;
                                break;
                            }

                            var tuanHoc = (int)((ngayThucHanh - ngayBatDau).TotalDays / 7) + 1;

                            lichThu.Add(new LichThucHanhNew
                            {
                                HocPhanId = hp.HocPhanId,
                                PhongThucHanhId = phong.Id,
                                HocKyId = hocKy.Id,
                                TuanHoc = tuanHoc,
                                ThuTrongTuan = thu,
                                CaHoc = ca,
                                NgayThucHanh = ngayThucHanh,
                                BuoiThu = buoi + 1,
                                TrangThai = 0,
                                NguoiTaoId = nguoiTaoId,
                                NgayTao = DateTime.Now
                            });
                        }

                        if (coTheDung && lichThu.Count == hp.SoBuoiThucHanh)
                        {
                            return lichThu;
                        }
                    }
                }
            }

            return null;
        }

        /// <summary>
        /// Kiểm tra xung đột lịch
        /// </summary>
        public async Task<bool> KiemTraXungDot(DateTime ngay, int caHoc, int phongId)
        {
            return await _context.LichThucHanhs
                .AnyAsync(l => l.NgayThucHanh.Date == ngay.Date
                    && l.CaHoc == caHoc
                    && l.PhongThucHanhId == phongId
                    && l.TrangThai != 4); // Không tính lịch đã hủy
        }
    }

    public class SapXepLichResult
    {
        public List<LichThucHanhNew> LichDaXep { get; set; } = new();
        public List<string> CanhBao { get; set; } = new();
        public bool ThanhCong => !CanhBao.Any() || LichDaXep.Any();
    }
}
