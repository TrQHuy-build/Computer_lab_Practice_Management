using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng học kỳ với các mốc thời gian quan trọng
    /// </summary>
    public class HocKyNew
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(50)]
        public string TenHocKy { get; set; } = string.Empty;

        /// <summary>
        /// Năm học (VD: 2025-2026)
        /// </summary>
        [Required]
        [StringLength(20)]
        public string NamHoc { get; set; } = string.Empty;

        /// <summary>
        /// Học kỳ 1, 2 hoặc hè
        /// </summary>
        public int SoHocKy { get; set; }

        // ====== 3 MỐC THỜI GIAN CHÍNH ======

        /// <summary>
        /// Mốc "Tiền học kỳ" - bắt đầu giai đoạn chuẩn bị
        /// </summary>
        [Required]
        public DateTime TienHocKy { get; set; }

        /// <summary>
        /// Mốc "Bắt đầu học kỳ" - kết thúc giai đoạn chuẩn bị, bắt đầu học
        /// </summary>
        [Required]
        public DateTime BatDauHocKy { get; set; }

        /// <summary>
        /// Mốc "Kết thúc học kỳ"
        /// </summary>
        [Required]
        public DateTime KetThucHocKy { get; set; }

        // ====== CÁC GIAI ĐOẠN TRONG "TRƯỚC HỌC KỲ" (4 tuần) ======

        /// <summary>
        /// Tuần 1: Kết thúc nhập hợp đồng và kiểm kê phòng
        /// </summary>
        public DateTime? KetThucNhapHopDong { get; set; }

        /// <summary>
        /// Tuần 2: Kết thúc đăng ký lịch GV thỉnh giảng
        /// </summary>
        public DateTime? KetThucDangKyLich { get; set; }

        /// <summary>
        /// Tuần 3: Kết thúc sắp xếp lịch
        /// </summary>
        public DateTime? KetThucSapXepLich { get; set; }

        /// <summary>
        /// Tuần 4: Kết thúc thông báo và thay đổi (= BatDauHocKy)
        /// </summary>
        public DateTime? KetThucThongBao { get; set; }

        // ====== TRẠNG THÁI ======

        /// <summary>
        /// Trạng thái: 0-Chưa bắt đầu, 1-Đang diễn ra, 2-Đã kết thúc
        /// </summary>
        public int TrangThai { get; set; } = 0;

        /// <summary>
        /// Học kỳ hiện tại đang active
        /// </summary>
        public bool IsActive { get; set; } = false;

        public DateTime NgayTao { get; set; } = DateTime.Now;

        public int? NguoiTaoId { get; set; }

        [ForeignKey("NguoiTaoId")]
        public virtual TaiKhoanNew? NguoiTao { get; set; }

        // Navigation
        public virtual ICollection<HopDongNew>? HopDongs { get; set; }
        public virtual ICollection<LichThucHanhNew>? LichThucHanhs { get; set; }
    }

    /// <summary>
    /// Enum giai đoạn trong học kỳ
    /// </summary>
    public enum GiaiDoanHocKy
    {
        ChuaBatDau = 0,
        Tuan1_NhapHopDong = 1,
        Tuan2_DangKyLich = 2,
        Tuan3_SapXepLich = 3,
        Tuan4_ThongBao = 4,
        DangHoc_LyThuyet = 5,
        DangHoc_ThucHanh = 6,
        DangHoc_OnTapThi = 7,
        DaKetThuc = 8
    }
}
