using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng lịch thực hành - kết quả sau khi sắp xếp lịch
    /// </summary>
    public class LichThucHanhNew
    {
        [Key]
        public int Id { get; set; }

        public int HocPhanId { get; set; }

        public int PhongThucHanhId { get; set; }

        public int HocKyId { get; set; }

        /// <summary>
        /// Tuần học trong học kỳ
        /// </summary>
        [Required]
        public int TuanHoc { get; set; }

        /// <summary>
        /// Thứ trong tuần (2-8, 8 = Chủ nhật)
        /// </summary>
        [Required]
        public int ThuTrongTuan { get; set; }

        /// <summary>
        /// Ca học (1-6)
        /// </summary>
        [Required]
        [Range(1, 6)]
        public int CaHoc { get; set; }

        /// <summary>
        /// Ngày thực hành cụ thể
        /// </summary>
        [Required]
        public DateTime NgayThucHanh { get; set; }

        /// <summary>
        /// Buổi thứ mấy (1, 2, 3)
        /// </summary>
        public int BuoiThu { get; set; }

        /// <summary>
        /// Trạng thái: 0-Dự kiến, 1-PDT duyệt, 2-TTDT duyệt, 3-Hoàn thành, 4-Hủy
        /// </summary>
        public int TrangThai { get; set; } = 0;

        [StringLength(500)]
        public string? GhiChu { get; set; }

        /// <summary>
        /// Người tạo lịch (Phòng đào tạo)
        /// </summary>
        public int? NguoiTaoId { get; set; }

        public DateTime NgayTao { get; set; } = DateTime.Now;

        /// <summary>
        /// Người duyệt từ TTDT
        /// </summary>
        public int? NguoiDuyetTTDTId { get; set; }

        public DateTime? NgayDuyetTTDT { get; set; }

        // Navigation
        [ForeignKey("HocPhanId")]
        public virtual HocPhanNew? HocPhan { get; set; }

        [ForeignKey("PhongThucHanhId")]
        public virtual PhongThucHanhNew? PhongThucHanh { get; set; }

        [ForeignKey("HocKyId")]
        public virtual HocKyNew? HocKy { get; set; }

        [ForeignKey("NguoiTaoId")]
        public virtual TaiKhoanNew? NguoiTao { get; set; }

        [ForeignKey("NguoiDuyetTTDTId")]
        public virtual TaiKhoanNew? NguoiDuyetTTDT { get; set; }
    }
}
