using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng môn học
    /// </summary>
    public class MonHocNew
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(20)]
        public string MaMonHoc { get; set; } = string.Empty;

        [Required]
        [StringLength(200)]
        public string TenMonHoc { get; set; } = string.Empty;

        /// <summary>
        /// Số tín chỉ (1, 2, 3, 4)
        /// Dùng để tính số tuần lý thuyết:
        /// n=0 nếu TC=1; n=4 nếu TC=2; n=6 nếu TC=3; n=8 nếu TC=4
        /// </summary>
        [Required]
        [Range(1, 10)]
        public int SoTinChi { get; set; }

        /// <summary>
        /// Số buổi thực hành (mặc định = 3)
        /// </summary>
        public int SoBuoiThucHanh { get; set; } = 3;

        [StringLength(500)]
        public string? MoTa { get; set; }

        public bool TrangThaiHoatDong { get; set; } = true;

        public DateTime NgayTao { get; set; } = DateTime.Now;

        // Navigation
        public virtual ICollection<HopDongMonHocNew>? HopDongMonHocs { get; set; }
        public virtual ICollection<HocPhanNew>? HocPhans { get; set; }
    }
}
