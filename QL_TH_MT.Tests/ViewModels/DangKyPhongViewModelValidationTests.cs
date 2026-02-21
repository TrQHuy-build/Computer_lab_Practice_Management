using QL_TH_MT.ViewModels;
using FluentAssertions;
using System.ComponentModel.DataAnnotations;
using Xunit;

namespace QL_TH_MT.Tests.ViewModels
{
    /// <summary>
    /// Unit Tests cho DangKyPhongViewModelV2 Validation (với IValidatableObject)
    /// </summary>
    public class DangKyPhongViewModelValidationTests
    {
        private List<ValidationResult> ValidateModel(object model)
        {
            var validationResults = new List<ValidationResult>();
            var context = new ValidationContext(model);
            Validator.TryValidateObject(model, context, validationResults, true);
            
            // Gọi IValidatableObject.Validate nếu có
            if (model is IValidatableObject validatable)
            {
                var customResults = validatable.Validate(context);
                validationResults.AddRange(customResults);
            }
            
            return validationResults;
        }

        [Fact]
        public void Validate_WithValidData_ShouldPass()
        {
            // Arrange
            var model = new DangKyPhongViewModelV2
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30
            };

            // Act
            var results = ValidateModel(model);

            // Assert
            results.Should().BeEmpty();
        }

        [Fact]
        public void Validate_WithEndDateBeforeStartDate_ShouldFail()
        {
            // Arrange
            var model = new DangKyPhongViewModelV2
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(10),
                NgayKetThuc = DateTime.Today.AddDays(5), // Trước ngày bắt đầu
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30
            };

            // Act
            var results = ValidateModel(model);

            // Assert
            results.Should().Contain(r => r.MemberNames.Contains(nameof(DangKyPhongViewModelV2.NgayKetThuc)));
        }

        [Fact]
        public void Validate_WithEndTimeBeforeStartTime_ShouldFail()
        {
            // Arrange
            var model = new DangKyPhongViewModelV2
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(14, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0), // Trước giờ bắt đầu
                SoLuongSinhVien = 30
            };

            // Act
            var results = ValidateModel(model);

            // Assert
            results.Should().Contain(r => r.MemberNames.Contains(nameof(DangKyPhongViewModelV2.GioKetThuc)));
        }

        [Theory]
        [InlineData(0)]
        [InlineData(-1)]
        [InlineData(201)]
        public void Validate_WithInvalidStudentCount_ShouldFail(int soLuongSinhVien)
        {
            // Arrange
            var model = new DangKyPhongViewModelV2
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = soLuongSinhVien
            };

            // Act
            var results = ValidateModel(model);

            // Assert
            results.Should().Contain(r => r.MemberNames.Contains(nameof(DangKyPhongViewModelV2.SoLuongSinhVien)));
        }

        [Fact]
        public void Validate_WithStartDateInPast_ShouldFail()
        {
            // Arrange
            var model = new DangKyPhongViewModelV2
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(-1), // Ngày quá khứ
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(10, 0, 0),
                SoLuongSinhVien = 30
            };

            // Act
            var results = ValidateModel(model);

            // Assert
            results.Should().Contain(r => r.MemberNames.Contains(nameof(DangKyPhongViewModelV2.NgayBatDau)));
        }

        [Theory]
        [InlineData(6, 0, 8, 0)]  // Giờ bắt đầu trước 7:00
        [InlineData(20, 0, 22, 0)] // Giờ kết thúc sau 21:00
        public void Validate_WithTimeOutsideAllowedRange_ShouldFail(int startHour, int startMin, int endHour, int endMin)
        {
            // Arrange
            var model = new DangKyPhongViewModelV2
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(startHour, startMin, 0),
                GioKetThuc = new TimeSpan(endHour, endMin, 0),
                SoLuongSinhVien = 30
            };

            // Act
            var results = ValidateModel(model);

            // Assert
            results.Should().NotBeEmpty();
        }

        [Fact]
        public void Validate_WithDurationLessThanOneHour_ShouldFail()
        {
            // Arrange
            var model = new DangKyPhongViewModelV2
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(8, 30, 0), // Chỉ 30 phút
                SoLuongSinhVien = 30
            };

            // Act
            var results = ValidateModel(model);

            // Assert
            results.Should().Contain(r => r.MemberNames.Contains(nameof(DangKyPhongViewModelV2.GioKetThuc)));
        }

        [Fact]
        public void Validate_WithDurationMoreThanFourHours_ShouldFail()
        {
            // Arrange
            var model = new DangKyPhongViewModelV2
            {
                HocPhanId = 1,
                PhongMayId = 1,
                GiaoVienId = 1,
                NgayBatDau = DateTime.Today.AddDays(5),
                NgayKetThuc = DateTime.Today.AddDays(5),
                GioBatDau = new TimeSpan(8, 0, 0),
                GioKetThuc = new TimeSpan(13, 0, 0), // 5 tiếng
                SoLuongSinhVien = 30
            };

            // Act
            var results = ValidateModel(model);

            // Assert
            results.Should().Contain(r => r.MemberNames.Contains(nameof(DangKyPhongViewModelV2.GioKetThuc)));
        }
    }
}
