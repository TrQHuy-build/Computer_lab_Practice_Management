using Microsoft.EntityFrameworkCore;
using QL_TH_MT.Data;
using QL_TH_MT.Infrastructure.Services;
using QL_TH_MT.Models;
using Xunit;
using FluentAssertions;

namespace QL_TH_MT.Tests.Services
{
    public class HocKyServiceTests : IDisposable
    {
        private readonly ApplicationDbContext _context;
        private readonly HocKyService _service;

        public HocKyServiceTests()
        {
            var options = new DbContextOptionsBuilder<ApplicationDbContext>()
                .UseInMemoryDatabase(databaseName: $"HocKyTestDb_{Guid.NewGuid()}")
                .Options;

            _context = new ApplicationDbContext(options);
            _service = new HocKyService(_context);
            SeedData();
        }

        private void SeedData()
        {
            // Tạo học kỳ hiện tại (đang trong giai đoạn 2)
            var hocKyHienTai = new HocKy
            {
                HocKyId = 1,
                TenHocKy = "HK2 2024-2025",
                NamHoc = 2025,
                SoHocKy = 2,
                NgayTienHocKy = DateTime.Now.AddDays(-10), // Tuần 2 tiền HK
                NgayBatDauHocKy = DateTime.Now.AddDays(18),
                NgayKetThucHocKy = DateTime.Now.AddDays(140),
                DangHoatDong = true
            };

            // Học kỳ đã kết thúc
            var hocKyCu = new HocKy
            {
                HocKyId = 2,
                TenHocKy = "HK1 2024-2025",
                NamHoc = 2024,
                SoHocKy = 1,
                NgayTienHocKy = DateTime.Now.AddDays(-180),
                NgayBatDauHocKy = DateTime.Now.AddDays(-150),
                NgayKetThucHocKy = DateTime.Now.AddDays(-30),
                DangHoatDong = false
            };

            _context.HocKys.AddRange(hocKyHienTai, hocKyCu);
            _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Database.EnsureDeleted();
            _context.Dispose();
        }

        #region GetHocKyHienTaiAsync Tests

        [Fact]
        public async Task GetHocKyHienTaiAsync_ShouldReturnActiveHocKy()
        {
            // Act
            var result = await _service.GetHocKyHienTaiAsync();

            // Assert
            result.Should().NotBeNull();
            result!.TenHocKy.Should().Be("HK2 2024-2025");
            result.DangHoatDong.Should().BeTrue();
        }

        [Fact]
        public async Task GetHocKyHienTaiAsync_ShouldNotReturnInactiveHocKy()
        {
            // Arrange - deactivate all
            var hocKy = await _context.HocKys.FirstAsync(h => h.HocKyId == 1);
            hocKy.DangHoatDong = false;
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.GetHocKyHienTaiAsync();

            // Assert
            result.Should().BeNull();
        }

        #endregion

        #region XacDinhGiaiDoan Tests

        [Fact]
        public void XacDinhGiaiDoan_ChuaBatDau_ShouldReturnCorrectGiaiDoan()
        {
            // Arrange
            var hocKy = new HocKy
            {
                NgayTienHocKy = DateTime.Now.AddDays(10),
                NgayBatDauHocKy = DateTime.Now.AddDays(38),
                NgayKetThucHocKy = DateTime.Now.AddDays(160)
            };

            // Act
            var result = _service.XacDinhGiaiDoan(hocKy);

            // Assert
            result.Should().Be(GiaiDoanHocKy.ChuaBatDau);
        }

        [Fact]
        public void XacDinhGiaiDoan_GiaiDoan1_ShouldReturnNhapHopDong()
        {
            // Arrange - Giai đoạn 1: Từ NgayTienHocKy đến +7 ngày
            var hocKy = new HocKy
            {
                NgayTienHocKy = DateTime.Now.AddDays(-3), // Đang trong tuần 1
                NgayBatDauHocKy = DateTime.Now.AddDays(25),
                NgayKetThucHocKy = DateTime.Now.AddDays(147)
            };

            // Act
            var result = _service.XacDinhGiaiDoan(hocKy);

            // Assert
            result.Should().Be(GiaiDoanHocKy.GD1_NhapHopDong);
        }

