using System.ComponentModel.DataAnnotations;
using QL_TH_MT.Models;

namespace QL_TH_MT.ViewModels
{
    // ====== HỌC KỲ ======
    public class HocKyViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập tên học kỳ")]
        [StringLength(50)]
        [Display(Name = "Tên học kỳ")]
        public string TenHocKy { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập năm học")]
        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng chọn học kỳ")]
        [Display(Name = "Học kỳ")]
        public int SoHocKy { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày tiền học kỳ")]
        [DataType(DataType.Date)]
        [Display(Name = "Tiền học kỳ")]
        public DateTime TienHocKy { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày bắt đầu học kỳ")]
        [DataType(DataType.Date)]
        [Display(Name = "Bắt đầu học kỳ")]
        public DateTime BatDauHocKy { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày kết thúc học kỳ")]
        [DataType(DataType.Date)]
        [Display(Name = "Kết thúc học kỳ")]
        public DateTime KetThucHocKy { get; set; }

        // Các mốc tự động tính
        public DateTime KetThucNhapHopDong { get; set; }
        public DateTime KetThucDangKyLich { get; set; }
        public DateTime KetThucSapXepLich { get; set; }
        public DateTime KetThucThongBao { get; set; }

        /// <summary>
        /// Trạng thái: 0-Không hoạt động, 1-Đang hoạt động
        /// </summary>
        public int TrangThai { get; set; }

        // Thêm properties cho Views
        public DateTime NgayBatDau { get; set; }
        public DateTime NgayKetThuc { get; set; }
        public DateTime NgayBatDauTienHocKy { get; set; }
        public DateTime NgayBatDauThi { get; set; }
        public bool DangHoatDong { get; set; }
        public string GiaiDoanHienTai { get; set; } = string.Empty;
    }

    public class HocKyCreateViewModel
    {
        [Display(Name = "Tên học kỳ")]
        public string? TenHocKy { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập năm học")]
        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng chọn học kỳ")]
        [Display(Name = "Học kỳ")]
        public int SoHocKy { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày bắt đầu tiền học kỳ")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày bắt đầu tiền học kỳ")]
        public DateTime TienHocKy { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày bắt đầu tiền học kỳ")]
        public DateTime NgayBatDauTienHocKy { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày bắt đầu học kỳ")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày bắt đầu học kỳ")]
        public DateTime BatDauHocKy { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày bắt đầu")]
        public DateTime NgayBatDau { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày kết thúc học kỳ")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày kết thúc học kỳ")]
        public DateTime KetThucHocKy { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày kết thúc")]
        public DateTime NgayKetThuc { get; set; }
    }

    public class ChiTietHocKyViewModel
    {
        public HocKyNew HocKy { get; set; } = null!;
        public GiaiDoanHocKy GiaiDoanHienTai { get; set; }
        public string TenGiaiDoan { get; set; } = string.Empty;
        public int SoNgayConLaiGiaiDoan { get; set; }

        // Thống kê
        public int TongHopDong { get; set; }
        public int TongDangKyLich { get; set; }
        public int TongLichThucHanh { get; set; }
        public int LichDaDuyet { get; set; }
    }

    // ====== MÔN HỌC ======
    public class MonHocViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mã môn học")]
        [StringLength(20)]
        [Display(Name = "Mã môn học")]
        public string MaMonHoc { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập tên môn học")]
        [StringLength(200)]
        [Display(Name = "Tên môn học")]
        public string TenMonHoc { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập số tín chỉ")]
        [Range(1, 10, ErrorMessage = "Số tín chỉ từ 1-10")]
        [Display(Name = "Số tín chỉ")]
        public int SoTinChi { get; set; }

        [Display(Name = "Số buổi thực hành")]
        public int SoBuoiThucHanh { get; set; } = 3;

        [StringLength(500)]
        [Display(Name = "Mô tả")]
        public string? MoTa { get; set; }

        [Display(Name = "Trạng thái")]
        public bool TrangThaiHoatDong { get; set; } = true;
        
        // Property cho View
        public bool DangHoatDong { get; set; } = true;

        // Computed: Số tuần lý thuyết
        public int SoTuanLyThuyet => SoTinChi switch
        {
            1 => 0,
            2 => 4,
            3 => 6,
            4 => 8,
            _ => 6
        };
    }

    public class MonHocCreateViewModel
    {
        [Required(ErrorMessage = "Vui lòng nhập mã môn học")]
        [StringLength(20)]
        [Display(Name = "Mã môn học")]
        public string MaMonHoc { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập tên môn học")]
        [StringLength(200)]
        [Display(Name = "Tên môn học")]
        public string TenMonHoc { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập số tín chỉ")]
        [Range(1, 10, ErrorMessage = "Số tín chỉ từ 1-10")]
        [Display(Name = "Số tín chỉ")]
        public int SoTinChi { get; set; }

        [Display(Name = "Số buổi thực hành")]
        [Range(1, 10)]
        public int SoBuoiThucHanh { get; set; } = 3;

        [StringLength(500)]
        [Display(Name = "Mô tả")]
        public string? MoTa { get; set; }
    }

    // ====== HỌC PHẦN ======
    public class HocPhanViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mã học phần")]
        [StringLength(30)]
        [Display(Name = "Mã học phần")]
        public string MaHocPhan { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập tên học phần")]
        [StringLength(200)]
        [Display(Name = "Tên học phần")]
        public string TenHocPhan { get; set; } = string.Empty;

        [StringLength(10)]
        [Display(Name = "Nhóm")]
        public string? Nhom { get; set; }

        [Range(1, 200)]
        [Display(Name = "Sĩ số")]
        public int SiSo { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn môn học")]
        [Display(Name = "Môn học")]
        public int MonHocId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn học kỳ")]
        [Display(Name = "Học kỳ")]
        public int HocKyId { get; set; }

        [Display(Name = "Giảng viên")]
        public int? GiangVienId { get; set; }

        // Thông tin hiển thị
        public string? TenMonHoc { get; set; }
        public string? TenGiangVien { get; set; }
        public string? TenHocKy { get; set; }
        public string? LoaiGiangVien { get; set; }

        // Thêm properties cho Views
        public int SoBuoiThucHanh { get; set; } = 3;
        public int SoTinChi { get; set; }
        public bool TrangThaiHoatDong { get; set; } = true;
        public bool DaXepLich { get; set; }
        public int TuanBatDauThucHanh { get; set; }
    }

    public class HocPhanCreateViewModel
    {
        [Required(ErrorMessage = "Vui lòng nhập mã học phần")]
        [StringLength(30)]
        [Display(Name = "Mã học phần")]
        public string MaHocPhan { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng chọn môn học")]
        [Display(Name = "Môn học")]
        public int MonHocId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn học kỳ")]
        [Display(Name = "Học kỳ")]
        public int HocKyId { get; set; }

        [StringLength(10)]
        [Display(Name = "Nhóm")]
        public string? Nhom { get; set; }

        [Range(1, 200)]
        [Display(Name = "Sĩ số")]
        public int SiSo { get; set; } = 40;

        [Display(Name = "Giảng viên (tùy chọn)")]
        public int? GiangVienId { get; set; }

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }

        // Danh sách dropdown
        public List<MonHocNew>? DanhSachMonHoc { get; set; }
        public List<HocKyNew>? DanhSachHocKy { get; set; }
        public List<TaiKhoanNew>? DanhSachGiangVien { get; set; }
    }
}
