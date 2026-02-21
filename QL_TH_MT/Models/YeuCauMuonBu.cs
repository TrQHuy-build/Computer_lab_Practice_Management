using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng yêu cầu mượn bù - đổi ngày thực hành
    /// Giảng viên có thể chọn 1 ngày muốn đổi và 1 ngày khác (không quá 1 tuần)
    /// </summary>
    public class YeuCauMuonBuNew
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

        /// <summary>
        /// Ngày gốc cần đổi
        /// </summary>
        [Required]
        public DateTime NgayGoc { get; set; }

        /// <summary>
        /// Ngày mới muốn đổi sang (không quá 1 tuần so với ngày gốc)
        /// </summary>
        [Required]
        public DateTime NgayMoi { get; set; }

        /// <summary>
        /// Ca học mới (nếu thay đổi)
        /// </summary>
        public int? CaHocMoi { get; set; }

        /// <summary>
        /// Lý do mượn bù
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

        [ForeignKey("NguoiDuyetPDTId")]
        public virtual TaiKhoanNew? NguoiDuyetPDT { get; set; }

        [ForeignKey("NguoiDuyetTTDTId")]
        public virtual TaiKhoanNew? NguoiDuyetTTDT { get; set; }
    }
}