        [Fact]
        public void XacDinhGiaiDoan_GiaiDoan2_ShouldReturnGVDangKyLich()
        {
            // Arrange - Giai đoạn 2: Từ +7 đến +14 ngày
            var hocKy = new HocKy
            {
                NgayTienHocKy = DateTime.Now.AddDays(-10), // Đang trong tuần 2
                NgayBatDauHocKy = DateTime.Now.AddDays(18),
                NgayKetThucHocKy = DateTime.Now.AddDays(140)
            };

            // Act
            var result = _service.XacDinhGiaiDoan(hocKy);

            // Assert
            result.Should().Be(GiaiDoanHocKy.GD2_GVDangKyLich);
        }

        [Fact]
        public void XacDinhGiaiDoan_GiaiDoan3_ShouldReturnSapXepLich()
        {
            // Arrange - Giai đoạn 3: Từ +14 đến +21 ngày
            var hocKy = new HocKy
            {
                NgayTienHocKy = DateTime.Now.AddDays(-17), // Đang trong tuần 3
                NgayBatDauHocKy = DateTime.Now.AddDays(11),
                NgayKetThucHocKy = DateTime.Now.AddDays(133)
            };

            // Act
            var result = _service.XacDinhGiaiDoan(hocKy);

            // Assert
            result.Should().Be(GiaiDoanHocKy.GD3_SapXepLich);
        }

        [Fact]
        public void XacDinhGiaiDoan_GiaiDoan4_ShouldReturnThongBaoVaDieuChinh()
        {
            // Arrange - Giai đoạn 4: Từ +21 đến NgayBatDauHocKy
            var hocKy = new HocKy
            {
                NgayTienHocKy = DateTime.Now.AddDays(-24), // Đang trong tuần 4
                NgayBatDauHocKy = DateTime.Now.AddDays(4),
                NgayKetThucHocKy = DateTime.Now.AddDays(126)
            };

            // Act
            var result = _service.XacDinhGiaiDoan(hocKy);

            // Assert
            result.Should().Be(GiaiDoanHocKy.GD4_ThongBaoVaDieuChinh);
        }

        [Fact]
        public void XacDinhGiaiDoan_HocKyDienRa_ShouldReturnCorrectly()
        {
            // Arrange
            var hocKy = new HocKy
            {
                NgayTienHocKy = DateTime.Now.AddDays(-50),
                NgayBatDauHocKy = DateTime.Now.AddDays(-22), // Đã bắt đầu HK
                NgayKetThucHocKy = DateTime.Now.AddDays(100)
            };

            // Act
            var result = _service.XacDinhGiaiDoan(hocKy);

            // Assert
            result.Should().Be(GiaiDoanHocKy.HocKyDienRa);
        }

        [Fact]
        public void XacDinhGiaiDoan_ThoiGianOnThi_ShouldReturnCorrectly()
        {
            // Arrange - 3 tuần cuối là ôn thi
            var hocKy = new HocKy
            {
                NgayTienHocKy = DateTime.Now.AddDays(-140),
                NgayBatDauHocKy = DateTime.Now.AddDays(-112),
                NgayKetThucHocKy = DateTime.Now.AddDays(10) // Còn 10 ngày -> trong 3 tuần cuối
            };

            // Act
            var result = _service.XacDinhGiaiDoan(hocKy);

            // Assert
            result.Should().Be(GiaiDoanHocKy.ThoiGianOnThi);
        }

        [Fact]
        public void XacDinhGiaiDoan_DaKetThuc_ShouldReturnCorrectly()
        {
            // Arrange
            var hocKy = new HocKy
            {
                NgayTienHocKy = DateTime.Now.AddDays(-200),
                NgayBatDauHocKy = DateTime.Now.AddDays(-172),
                NgayKetThucHocKy = DateTime.Now.AddDays(-50) // Đã kết thúc
            };

            // Act
            var result = _service.XacDinhGiaiDoan(hocKy);

            // Assert
            result.Should().Be(GiaiDoanHocKy.DaKetThuc);
        }

        #endregion

        #region KiemTraQuyenTheoGiaiDoan Tests

