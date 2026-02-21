using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Moq;
using QL_TH_MT.Core.Interfaces;
using QL_TH_MT.Data;
using QL_TH_MT.Infrastructure;
using QL_TH_MT.Infrastructure.Services;
using QL_TH_MT.Models;
using QL_TH_MT.Services;
using QL_TH_MT.ViewModels;
using FluentAssertions;
using Xunit;

namespace QL_TH_MT.Tests.Services
{
    /// <summary>
    /// Unit Tests cho DangKyPhongService
    /// </summary>
    public class DangKyPhongServiceTests : IDisposable
    {
        private readonly ApplicationDbContext _context;
        private readonly DangKyPhongService _service;
        private readonly Mock<IThongBaoService> _mockThongBaoService;
        private readonly IConfiguration _mockConfiguration;
        private readonly Mock<ILogger<DangKyPhongService>> _mockLogger;
        private readonly IUnitOfWork _unitOfWork;

        public DangKyPhongServiceTests()
        {
            // Setup InMemory Database
            var options = new DbContextOptionsBuilder<ApplicationDbContext>()
                .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
                .Options;

            _context = new ApplicationDbContext(options);
            _unitOfWork = new UnitOfWork(_context);

            // Setup Mocks
            _mockThongBaoService = new Mock<IThongBaoService>();
            _mockLogger = new Mock<ILogger<DangKyPhongService>>();

            // Setup configuration - dùng ConfigurationBuilder thay vì Mock
            // vì extension method GetValue<T> không thể mock được
            var inMemorySettings = new Dictionary<string, string?> {
                {"BookingSettings:MinDaysBeforeBooking", "3"},
            };
            _mockConfiguration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            _service = new DangKyPhongService(
                _unitOfWork,
                _mockThongBaoService.Object,
                _mockConfiguration,
                _mockLogger.Object);

            // Seed test data
            SeedTestData();
        }

        private void SeedTestData()
        {
            // Thêm phòng máy
            _context.PhongMays.Add(new PhongMay
            {
                PhongMayId = 1,
                MaPhong = "A101",
                TenPhong = "Phòng A101",
                SoLuongMay = 40,
                SoMayHong = 0,
                TrangThai = true
            });

            // Thêm học phần
            _context.HocPhans.Add(new HocPhan
            {
                HocPhanId = 1,
                MaHocPhan = "CS101",
                TenHocPhan = "Lập trình cơ bản",
                TrangThaiHoatDong = true
            });

            // Thêm nhân viên (giáo viên)
            _context.NhanViens.Add(new NhanVien
            {
                MaNhanVien = 1,
                HoTen = "Nguyễn Văn A",
                Email = "nguyenvana@example.com"
            });

            // Thêm tài khoản
            _context.TaiKhoans.Add(new TaiKhoan
            {
                TaiKhoanId = 1,
                MaNhanVien = 1,
                TenDangNhap = "gv",
                MatKhau = "123456",
                VaiTroId = 5,
                IsActive = true
            });

            _context.SaveChanges();
        }

        [Fact]
        public async Task TaoDangKy_WithValidData_ShouldReturnSuccess()
        {
            // Arrange
            var model = new DangKyPhongViewModel
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30,
                PhanMemIds = new List<int>()
            };

            // Act
            var result = await _service.TaoDangKyAsync(model, maNhanVien: 1, vaiTroId: 3);

            // Assert
            result.Success.Should().BeTrue();
            result.Data.Should().NotBeNull();
            result.Data!.TrangThai.Should().Be(TrangThaiDangKy.ChoDuyetTTDT);
        }

        [Fact]
        public async Task TaoDangKy_WithExceedCapacity_ShouldReturnError()
        {
            // Arrange
            var model = new DangKyPhongViewModel
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 100, // Vượt quá sức chứa 40
                PhanMemIds = new List<int>()
            };

            // Act
            var result = await _service.TaoDangKyAsync(model, maNhanVien: 1, vaiTroId: 3);

