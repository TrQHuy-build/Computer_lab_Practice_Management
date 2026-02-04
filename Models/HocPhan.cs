using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng học phần (lớp học cụ thể của môn học trong học kỳ)
    /// </summary>
    public class HocPhanNew
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(30)]
        public string MaHocPhan { get; set; } = string.Empty;

        /// <summary>
        /// Tên học phần (thường = Tên môn học + nhóm)
        /// </summary>
        [Required]
        [StringLength(200)]
        public string TenHocPhan { get; set; } = string.Empty;

        /// <summary>
        /// Nhóm/lớp (VD: 01, 02, ...)
        /// </summary>
        [StringLength(10)]
        public string? Nhom { get; set; }

        /// <summary>
        /// Sĩ số lớp
        /// </summary>
        public int SiSo { get; set; }

        // Foreign Keys
        public int MonHocId { get; set; }

        public int HocKyId { get; set; }

        public int? GiangVienId { get; set; }

        // Navigation
        [ForeignKey("MonHocId")]
        public virtual MonHocNew? MonHoc { get; set; }

        [ForeignKey("HocKyId")]
        public virtual HocKyNew? HocKy { get; set; }

        [ForeignKey("GiangVienId")]
        public virtual TaiKhoanNew? GiangVien { get; set; }

        public virtual ICollection<LichThucHanhNew>? LichThucHanhs { get; set; }

        public bool TrangThaiHoatDong { get; set; } = true;

        public DateTime NgayTao { get; set; } = DateTime.Now;
    }
}