        [Fact]
        public void KiemTraQuyenTheoGiaiDoan_NhapHopDong_PDT_ShouldReturnTrue()
        {
            // Arrange
            var giaiDoan = GiaiDoanHocKy.GD1_NhapHopDong;
            var vaiTroId = Constants.VaiTro.PDT;

            // Act
            var result = _service.KiemTraQuyenTheoGiaiDoan(giaiDoan, vaiTroId, "NhapHopDong");

            // Assert
            result.Should().BeTrue();
        }

        [Fact]
        public void KiemTraQuyenTheoGiaiDoan_NhapHopDong_GV_ShouldReturnFalse()
        {
            // Arrange
            var giaiDoan = GiaiDoanHocKy.GD1_NhapHopDong;
            var vaiTroId = Constants.VaiTro.GV_ThinhGiang;

            // Act
            var result = _service.KiemTraQuyenTheoGiaiDoan(giaiDoan, vaiTroId, "NhapHopDong");

            // Assert
            result.Should().BeFalse();
        }

        [Fact]
        public void KiemTraQuyenTheoGiaiDoan_DangKyLichDay_GVThinhGiang_GD2_ShouldReturnTrue()
        {
            // Arrange
            var giaiDoan = GiaiDoanHocKy.GD2_GVDangKyLich;
            var vaiTroId = Constants.VaiTro.GV_ThinhGiang;

            // Act
            var result = _service.KiemTraQuyenTheoGiaiDoan(giaiDoan, vaiTroId, "DangKyLichDay");

            // Assert
            result.Should().BeTrue();
        }

        [Fact]
        public void KiemTraQuyenTheoGiaiDoan_DangKyLichDay_GVCoHuu_ShouldReturnFalse()
        {
            // Arrange - GV cố hữu không cần đăng ký lịch
            var giaiDoan = GiaiDoanHocKy.GD2_GVDangKyLich;
            var vaiTroId = Constants.VaiTro.GV_CoHuu;

            // Act
            var result = _service.KiemTraQuyenTheoGiaiDoan(giaiDoan, vaiTroId, "DangKyLichDay");

            // Assert
            result.Should().BeFalse();
        }

        [Fact]
        public void KiemTraQuyenTheoGiaiDoan_DoiLich_GV_HocKyDienRa_ShouldReturnTrue()
        {
            // Arrange
            var giaiDoan = GiaiDoanHocKy.HocKyDienRa;
            var vaiTroId = Constants.VaiTro.GV_ThinhGiang;

            // Act
            var result = _service.KiemTraQuyenTheoGiaiDoan(giaiDoan, vaiTroId, "DoiLich");

            // Assert
            result.Should().BeTrue();
        }

        #endregion

        #region GetDanhSachHocKyAsync Tests

        [Fact]
        public async Task GetDanhSachHocKyAsync_ShouldReturnOrderedList()
        {
            // Act
            var result = await _service.GetDanhSachHocKyAsync();

            // Assert
            result.Should().HaveCount(2);
            result[0].NamHoc.Should().BeGreaterThanOrEqualTo(result[1].NamHoc);
        }

        #endregion

        #region TaoHocKyAsync Tests

        [Fact]
        public async Task TaoHocKyAsync_ShouldCreateAndReturnNewHocKy()
        {
            // Arrange
            var newHocKy = new HocKy
            {
                TenHocKy = "HK1 2025-2026",
                NamHoc = 2025,
                SoHocKy = 1,
                NgayTienHocKy = new DateTime(2025, 8, 1),
                NgayBatDauHocKy = new DateTime(2025, 9, 1),
                NgayKetThucHocKy = new DateTime(2026, 1, 15),
                DangHoatDong = true
            };

            // Act
            var result = await _service.TaoHocKyAsync(newHocKy);

            // Assert
            result.Should().NotBeNull();
            result.HocKyId.Should().BeGreaterThan(0);
            result.NgayTao.Should().BeCloseTo(DateTime.Now, TimeSpan.FromSeconds(5));

            var dbHocKy = await _context.HocKys.FindAsync(result.HocKyId);
            dbHocKy.Should().NotBeNull();
        }

        #endregion

        #region HocKy Properties Tests

