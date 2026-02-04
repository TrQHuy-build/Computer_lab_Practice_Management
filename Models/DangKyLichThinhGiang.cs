using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng đăng ký lịch giảng dạy của giảng viên thỉnh giảng
    /// Được sử dụng trong Tuần 2 của giai đoạn "Trước học kỳ"
    /// </summary>
    public class DangKyLichThinhGiangNew
    {
        [Key]
        public int Id { get; set; }

        public int HopDongId { get; set; }

        public int GiangVienId { get; set; }

        public int HocKyId { get; set; }

        /// <summary>
        /// Thứ trong tuần có thể giảng dạy (2-8, 8 = Chủ nhật)
        /// </summary>
        [Required]
        public int ThuTrongTuan { get; set; }

        /// <summary>
        /// Ca học (1-6)
        /// Ca 1: 7h00-9h30
        /// Ca 2: 9h30-12h00
        /// Ca 3: 12h30-15h00
        /// Ca 4: 15h00-17h30
        /// Ca 5: 17h30-20h00
        /// Ca 6: 20h00-22h30
        /// </summary>
        [Required]
        [Range(1, 6)]
        public int CaHoc { get; set; }

        /// <summary>
        /// Số tuần liên tiếp (mặc định tối thiểu 3)
        /// </summary>
        public int SoTuanLienTiep { get; set; } = 3;

        /// <summary>
        /// Tuần bắt đầu có thể giảng dạy
        /// </summary>
        public int? TuanBatDau { get; set; }

        /// <summary>
        /// Ghi chú từ giảng viên
        /// </summary>
        [StringLength(500)]
        public string? GhiChu { get; set; }

        /// <summary>
        /// Trạng thái: 0-Chờ duyệt, 1-PDT đã duyệt, 2-Từ chối
        /// </summary>
        public int TrangThai { get; set; } = 0;

        public DateTime NgayDangKy { get; set; } = DateTime.Now;

        /// <summary>
        /// Người duyệt (Phòng đào tạo)
        /// </summary>
        public int? NguoiDuyetId { get; set; }

        public DateTime? NgayDuyet { get; set; }

        [StringLength(500)]
        public string? LyDoTuChoi { get; set; }

        // Navigation
        [ForeignKey("HopDongId")]
        public virtual HopDongNew? HopDong { get; set; }

        [ForeignKey("GiangVienId")]
        public virtual TaiKhoanNew? GiangVien { get; set; }

        [ForeignKey("HocKyId")]
        public virtual HocKyNew? HocKy { get; set; }

        [ForeignKey("NguoiDuyetId")]
        public virtual TaiKhoanNew? NguoiDuyet { get; set; }
    }
}
