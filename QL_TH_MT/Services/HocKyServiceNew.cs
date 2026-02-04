using Microsoft.EntityFrameworkCore;
using QL_TH_MT.Data;
using QL_TH_MT.Models;

namespace QL_TH_MT.Services
{
    /// <summary>
    /// Service quản lý học kỳ và xác định giai đoạn hiện tại
    /// </summary>
    public class HocKyServiceNew
    {
        private readonly NewAppDbContext _context;

        public HocKyServiceNew(NewAppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Lấy học kỳ đang active (TrangThai = 1)
        /// </summary>
        public async Task<HocKyNew?> GetHocKyHienTaiAsync()
        {
            return await _context.HocKys
                .Where(h => h.TrangThai == 1)
                .OrderByDescending(h => h.NgayTao)
                .FirstOrDefaultAsync();
        }

        /// <summary>
        /// Xác định giai đoạn hiện tại của học kỳ
        /// </summary>
        public GiaiDoanHocKy XacDinhGiaiDoan(HocKyNew? hocKy)
        {
            if (hocKy == null) return GiaiDoanHocKy.ChuaBatDau;

            var now = DateTime.Now.Date;

            // Chưa đến tiền học kỳ
            if (now < hocKy.TienHocKy.Date)
                return GiaiDoanHocKy.ChuaBatDau;

            // ====== GIAI ĐOẠN TRƯỚC HỌC KỲ (4 tuần) ======

            // Tuần 1: Nhập hợp đồng & kiểm kê phòng
            if (hocKy.KetThucNhapHopDong.HasValue && now <= hocKy.KetThucNhapHopDong.Value.Date)
                return GiaiDoanHocKy.Tuan1_NhapHopDong;

            // Tuần 2: Đăng ký lịch GV thỉnh giảng
            if (hocKy.KetThucDangKyLich.HasValue && now <= hocKy.KetThucDangKyLich.Value.Date)
                return GiaiDoanHocKy.Tuan2_DangKyLich;

            // Tuần 3: Sắp xếp lịch
            if (hocKy.KetThucSapXepLich.HasValue && now <= hocKy.KetThucSapXepLich.Value.Date)
                return GiaiDoanHocKy.Tuan3_SapXepLich;

            // Tuần 4: Thông báo và thay đổi
            if (now < hocKy.BatDauHocKy.Date)
                return GiaiDoanHocKy.Tuan4_ThongBao;

            // ====== GIAI ĐOẠN HỌC KỲ DIỄN RA ======

            // 3 tuần cuối = ôn tập thi (không có thực hành)
            var tuanOnTapThi = hocKy.KetThucHocKy.AddDays(-21).Date;
            if (now >= tuanOnTapThi)
                return GiaiDoanHocKy.DangHoc_OnTapThi;

            // Đã kết thúc
            if (now > hocKy.KetThucHocKy.Date)
                return GiaiDoanHocKy.DaKetThuc;

            // Trong học kỳ - cần xác định lý thuyết hay thực hành
            // Tạm thời return ThucHanh (sẽ tính theo từng môn)
            return GiaiDoanHocKy.DangHoc_ThucHanh;
        }

        /// <summary>
        /// Lấy tên giai đoạn
        /// </summary>
        public string GetTenGiaiDoan(GiaiDoanHocKy giaiDoan)
        {
            return giaiDoan switch
            {
                GiaiDoanHocKy.ChuaBatDau => "Chưa bắt đầu",
                GiaiDoanHocKy.Tuan1_NhapHopDong => "Tuần 1: Nhập hợp đồng & Kiểm kê phòng",
                GiaiDoanHocKy.Tuan2_DangKyLich => "Tuần 2: Đăng ký lịch giảng viên thỉnh giảng",
                GiaiDoanHocKy.Tuan3_SapXepLich => "Tuần 3: Sắp xếp lịch thực hành",
                GiaiDoanHocKy.Tuan4_ThongBao => "Tuần 4: Thông báo và điều chỉnh",
                GiaiDoanHocKy.DangHoc_LyThuyet => "Đang học: Giai đoạn lý thuyết",
                GiaiDoanHocKy.DangHoc_ThucHanh => "Đang học: Giai đoạn thực hành",
                GiaiDoanHocKy.DangHoc_OnTapThi => "Đang học: Ôn tập & thi cuối kỳ",
                GiaiDoanHocKy.DaKetThuc => "Đã kết thúc",
                _ => "Không xác định"
            };
        }

        /// <summary>
        /// Tính số tuần lý thuyết theo số tín chỉ
        /// n=0 nếu TC=1; n=4 nếu TC=2; n=6 nếu TC=3; n=8 nếu TC=4
        /// </summary>
        public int TinhSoTuanLyThuyet(int soTinChi)
        {
            return soTinChi switch
            {
                1 => 0,
                2 => 4,
                3 => 6,
                4 => 8,
                _ => 6 // Mặc định
            };
        }

        /// <summary>
        /// Tạo học kỳ mới với các mốc thời gian tự động
        /// </summary>
        public async Task<HocKyNew> TaoHocKyMoi(HocKyNew hocKy)
        {
            // Tự động tính các mốc thời gian (mỗi tuần = 7 ngày)
            hocKy.KetThucNhapHopDong = hocKy.TienHocKy.AddDays(7);
            hocKy.KetThucDangKyLich = hocKy.TienHocKy.AddDays(14);
            hocKy.KetThucSapXepLich = hocKy.TienHocKy.AddDays(21);
            hocKy.KetThucThongBao = hocKy.BatDauHocKy;

            _context.HocKys.Add(hocKy);
            await _context.SaveChangesAsync();

            return hocKy;
        }

        /// <summary>
        /// Kích hoạt học kỳ (deactivate các học kỳ khác)
        /// </summary>
        public async Task KichHoatHocKy(int hocKyId)
        {
            // Deactivate tất cả (TrangThai = 0)
            var allHocKy = await _context.HocKys.ToListAsync();
            foreach (var hk in allHocKy)
            {
                hk.TrangThai = 0;
            }

            // Activate học kỳ được chọn (TrangThai = 1)
            var hocKy = await _context.HocKys.FindAsync(hocKyId);
            if (hocKy != null)
            {
                hocKy.TrangThai = 1;
            }

            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Kiểm tra có trong giai đoạn cho phép nhập hợp đồng không
        /// </summary>
        public async Task<bool> ChoPhepNhapHopDong()
        {
            var hocKy = await GetHocKyHienTaiAsync();
            var giaiDoan = XacDinhGiaiDoan(hocKy);
            return giaiDoan == GiaiDoanHocKy.Tuan1_NhapHopDong;
        }

        /// <summary>
        /// Kiểm tra có trong giai đoạn cho phép đăng ký lịch không
        /// </summary>
        public async Task<bool> ChoPhepDangKyLich()
        {
            var hocKy = await GetHocKyHienTaiAsync();
            var giaiDoan = XacDinhGiaiDoan(hocKy);
            return giaiDoan == GiaiDoanHocKy.Tuan2_DangKyLich;
        }

        /// <summary>
        /// Kiểm tra có trong giai đoạn cho phép sắp xếp lịch không
        /// </summary>
        public async Task<bool> ChoPhepSapXepLich()
        {
            var hocKy = await GetHocKyHienTaiAsync();
            var giaiDoan = XacDinhGiaiDoan(hocKy);
            return giaiDoan == GiaiDoanHocKy.Tuan3_SapXepLich;
        }

        /// <summary>
        /// Kiểm tra có trong giai đoạn cho phép đổi lịch không (Tuần 4 hoặc đang học)
        /// </summary>
        public async Task<bool> ChoPhepDoiLich()
        {
            var hocKy = await GetHocKyHienTaiAsync();
            if (hocKy == null) return false;

            var giaiDoan = XacDinhGiaiDoan(hocKy);
            var now = DateTime.Now.Date;

            // Cho phép từ Tuần 4 trở đi (kể cả khi chưa đến ngày BatDauHocKy)
            // Tức là sau khi kết thúc Sắp xếp lịch (Tuần 3)
            var khoaDoiLichBatDau = hocKy.KetThucSapXepLich.HasValue 
                ? hocKy.KetThucSapXepLich.Value.Date 
                : hocKy.BatDauHocKy.Date;

            if (now < khoaDoiLichBatDau)
                return false;

            // Ngoài giai đoạn ôn tập thi (3 tuần cuối)
            var tuanOnTapThi = hocKy.KetThucHocKy.AddDays(-21).Date;
            if (now >= tuanOnTapThi)
                return false;

            // Ngoài sau khi kết thúc học kỳ
            if (now > hocKy.KetThucHocKy.Date)
                return false;

            return true;
        }
    }
}
