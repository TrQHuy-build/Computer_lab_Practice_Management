using System.ComponentModel.DataAnnotations;
using QL_TH_MT.Models;

namespace QL_TH_MT.ViewModels
{
    // ====== YÊU CẦU MƯỢN BÙ ======
    public class YeuCauMuonBuViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn lịch cần thay đổi")]
        [Display(Name = "Lịch thực hành")]
        public int LichThucHanhGocId { get; set; }

        public int GiangVienId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày gốc")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày gốc")]
        public DateTime NgayGoc { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ngày mới")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày mới (trong vòng 1 tuần)")]
        public DateTime NgayMoi { get; set; }

        // CaHocMoi là optional - Range validation sẽ skip null values
        [Display(Name = "Ca học mới")]
        public int? CaHocMoi { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập lý do")]
        [StringLength(500)]
        [Display(Name = "Lý do")]
        public string LyDo { get; set; } = string.Empty;

        // Thông tin hiển thị
        public string? TenHocPhan { get; set; }
        public string? TenPhong { get; set; }
        public int TrangThai { get; set; }
        public string? TrangThaiStr { get; set; }
    }

    public class DuyetMuonBuViewModel
    {
        public int YeuCauId { get; set; }
        public YeuCauMuonBuNew YeuCau { get; set; } = null!;

        [Required]
        [Display(Name = "Kết quả")]
        public bool Duyet { get; set; }

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }
    }

    // ====== YÊU CẦU ĐỔI PHÒNG ======
    public class YeuCauDoiPhongViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn lịch cần thay đổi")]
        [Display(Name = "Lịch thực hành")]
        public int LichThucHanhGocId { get; set; }

        public int GiangVienId { get; set; }

        // Thông tin gốc
        public DateTime NgayThucHanhGoc { get; set; }
        public int CaHocGoc { get; set; }
        public int PhongGocId { get; set; }
        public string? TenPhongGoc { get; set; }

        // Thông tin mới
        [DataType(DataType.Date)]
        [Display(Name = "Ngày thực hành mới")]
        public DateTime? NgayThucHanhMoi { get; set; }

        // CaHocMoi là optional - Range validation sẽ skip null values
        [Display(Name = "Ca học mới")]
        public int? CaHocMoi { get; set; }

        [Display(Name = "Phòng mới")]
        public int? PhongMoiId { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập lý do")]
        [StringLength(500)]
        [Display(Name = "Lý do")]
        public string LyDo { get; set; } = string.Empty;

        // Thông tin hiển thị
        public string? TenHocPhan { get; set; }
        public int TrangThai { get; set; }
        public string? TrangThaiStr { get; set; }

        // Danh sách phòng có thể chọn
        public List<PhongThucHanhNew> DanhSachPhong { get; set; } = new();
    }

    public class DuyetDoiPhongViewModel
    {
        public int YeuCauId { get; set; }
        public YeuCauDoiPhongNew YeuCau { get; set; } = null!;

        [Required]
        [Display(Name = "Kết quả")]
        public bool Duyet { get; set; }

        [StringLength(500)]
        [Display(Name = "Ghi chú")]
        public string? GhiChu { get; set; }
    }

    // ====== DANH SÁCH YÊU CẦU CHỜ DUYỆT ======
    public class DanhSachYeuCauViewModel
    {
        public List<YeuCauMuonBuNew> YeuCauMuonBus { get; set; } = new();
        public List<YeuCauDoiPhongNew> YeuCauDoiPhongs { get; set; } = new();

        public int TongYeuCau => YeuCauMuonBus.Count + YeuCauDoiPhongs.Count;
    }
}
