using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng yêu cầu đổi phòng - thay đổi ngày/ca/phòng thực hành
    /// </summary>
    public class YeuCauDoiPhongNew
    {
        [Key]
        public int Id { get; set; }

        /// <summary>
        /// Lịch thực hành gốc cần thay đổi
        /// </summary>
        public int LichThucHanhGocId { get; set; }

        /// <summary>
        /// Giảng viên yêu cầu
        /// </summary>
        public int GiangVienId { get; set; }

        // ====== THÔNG TIN GỐC ======
        public DateTime NgayThucHanhGoc { get; set; }
        public int CaHocGoc { get; set; }
        public int PhongGocId { get; set; }

        // ====== THÔNG TIN MỚI ======
        /// <summary>
        /// Ngày thực hành mới (có thể thay đổi)
        /// </summary>
        public DateTime? NgayThucHanhMoi { get; set; }

        /// <summary>
        /// Ca học mới (có thể thay đổi)
        /// </summary>
        public int? CaHocMoi { get; set; }

        /// <summary>
        /// Phòng mới (có thể thay đổi)
        /// </summary>
        public int? PhongMoiId { get; set; }

        /// <summary>
        /// Lý do đổi phòng
        /// </summary>
        [Required]
        [StringLength(500)]
        public string LyDo { get; set; } = string.Empty;

        /// <summary>
        /// Trạng thái: 0-Chờ PDT duyệt, 1-PDT đồng ý chờ TTDT, 2-Cả hai đồng ý, 3-Từ chối
        /// </summary>
        public int TrangThai { get; set; } = 0;

        public DateTime NgayTao { get; set; } = DateTime.Now;

        // Duyệt từ Phòng đào tạo
        public int? NguoiDuyetPDTId { get; set; }
        public DateTime? NgayDuyetPDT { get; set; }
        public bool? KetQuaDuyetPDT { get; set; }
        [StringLength(500)]
        public string? GhiChuPDT { get; set; }

        // Duyệt từ Trung tâm đào tạo
        public int? NguoiDuyetTTDTId { get; set; }
        public DateTime? NgayDuyetTTDT { get; set; }
        public bool? KetQuaDuyetTTDT { get; set; }
        [StringLength(500)]
        public string? GhiChuTTDT { get; set; }

        // Navigation
        [ForeignKey("LichThucHanhGocId")]
        public virtual LichThucHanhNew? LichThucHanhGoc { get; set; }

        [ForeignKey("GiangVienId")]
        public virtual TaiKhoanNew? GiangVien { get; set; }

        [ForeignKey("PhongGocId")]
        public virtual PhongThucHanhNew? PhongGoc { get; set; }

        [ForeignKey("PhongMoiId")]
        public virtual PhongThucHanhNew? PhongMoi { get; set; }

        [ForeignKey("NguoiDuyetPDTId")]
        public virtual TaiKhoanNew? NguoiDuyetPDT { get; set; }

        [ForeignKey("NguoiDuyetTTDTId")]
        public virtual TaiKhoanNew? NguoiDuyetTTDT { get; set; }
    }
}
