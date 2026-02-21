using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng phòng thực hành tại giảng đường E7
    /// Được quản lý bởi Trung tâm đào tạo thực hành
    /// </summary>
    public class PhongThucHanhNew
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(20)]
        public string MaPhong { get; set; } = string.Empty;

        [Required]
        [StringLength(100)]
        public string TenPhong { get; set; } = string.Empty;

        /// <summary>
        /// Vị trí (tầng, khu vực)
        /// </summary>
        [StringLength(100)]
        public string? ViTri { get; set; }

        /// <summary>
        /// Sức chứa (số máy)
        /// </summary>
        public int SucChua { get; set; }

        /// <summary>
        /// Số máy đang hoạt động
        /// </summary>
        public int SoMayHoatDong { get; set; }

        [StringLength(500)]
        public string? MoTa { get; set; }

        /// <summary>
        /// Trạng thái: true-Hoạt động, false-Bảo trì/Không hoạt động
        /// </summary>
        public bool TrangThaiHoatDong { get; set; } = true;

        /// <summary>
        /// Ngày kiểm kê gần nhất
        /// </summary>
        public DateTime? NgayKiemKeGanNhat { get; set; }

        /// <summary>
        /// Người kiểm kê
        /// </summary>
        public int? NguoiKiemKeId { get; set; }

        public DateTime NgayTao { get; set; } = DateTime.Now;

        public DateTime? NgayCapNhat { get; set; }

        // Navigation
        [ForeignKey("NguoiKiemKeId")]
        public virtual TaiKhoanNew? NguoiKiemKe { get; set; }

        public virtual ICollection<PhongThucHanhPhanMemNew>? PhanMems { get; set; }
        public virtual ICollection<LichThucHanhNew>? LichThucHanhs { get; set; }
    }
}
