using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng phần mềm được cài đặt tại phòng thực hành
    /// </summary>
    public class PhanMemNew
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        public string TenPhanMem { get; set; } = string.Empty;

        [StringLength(50)]
        public string? PhienBan { get; set; }

        [StringLength(500)]
        public string? MoTa { get; set; }

        /// <summary>
        /// Dung lượng cài đặt (MB)
        /// </summary>
        public int? DungLuong { get; set; }

        public bool TrangThaiHoatDong { get; set; } = true;

        public DateTime NgayTao { get; set; } = DateTime.Now;

        // Navigation
        public virtual ICollection<PhongThucHanhPhanMemNew>? PhongThucHanhs { get; set; }
    }

    /// <summary>
    /// Bảng liên kết phòng thực hành với phần mềm
    /// </summary>
    public class PhongThucHanhPhanMemNew
    {
        [Key]
        public int Id { get; set; }

        public int PhongThucHanhId { get; set; }

        public int PhanMemId { get; set; }

        /// <summary>
        /// Ngày cài đặt phần mềm vào phòng
        /// </summary>
        public DateTime NgayCaiDat { get; set; } = DateTime.Now;

        /// <summary>
        /// Người cài đặt
        /// </summary>
        public int? NguoiCaiDatId { get; set; }

        /// <summary>
        /// Ghi chú
        /// </summary>
        [StringLength(500)]
        public string? GhiChu { get; set; }

        // Navigation
        [ForeignKey("PhongThucHanhId")]
        public virtual PhongThucHanhNew? PhongThucHanh { get; set; }

        [ForeignKey("PhanMemId")]
        public virtual PhanMemNew? PhanMem { get; set; }

        [ForeignKey("NguoiCaiDatId")]
        public virtual TaiKhoanNew? NguoiCaiDat { get; set; }
    }
}