        [Fact]
        public void HocKy_GiaiDoanProperties_ShouldCalculateCorrectly()
        {
            // Arrange
            var hocKy = new HocKy
            {
                NgayTienHocKy = new DateTime(2025, 8, 1),
                NgayBatDauHocKy = new DateTime(2025, 9, 1),
                NgayKetThucHocKy = new DateTime(2026, 1, 15)
            };

            // Assert - Giai đoạn 1
            hocKy.GiaiDoan1_BatDau.Should().Be(new DateTime(2025, 8, 1));
            hocKy.GiaiDoan1_KetThuc.Should().Be(new DateTime(2025, 8, 8));

            // Giai đoạn 2
            hocKy.GiaiDoan2_BatDau.Should().Be(new DateTime(2025, 8, 8));
            hocKy.GiaiDoan2_KetThuc.Should().Be(new DateTime(2025, 8, 15));

            // Giai đoạn 3
            hocKy.GiaiDoan3_BatDau.Should().Be(new DateTime(2025, 8, 15));
            hocKy.GiaiDoan3_KetThuc.Should().Be(new DateTime(2025, 8, 22));

            // Giai đoạn 4
            hocKy.GiaiDoan4_BatDau.Should().Be(new DateTime(2025, 8, 22));
            hocKy.GiaiDoan4_KetThuc.Should().Be(new DateTime(2025, 9, 1));

            // Ngày bắt đầu ôn thi (3 tuần trước kết thúc)
            hocKy.NgayBatDauOnThi.Should().Be(new DateTime(2025, 12, 25));
        }

        [Fact]
        public void HocKy_LaThoiGianOnThi_ShouldReturnCorrectly()
        {
            // Arrange
            var hocKy = new HocKy
            {
                NgayTienHocKy = new DateTime(2025, 8, 1),
                NgayBatDauHocKy = new DateTime(2025, 9, 1),
                NgayKetThucHocKy = new DateTime(2026, 1, 15)
            };

            // Assert
            hocKy.LaThoiGianOnThi(new DateTime(2025, 12, 20)).Should().BeFalse(); // Trước ôn thi
            hocKy.LaThoiGianOnThi(new DateTime(2025, 12, 26)).Should().BeTrue();  // Trong ôn thi
            hocKy.LaThoiGianOnThi(new DateTime(2026, 1, 10)).Should().BeTrue();   // Trong ôn thi
        }

        [Fact]
        public void HocKy_CoTheXepLichTH_ShouldReturnCorrectly()
        {
            // Arrange
            var hocKy = new HocKy
            {
                NgayTienHocKy = new DateTime(2025, 8, 1),
                NgayBatDauHocKy = new DateTime(2025, 9, 1),
                NgayKetThucHocKy = new DateTime(2026, 1, 15)
            };

            // Assert
            hocKy.CoTheXepLichTH(new DateTime(2025, 8, 20)).Should().BeFalse();  // Trước khi HK bắt đầu
            hocKy.CoTheXepLichTH(new DateTime(2025, 9, 15)).Should().BeTrue();   // Trong HK
            hocKy.CoTheXepLichTH(new DateTime(2025, 12, 26)).Should().BeFalse(); // Thời gian ôn thi
        }

        #endregion

        #region GetTenGiaiDoan Tests

        [Theory]
        [InlineData(GiaiDoanHocKy.ChuaBatDau, "Chưa bắt đầu")]
        [InlineData(GiaiDoanHocKy.GD1_NhapHopDong, "Tuần 1: Nhập hợp đồng")]
        [InlineData(GiaiDoanHocKy.GD2_GVDangKyLich, "Tuần 2: GV đăng ký lịch")]
        [InlineData(GiaiDoanHocKy.GD3_SapXepLich, "Tuần 3: Sắp xếp lịch")]
        [InlineData(GiaiDoanHocKy.GD4_ThongBaoVaDieuChinh, "Tuần 4: Thông báo & Điều chỉnh")]
        [InlineData(GiaiDoanHocKy.HocKyDienRa, "Học kỳ đang diễn ra")]
        [InlineData(GiaiDoanHocKy.ThoiGianOnThi, "Thời gian ôn thi")]
        [InlineData(GiaiDoanHocKy.DaKetThuc, "Đã kết thúc")]
        public void GetTenGiaiDoan_ShouldReturnCorrectName(GiaiDoanHocKy giaiDoan, string expectedName)
        {
            // Act
            var result = _service.GetTenGiaiDoan(giaiDoan);

            // Assert
            result.Should().Be(expectedName);
        }

        #endregion
    }
}
