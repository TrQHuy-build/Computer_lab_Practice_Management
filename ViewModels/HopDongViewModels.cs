using System.ComponentModel.DataAnnotations;
using QL_TH_MT.Models;

namespace QL_TH_MT.ViewModels
{
    // ====== HỢP ĐỒNG ======
    public class HopDongViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập số hợp đồng")]
        [StringLength(50)]
        [Display(Name = "Số hợp đồng")]
        public string SoHopDong { get; set; } = string.Empty;

        [Display(Name = "Mã hợp đồng")]
        public string MaHopDong { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng chọn giảng viên")]
        [Display(Name = "Giảng viên")]
        public int GiangVienId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn môn học")]
        [Display(Name = "Môn học")]
        public int MonHocId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn học kỳ")]
        [Display(Name = "Học kỳ")]
        public int HocKyId { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập số học phần")]
        [Range(1, 100, ErrorMessage = "Số học phần phải từ 1 đến 100")]
        [Display(Name = "Số học phần")]
        public int SoHocPhan { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày ký")]
        public DateTime NgayKy { get; set; }

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }

        // Thông tin hiển thị
        public string? TenGiangVien { get; set; }
        public string? LoaiGiangVienStr { get; set; }
        public string? LoaiGiangVien { get; set; }
        public string? TenHocKy { get; set; }
        public string? TenMonHoc { get; set; }
        public int TrangThai { get; set; }
        public string? TrangThaiStr { get; set; }
    }

    public class HopDongCreateViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mã hợp đồng")]
        [StringLength(50)]
        [Display(Name = "Mã hợp đồng")]
        public string MaHopDong { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng chọn giảng viên")]
        [Display(Name = "Giảng viên thỉnh giảng")]
        public int GiangVienId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ít nhất một môn học")]
        [Display(Name = "Môn học")]
        public List<int> MonHocIds { get; set; } = new List<int>();

        [Required(ErrorMessage = "Vui lòng chọn học kỳ")]
        [Display(Name = "Học kỳ")]
        public int HocKyId { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày ký")]
        public DateTime NgayKy { get; set; } = DateTime.Today;

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }

        // Danh sách dropdown
        public List<TaiKhoanNew>? DanhSachGiangVien { get; set; }
        public List<MonHocNew>? DanhSachMonHoc { get; set; }
        public List<HocKyNew>? DanhSachHocKy { get; set; }
    }

    public class DanhSachHopDongViewModel
    {
        public int HocKyId { get; set; }
        public string TenHocKy { get; set; } = string.Empty;
        public List<HopDongNew> DanhSachHopDong { get; set; } = new();
        public bool ChoPhepChinhSua { get; set; } // Chỉ trong tuần 1
    }

    // ====== ĐĂNG KÝ LỊCH THỈNH GIẢNG ======
    public class DangKyLichThinhGiangViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn hợp đồng")]
        [Display(Name = "Hợp đồng")]
        public int HopDongId { get; set; }

        public int GiangVienId { get; set; }

        public int HocKyId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn thứ trong tuần")]
        [Range(2, 8, ErrorMessage = "Thứ từ 2-8 (8 = Chủ nhật)")]
        [Display(Name = "Thứ trong tuần")]
        public int ThuTrongTuan { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ca học")]
        [Range(1, 6, ErrorMessage = "Ca học từ 1-6")]
        [Display(Name = "Ca học")]
        public int CaHoc { get; set; }

        [Display(Name = "Số tuần liên tiếp")]
        public int SoTuanLienTiep { get; set; } = 3;

        [Display(Name = "Tuần bắt đầu")]
        public int? TuanBatDau { get; set; }

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }

        // Thông tin hiển thị
        public string? TenMonHoc { get; set; }
        public string? TenHocKy { get; set; }
        public int TrangThai { get; set; }
        public string? TrangThaiStr { get; set; }
    }

    public class FormDangKyLichViewModel
    {
        public int HopDongId { get; set; }
        public string TenMonHoc { get; set; } = string.Empty;
        public string TenHocKy { get; set; } = string.Empty;
        public int SoHocPhan { get; set; }

        // Các ca đăng ký (mỗi học phần cần ít nhất 3 ca liên tiếp)
        public List<CaDangKyViewModel> DanhSachCa { get; set; } = new();
    }

    public class CaDangKyViewModel
    {
        public int ThuTrongTuan { get; set; }
        public int CaHoc { get; set; }
        public int? TuanBatDau { get; set; }
        public string? GhiChu { get; set; }
    }

    // ====== LỊCH THEO TUẦN ======
    public class LichTuanViewModel
    {
        public int TuanHoc { get; set; }
        public DateTime NgayDauTuan { get; set; }
        public DateTime NgayCuoiTuan { get; set; }

        // Ô lịch: [Thứ 2-CN][Ca 1-6]
        public OLichViewModel[,] BangLich { get; set; } = new OLichViewModel[7, 6];
    }

    public class OLichViewModel
    {
        public bool DaDangKy { get; set; }
        public bool DaBiChiem { get; set; }
        public string? ThongTin { get; set; }
        public int? LichThucHanhId { get; set; }
    }

    // ====== FORM ĐĂNG KÝ LỊCH ======
    public class DangKyLichViewModel
    {
        public int Id { get; set; }
        public int HocPhanId { get; set; }
        public int GiangVienId { get; set; }
        public int HocKyId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày thực hành")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày thực hành")]
        public DateTime NgayThucHanh { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn thứ trong tuần")]
        [Range(2, 8, ErrorMessage = "Thứ từ 2-8 (8 = Chủ nhật)")]
        [Display(Name = "Thứ trong tuần")]
        public int ThuTrongTuan { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ca học")]
        [Range(1, 6, ErrorMessage = "Ca học từ 1-6")]
        [Display(Name = "Ca học")]
        public int CaHoc { get; set; }

        [Display(Name = "Tuần bắt đầu")]
        public int TuanBatDau { get; set; }

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }

        // Thông tin hiển thị
        public string? TenHocPhan { get; set; }
        public string? TenMonHoc { get; set; }
        public string? TenGiangVien { get; set; }
        public string? TenHocKy { get; set; }
        public int TrangThai { get; set; }
        public string? TrangThaiStr { get; set; }

        // Danh sách lựa chọn
        public List<HocPhanNew>? DanhSachHocPhan { get; set; }
        public List<HopDongNew>? DanhSachHopDong { get; set; }

        // Các ngày thực hành (3 ngày liên tiếp cùng thứ)
        public List<DateTime> NgayThucHanhs { get; set; } = new();
    }

    // Để View Index hiển thị danh sách đăng ký
    public class DangKyLichIndexViewModel
    {
        public int HocKyId { get; set; }
        public string TenHocKy { get; set; } = string.Empty;
        public GiaiDoanHocKy GiaiDoan { get; set; }
        public bool ChoPhepDangKy { get; set; }
        public List<DangKyLichViewModel> DanhSachDangKy { get; set; } = new();
    }
}
