using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QL_TH_MT.Models
{
    /// <summary>
    /// Bảng trung gian liên kết hợp đồng với nhiều môn học (many-to-many)
    /// </summary>
    public class HopDongMonHocNew
    {
        [Key]
        public int Id { get; set; }

        public int HopDongId { get; set; }

        public int MonHocId { get; set; }

        // Navigation
        [ForeignKey("HopDongId")]
        public virtual HopDongNew? HopDong { get; set; }

        [ForeignKey("MonHocId")]
        public virtual MonHocNew? MonHoc { get; set; }
    }
}