            // Assert
            result.Success.Should().BeFalse();
            result.Errors.Should().Contain(e => e.Contains("sức chứa"));
        }

        [Fact]
        public async Task TaoDangKy_ByGiaoVien_WithInsufficientAdvanceTime_ShouldReturnError()
        {
            // Arrange
            var model = new DangKyPhongViewModel
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(1), // Chỉ trước 1 ngày, yêu cầu 3 ngày
                NgayKetThuc = DateTime.Today.AddDays(1),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30,
                PhanMemIds = new List<int>()
            };

            // Act
            var result = await _service.TaoDangKyAsync(model, maNhanVien: 1, vaiTroId: 5); // Giáo viên

            // Assert
            result.Success.Should().BeFalse();
            result.Errors.Should().Contain(e => e.Contains("ít nhất"));
        }

        [Fact]
        public async Task DuyetPDT_WithValidRequest_ShouldChangeStatusToChoDuyetTTDT()
        {
            // Arrange - Tạo đăng ký trước
            var dangKy = new DangKyPhong
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30,
                TrangThai = TrangThaiDangKy.ChoDuyetPDT
            };
            _context.DangKyPhongs.Add(dangKy);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.DuyetPDTAsync(dangKy.DangKyPhongId, maNhanVien: 2, ghiChu: "Đã duyệt");

            // Assert
            result.Success.Should().BeTrue();
            var updatedDangKy = await _context.DangKyPhongs.FindAsync(dangKy.DangKyPhongId);
            updatedDangKy!.TrangThai.Should().Be(TrangThaiDangKy.ChoDuyetTTDT);
        }

        [Fact]
        public async Task TuChoiPDT_WithValidRequest_ShouldChangeStatusToPDTTuChoi()
        {
            // Arrange
            var dangKy = new DangKyPhong
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30,
                TrangThai = TrangThaiDangKy.ChoDuyetPDT
            };
            _context.DangKyPhongs.Add(dangKy);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.TuChoiPDTAsync(dangKy.DangKyPhongId, maNhanVien: 2, lyDo: "Không đủ điều kiện");

            // Assert
            result.Success.Should().BeTrue();
            var updatedDangKy = await _context.DangKyPhongs.FindAsync(dangKy.DangKyPhongId);
            updatedDangKy!.TrangThai.Should().Be(TrangThaiDangKy.PDTTuChoi);
            updatedDangKy.LyDoTuChoiPDT.Should().Be("Không đủ điều kiện");
        }

        [Fact]
        public async Task KiemTraXungDot_WithConflict_ShouldReturnConflictingRegistration()
        {
            // Arrange - Tạo đăng ký đã được duyệt
            var existingDangKy = new DangKyPhong
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30,
                TrangThai = TrangThaiDangKy.TTDTDongY
            };
            _context.DangKyPhongs.Add(existingDangKy);
            await _context.SaveChangesAsync();

            // Act - Kiểm tra xung đột với cùng thời gian
            var conflict = await _service.KiemTraXungDotAsync(
                phongMayId: 1,
                ngayBatDau: DateTime.Today.AddDays(5),
                ngayKetThuc: DateTime.Today.AddDays(5),
                gioBatDau: new TimeSpan(9, 0, 0), // Trùng giờ
                gioKetThuc: new TimeSpan(11, 0, 0));

            // Assert
            conflict.Should().NotBeNull();
        }

        [Fact]
        public async Task KiemTraXungDot_WithNoConflict_ShouldReturnNull()
        {
            // Arrange
            var existingDangKy = new DangKyPhong
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30,
                TrangThai = TrangThaiDangKy.TTDTDongY
            };
            _context.DangKyPhongs.Add(existingDangKy);
            await _context.SaveChangesAsync();

            // Act - Kiểm tra với thời gian khác
            var conflict = await _service.KiemTraXungDotAsync(
                phongMayId: 1,
                ngayBatDau: DateTime.Today.AddDays(5),
                ngayKetThuc: DateTime.Today.AddDays(5),
                gioBatDau: new TimeSpan(14, 0, 0), // Giờ khác
                gioKetThuc: new TimeSpan(16, 0, 0));

            // Assert
            conflict.Should().BeNull();
        }

        [Fact]
        public async Task HuyDangKy_ShouldChangeStatusToDaHuy()
        {
            // Arrange
            var dangKy = new DangKyPhong
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30,
                TrangThai = TrangThaiDangKy.ChoDuyetPDT
            };
            _context.DangKyPhongs.Add(dangKy);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.HuyDangKyAsync(dangKy.DangKyPhongId, maNhanVien: 1);

            // Assert
            result.Success.Should().BeTrue();
            var updatedDangKy = await _context.DangKyPhongs.FindAsync(dangKy.DangKyPhongId);
            updatedDangKy!.TrangThai.Should().Be(TrangThaiDangKy.DaHuy);
        }

        public void Dispose()
        {
            _context.Database.EnsureDeleted();
            _context.Dispose();
        }
    }
}
