using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng hợp đồng giảng dạy - liên kết giảng viên với nhiều môn học trong học kỳ
    /// Được nhập bởi Phòng Đào tạo trong Tuần 1 của giai đoạn "Trước học kỳ"
    /// </summary>
    public class HopDongNew
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(50)]
        public string SoHopDong { get; set; } = string.Empty;

        // Foreign Keys
        public int GiangVienId { get; set; }

        public int HocKyId { get; set; }

        /// <summary>
        /// Ghi chú về hợp đồng
        /// </summary>
        [StringLength(500)]
        public string? GhiChu { get; set; }

        /// <summary>
        /// Trạng thái: 0-Mới tạo, 1-Đã xác nhận, 2-Đã hủy
        /// </summary>
        public int TrangThai { get; set; } = 0;

        public DateTime NgayTao { get; set; } = DateTime.Now;

        public int? NguoiTaoId { get; set; }

        // Navigation
        [ForeignKey("GiangVienId")]
        public virtual TaiKhoanNew? GiangVien { get; set; }

        [ForeignKey("HocKyId")]
        public virtual HocKyNew? HocKy { get; set; }

        [ForeignKey("NguoiTaoId")]
        public virtual TaiKhoanNew? NguoiTao { get; set; }

        /// <summary>
        /// Danh sách môn học trong hợp đồng (many-to-many)
        /// </summary>
        public virtual ICollection<HopDongMonHocNew>? HopDongMonHocs { get; set; }

        public virtual ICollection<DangKyLichThinhGiangNew>? DangKyLichs { get; set; }
    }
}
