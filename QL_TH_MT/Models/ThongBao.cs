using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng thông báo trong hệ thống
    /// </summary>
    public class ThongBaoNew
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(200)]
        public string TieuDe { get; set; } = string.Empty;

        [Required]
        public string NoiDung { get; set; } = string.Empty;

        /// <summary>
        /// Loại thông báo: LichThucHanh, YeuCauDuyet, ThayDoiLich, HeThong
        /// </summary>
        [Required]
        [StringLength(50)]
        public string LoaiThongBao { get; set; } = string.Empty;

        /// <summary>
        /// Người gửi (null = hệ thống)
        /// </summary>
        public int? NguoiGuiId { get; set; }

        /// <summary>
        /// Người nhận
        /// </summary>
        public int NguoiNhanId { get; set; }

        /// <summary>
        /// Đã đọc hay chưa
        /// </summary>
        public bool DaDoc { get; set; } = false;

        /// <summary>
        /// Link liên quan (nếu có)
        /// </summary>
        [StringLength(500)]
        public string? LinkLienQuan { get; set; }

        public DateTime NgayTao { get; set; } = DateTime.Now;

        public DateTime? NgayDoc { get; set; }

        // Navigation
        [ForeignKey("NguoiGuiId")]
        public virtual TaiKhoanNew? NguoiGui { get; set; }

        [ForeignKey("NguoiNhanId")]
        public virtual TaiKhoanNew? NguoiNhan { get; set; }
    }
}
