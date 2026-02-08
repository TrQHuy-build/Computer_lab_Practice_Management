using System.ComponentModel.DataAnnotations;
using QL_TH_MT.Models;

namespace QL_TH_MT.ViewModels
{
    // ====== DTO for JSON serialization without circular references ======
    public class LichThucHanhDto
    {
        public int Id { get; set; }
        public int HocPhanId { get; set; }
        public int PhongThucHanhId { get; set; }
        public int HocKyId { get; set; }
        public int TuanHoc { get; set; }
        public int ThuTrongTuan { get; set; }
        public int CaHoc { get; set; }
        public DateTime NgayThucHanh { get; set; }
        public int BuoiThu { get; set; }
        public int TrangThai { get; set; }
        public string? GhiChu { get; set; }
    }

    // ====== SẮP XẾP LỊCH ======
    public class SapXepLichViewModel
    {
        public int HocKyId { get; set; }
        public string TenHocKy { get; set; } = string.Empty;

        // Thống kê
        public int TongHocPhan { get; set; }
        public int DaXepLich { get; set; }
        public int ChuaXepLich { get; set; }

        // Danh sách học phần cần xếp lịch
        public List<HocPhanCanXepLichViewModel> DanhSachHocPhan { get; set; } = new();

        // Danh sách phòng trống
        public List<PhongThucHanhNew> DanhSachPhong { get; set; } = new();

        // Kết quả xếp lịch (simple DTO for JSON serialization)
        public List<LichThucHanhDto> KetQuaXepLich { get; set; } = new();
        
        // Danh sách lịch đã xếp (cho view)
        public List<LichDaXepViewModel> LichDaXep { get; set; } = new();

        // Các học phần không xếp được
        public List<string> CanhBao { get; set; } = new();

        public bool ChoPhepXepLich { get; set; } // Chỉ trong tuần 3
    }

    public class LichDaXepViewModel
    {
        public int Id { get; set; }
        public string MaHocPhan { get; set; } = string.Empty;
        public string TenGiangVien { get; set; } = string.Empty;
        public string LoaiGV { get; set; } = string.Empty;
        public string TenPhong { get; set; } = string.Empty;
        public int Thu { get; set; }
        public int Ca { get; set; }
        public int Tuan { get; set; }
    }

    public class HocPhanCanXepLichViewModel
    {
        public int HocPhanId { get; set; }
        public string MaHocPhan { get; set; } = string.Empty;
        public string TenHocPhan { get; set; } = string.Empty;
        public string TenGiangVien { get; set; } = string.Empty;
        public bool LaThinhGiang { get; set; }
        public int DoUuTien { get; set; } // 1-Thỉnh giảng, 2-Cố hữu

        // Nếu là thỉnh giảng, các ca đã đăng ký
        public List<CaDaDangKyViewModel> CaDaDangKy { get; set; } = new();

        // Tuần bắt đầu thực hành (sau tuần lý thuyết)
        public int TuanBatDauThucHanh { get; set; }
        public int SoBuoiThucHanh { get; set; } = 3;
    }

    public class CaDaDangKyViewModel
    {
        public int ThuTrongTuan { get; set; }
        public int CaHoc { get; set; }
        public int TuanBatDau { get; set; }
    }

    // ====== LỊCH THỰC HÀNH ======
    public class LichThucHanhViewModel
    {
        public int Id { get; set; }

        [Required]
        [Display(Name = "Học phần")]
        public int HocPhanId { get; set; }

        [Required]
        [Display(Name = "Phòng thực hành")]
        public int PhongThucHanhId { get; set; }

        [Required]
        [Display(Name = "Học kỳ")]
        public int HocKyId { get; set; }

        [Required]
        [Display(Name = "Tuần học")]
        public int TuanHoc { get; set; }

        [Required]
        [Range(2, 8)]
        [Display(Name = "Thứ trong tuần")]
        public int ThuTrongTuan { get; set; }

        [Required]
        [Range(1, 6)]
        [Display(Name = "Ca học")]
        public int CaHoc { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày thực hành")]
        public DateTime NgayThucHanh { get; set; }

        [Display(Name = "Buổi thứ")]
        public int BuoiThu { get; set; }

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }

        // Thông tin hiển thị
        public string? TenHocPhan { get; set; }
        public string? TenPhong { get; set; }
        public string? TenGiangVien { get; set; }
        public int TrangThai { get; set; }
        public string? TrangThaiStr { get; set; }

        // Thêm các property còn thiếu cho Views
        public string? MaHocPhan { get; set; }
        public string? TenMonHoc { get; set; }
        public int Tuan { get; set; }
        public int Thu { get; set; }
        public int Ca { get; set; }
    }

    public class LichThucHanhIndexViewModel
    {
        public Dictionary<int, List<LichThucHanhViewModel>> LichTheoTuan { get; set; } = new();
    }

    public class LichChoDuyetViewModel
    {
        public int Id { get; set; }
        public string MaHocPhan { get; set; } = string.Empty;
        public string TenGiangVien { get; set; } = string.Empty;
        public string LoaiGV { get; set; } = string.Empty;
        public string TenPhong { get; set; } = string.Empty;
        public int Thu { get; set; }
        public int Ca { get; set; }
        public int Tuan { get; set; }
        public DateTime NgayGui { get; set; }
    }

    public class DanhSachLichThucHanhViewModel
    {
        public int HocKyId { get; set; }
        public string TenHocKy { get; set; } = string.Empty;

        // Filter
        public int? GiangVienId { get; set; }
        public int? PhongId { get; set; }
        public int? TuanHoc { get; set; }

        public List<LichThucHanhNew> DanhSachLich { get; set; } = new();
        public List<TaiKhoanNew> DanhSachGiangVien { get; set; } = new();
        public List<PhongThucHanhNew> DanhSachPhong { get; set; } = new();
    }

    // ====== DUYỆT LỊCH (TTDT) ======
    public class DuyetLichViewModel
    {
        public int LichId { get; set; }
        public LichThucHanhNew Lich { get; set; } = null!;

        [Required]
        [Display(Name = "Kết quả")]
        public bool Duyet { get; set; }

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }
    }
}
