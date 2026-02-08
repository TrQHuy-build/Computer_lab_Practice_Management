using System.ComponentModel.DataAnnotations;
using QL_TH_MT.Models;

namespace QL_TH_MT.ViewModels
{
    // ====== PHÒNG THỰC HÀNH ======
    public class PhongThucHanhViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mã phòng")]
        [StringLength(20)]
        [Display(Name = "Mã phòng")]
        public string MaPhong { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập tên phòng")]
        [StringLength(100)]
        [Display(Name = "Tên phòng")]
        public string TenPhong { get; set; } = string.Empty;

        [StringLength(100)]
        [Display(Name = "Vị trí")]
        public string? ViTri { get; set; }

        [Range(1, 100, ErrorMessage = "Sức chứa từ 1-100")]
        [Display(Name = "Sức chứa")]
        public int SucChua { get; set; }

        [Display(Name = "Số máy hoạt động")]
        public int SoMayHoatDong { get; set; }

        [StringLength(500)]
        [Display(Name = "Mô tả")]
        public string? MoTa { get; set; }

        [Display(Name = "Trạng thái")]
        public bool TrangThaiHoatDong { get; set; } = true;

        // Thông tin kiểm kê
        public DateTime? NgayKiemKeGanNhat { get; set; }
        public string? TenNguoiKiemKe { get; set; }

        // Danh sách phần mềm
        public List<PhanMemTrongPhongViewModel> DanhSachPhanMem { get; set; } = new();

        // Thêm properties cho Views
        public bool DangHoatDong { get; set; } = true;
        public List<string>? PhanMems { get; set; }
    }

    public class KiemKePhongViewModel
    {
        public int PhongId { get; set; }
        public string MaPhong { get; set; } = string.Empty;
        public string TenPhong { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập số máy hoạt động")]
        [Display(Name = "Số máy hoạt động")]
        public int SoMayHoatDong { get; set; }

        [Display(Name = "Trạng thái")]
        public bool TrangThaiHoatDong { get; set; } = true;

        [StringLength(500)]
        [Display(Name = "Ghi chú kiểm kê")]
        public string? GhiChu { get; set; }
    }

    // ====== PHẦN MỀM ======
    public class PhanMemViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập tên phần mềm")]
        [StringLength(100)]
        [Display(Name = "Tên phần mềm")]
        public string TenPhanMem { get; set; } = string.Empty;

        [StringLength(50)]
        [Display(Name = "Phiên bản")]
        public string? PhienBan { get; set; }

        [StringLength(500)]
        [Display(Name = "Mô tả")]
        public string? MoTa { get; set; }

        [Display(Name = "Dung lượng (MB)")]
        public int? DungLuong { get; set; }

        [Display(Name = "Trạng thái")]
        public bool TrangThaiHoatDong { get; set; } = true;

        // Số phòng đã cài đặt
        public int SoPhongCaiDat { get; set; }
    }

    public class PhanMemTrongPhongViewModel
    {
        public int PhanMemId { get; set; }
        public string TenPhanMem { get; set; } = string.Empty;
        public string? PhienBan { get; set; }
        public DateTime NgayCaiDat { get; set; }
        public string? TenNguoiCaiDat { get; set; }
    }

    public class ThemPhanMemVaoPhongViewModel
    {
        public int PhongThucHanhId { get; set; }
        public string TenPhong { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng chọn phần mềm")]
        public List<int> DanhSachPhanMemId { get; set; } = new();

        // Danh sách phần mềm có thể thêm
        public List<PhanMemNew> PhanMemCoThe { get; set; } = new();
    }

    public class PhongThucHanhCreateViewModel
    {
        [Required(ErrorMessage = "Vui lòng nhập mã phòng")]
        [StringLength(20)]
        [Display(Name = "Mã phòng")]
        public string MaPhong { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập tên phòng")]
        [Display(Name = "Tên phòng")]
        public string TenPhong { get; set; } = string.Empty;

        [Display(Name = "Vị trí")]
        public string? ViTri { get; set; }

        [Required]
        [Range(1, 100)]
        [Display(Name = "Sức chứa")]
        public int SucChua { get; set; } = 40;

        [Display(Name = "Số máy hoạt động")]
        public int SoMayHoatDong { get; set; } = 40;

        [Display(Name = "Mô tả")]
        public string? MoTa { get; set; }

        [Display(Name = "Trạng thái hoạt động")]
        public bool TrangThaiHoatDong { get; set; } = true;

        public List<int>? PhanMemIds { get; set; }
    }

    public class KiemKeViewModel
    {
        public int Id { get; set; }
        public string TenPhong { get; set; } = string.Empty;
        public int SucChua { get; set; }
        public int SoMayHoatDongHienTai { get; set; }
        public List<int>? PhanMemIds { get; set; }
    }
}
