using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng tài khoản người dùng trong hệ thống
    /// </summary>
    public class TaiKhoanNew
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(50)]
        public string TenDangNhap { get; set; } = string.Empty;

        [Required]
        [StringLength(256)]
        public string MatKhauHash { get; set; } = string.Empty;

        [Required]
        [StringLength(100)]
        public string HoTen { get; set; } = string.Empty;

        [StringLength(100)]
        public string? Email { get; set; }

        [StringLength(20)]
        public string? SoDienThoai { get; set; }

        /// <summary>
        /// Vai trò: Admin, PhongDaoTao, TrungTamTHuc, GiangVienThinhGiang, GiangVienCoHuu
        /// </summary>
        [Required]
        public LoaiVaiTro VaiTro { get; set; }

        /// <summary>
        /// Loại giảng viên (chỉ áp dụng nếu vai trò là GiangVien)
        /// </summary>
        public LoaiGiangVien? LoaiGiangVien { get; set; }

        public bool TrangThaiHoatDong { get; set; } = true;

        public DateTime NgayTao { get; set; } = DateTime.Now;

        public DateTime? LanDangNhapCuoi { get; set; }
    }

    /// <summary>
    /// Enum các vai trò trong hệ thống
    /// </summary>
    public enum LoaiVaiTro
    {
        Admin = 1,
        PhongDaoTao = 2,
        TrungTamDaoTaoThucHanh = 3,
        GiangVien = 4
    }

    /// <summary>
    /// Enum loại giảng viên
    /// </summary>
    public enum LoaiGiangVien
    {
        ThinhGiang = 1,
        CoHuu = 2
    }
}
