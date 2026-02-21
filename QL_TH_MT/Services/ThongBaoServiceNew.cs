using Microsoft.EntityFrameworkCore;
using QL_TH_MT.Data;
using QL_TH_MT.Models;

namespace QL_TH_MT.Services
{
    /// <summary>
    /// Service quản lý thông báo
    /// </summary>
    public class ThongBaoServiceNew
    {
        private readonly NewAppDbContext _context;

        public ThongBaoServiceNew(NewAppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Gửi thông báo
        /// </summary>
        public async Task GuiThongBao(string tieuDe, string noiDung, string loaiThongBao,
            int nguoiNhanId, int? nguoiGuiId = null, string? linkLienQuan = null)
        {
            var thongBao = new ThongBaoNew
            {
                TieuDe = tieuDe,
                NoiDung = noiDung,
                LoaiThongBao = loaiThongBao,
                NguoiNhanId = nguoiNhanId,
                NguoiGuiId = nguoiGuiId,
                LinkLienQuan = linkLienQuan,
                DaDoc = false,
                NgayTao = DateTime.Now
            };

            _context.ThongBaos.Add(thongBao);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Gửi thông báo đến nhiều người
        /// </summary>
        public async Task GuiThongBaoNhieu(string tieuDe, string noiDung, string loaiThongBao,
            List<int> danhSachNguoiNhanId, int? nguoiGuiId = null, string? linkLienQuan = null)
        {
            var danhSachThongBao = danhSachNguoiNhanId.Select(id => new ThongBaoNew
            {
                TieuDe = tieuDe,
                NoiDung = noiDung,
                LoaiThongBao = loaiThongBao,
                NguoiNhanId = id,
                NguoiGuiId = nguoiGuiId,
                LinkLienQuan = linkLienQuan,
                DaDoc = false,
                NgayTao = DateTime.Now
            }).ToList();

            _context.ThongBaos.AddRange(danhSachThongBao);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Gửi thông báo đến tất cả người dùng theo vai trò
        /// </summary>
        public async Task GuiThongBaoTheoVaiTro(string tieuDe, string noiDung, string loaiThongBao,
            LoaiVaiTro vaiTro, int? nguoiGuiId = null, string? linkLienQuan = null)
        {
            var danhSachNguoiNhan = await _context.TaiKhoans
                .Where(t => t.VaiTro == vaiTro && t.TrangThaiHoatDong)
                .Select(t => t.Id)
                .ToListAsync();

            await GuiThongBaoNhieu(tieuDe, noiDung, loaiThongBao, danhSachNguoiNhan, nguoiGuiId, linkLienQuan);
        }

        /// <summary>
        /// Thông báo lịch thực hành đến giảng viên
        /// </summary>
        public async Task ThongBaoLichThucHanh(int giangVienId, LichThucHanhNew lich)
        {
            var hocPhan = await _context.HocPhans
                .Include(hp => hp.MonHoc)
                .FirstOrDefaultAsync(hp => hp.Id == lich.HocPhanId);

            var phong = await _context.PhongThucHanhs.FindAsync(lich.PhongThucHanhId);

            var tieuDe = $"Lịch thực hành mới: {hocPhan?.TenHocPhan}";
            var noiDung = $"Bạn có lịch thực hành:\n" +
                $"- Học phần: {hocPhan?.TenHocPhan}\n" +
                $"- Ngày: {lich.NgayThucHanh:dd/MM/yyyy}\n" +
                $"- Ca: {lich.CaHoc}\n" +
                $"- Phòng: {phong?.TenPhong}\n" +
                $"- Buổi: {lich.BuoiThu}/3";

            await GuiThongBao(tieuDe, noiDung, "LichThucHanh", giangVienId, null, $"/LichThucHanh/ChiTiet/{lich.Id}");
        }

        /// <summary>
        /// Thông báo yêu cầu duyệt
        /// </summary>
        public async Task ThongBaoYeuCauDuyet(string loaiYeuCau, int yeuCauId, int nguoiGuiId,
            LoaiVaiTro vaiTroNguoiDuyet)
        {
            var nguoiGui = await _context.TaiKhoans.FindAsync(nguoiGuiId);

            var tieuDe = $"Yêu cầu {loaiYeuCau} cần duyệt";
            var noiDung = $"Có yêu cầu {loaiYeuCau} mới từ {nguoiGui?.HoTen} cần được phê duyệt.";

            await GuiThongBaoTheoVaiTro(tieuDe, noiDung, "YeuCauDuyet", vaiTroNguoiDuyet, nguoiGuiId,
                $"/YeuCau/ChiTiet/{loaiYeuCau}/{yeuCauId}");
        }

        /// <summary>
        /// Lấy danh sách thông báo của người dùng
        /// </summary>
        public async Task<List<ThongBaoNew>> GetThongBao(int nguoiNhanId, int soLuong = 20)
        {
            return await _context.ThongBaos
                .Include(t => t.NguoiGui)
                .Where(t => t.NguoiNhanId == nguoiNhanId)
                .OrderByDescending(t => t.NgayTao)
                .Take(soLuong)
                .ToListAsync();
        }

        /// <summary>
        /// Đếm số thông báo chưa đọc
        /// </summary>
        public async Task<int> DemThongBaoChuaDoc(int nguoiNhanId)
        {
            return await _context.ThongBaos
                .CountAsync(t => t.NguoiNhanId == nguoiNhanId && !t.DaDoc);
        }

        /// <summary>
        /// Đánh dấu đã đọc
        /// </summary>
        public async Task DanhDauDaDoc(int thongBaoId)
        {
            var thongBao = await _context.ThongBaos.FindAsync(thongBaoId);
            if (thongBao != null)
            {
                thongBao.DaDoc = true;
                thongBao.NgayDoc = DateTime.Now;
                await _context.SaveChangesAsync();
            }
        }

        /// <summary>
        /// Đánh dấu tất cả đã đọc
        /// </summary>
        public async Task DanhDauTatCaDaDoc(int nguoiNhanId)
        {
            var thongBaos = await _context.ThongBaos
                .Where(t => t.NguoiNhanId == nguoiNhanId && !t.DaDoc)
                .ToListAsync();

            foreach (var tb in thongBaos)
            {
                tb.DaDoc = true;
                tb.NgayDoc = DateTime.Now;
            }

            await _context.SaveChangesAsync();
        }
    }
}
