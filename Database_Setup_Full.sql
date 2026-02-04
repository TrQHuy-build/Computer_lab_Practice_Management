-- ============================================
-- DATABASE SETUP SCRIPT - Quản lý Thực hành Máy tính
-- Chạy script này để tạo database trên máy mới
-- ============================================

-- Bước 1: Tạo Database (nếu chưa có)
USE master;
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'QL_PHONG_TH')
BEGIN
    CREATE DATABASE QL_PHONG_TH;
END
GO

USE QL_PHONG_TH;
GO

-- ============================================
-- Bước 2: Tạo các bảng
-- ============================================

-- Bảng TaiKhoans (Tài khoản người dùng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TaiKhoans')
BEGIN
    CREATE TABLE TaiKhoans (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        TenDangNhap NVARCHAR(50) NOT NULL UNIQUE,
        MatKhauHash NVARCHAR(100) NOT NULL,
        HoTen NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL,
        SoDienThoai NVARCHAR(20) NULL,
        VaiTro INT NOT NULL, -- 1: Admin, 2: PDT, 3: TTDTTH, 4: GiangVien
        LoaiGiangVien INT NULL, -- 1: CoHuu, 2: ThinhGiang
        TrangThaiHoatDong BIT NOT NULL DEFAULT 1,
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE(),
        LanDangNhapCuoi DATETIME2 NULL
    );
END
GO

-- Bảng HocKys (Học kỳ)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'HocKys')
BEGIN
    CREATE TABLE HocKys (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        TenHocKy NVARCHAR(100) NOT NULL,
        NamHoc NVARCHAR(20) NOT NULL,
        SoHocKy INT NOT NULL,
        TienHocKy DATETIME2 NOT NULL,
        BatDauHocKy DATETIME2 NOT NULL,
        KetThucHocKy DATETIME2 NOT NULL,
        KetThucNhapHopDong DATETIME2 NOT NULL,
        KetThucDangKyLich DATETIME2 NOT NULL,
        KetThucSapXepLich DATETIME2 NOT NULL,
        KetThucThongBao DATETIME2 NOT NULL,
        TrangThai INT NOT NULL DEFAULT 0, -- 0: Không hoạt động, 1: Hoạt động
        IsActive BIT NOT NULL DEFAULT 0,
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE(),
        NguoiTaoId INT NULL REFERENCES TaiKhoans(Id)
    );
END
GO

-- Bảng MonHocs (Môn học)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MonHocs')
BEGIN
    CREATE TABLE MonHocs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        MaMonHoc NVARCHAR(20) NOT NULL UNIQUE,
        TenMonHoc NVARCHAR(200) NOT NULL,
        SoTinChi INT NOT NULL DEFAULT 3,
        SoBuoiThucHanh INT NOT NULL DEFAULT 5,
        MoTa NVARCHAR(500) NULL,
        TrangThaiHoatDong BIT NOT NULL DEFAULT 1,
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE()
    );
END
GO

-- Bảng PhongThucHanhs (Phòng thực hành)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'PhongThucHanhs')
BEGIN
    CREATE TABLE PhongThucHanhs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        MaPhong NVARCHAR(20) NOT NULL UNIQUE,
        TenPhong NVARCHAR(100) NOT NULL,
        ViTri NVARCHAR(200) NULL,
        SucChua INT NOT NULL DEFAULT 40,
        SoMayHoatDong INT NOT NULL DEFAULT 40,
        MoTa NVARCHAR(500) NULL,
        TrangThaiHoatDong BIT NOT NULL DEFAULT 1,
        NgayKiemKeGanNhat DATETIME2 NULL,
        NguoiKiemKeId INT NULL REFERENCES TaiKhoans(Id),
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE(),
        NgayCapNhat DATETIME2 NOT NULL DEFAULT GETDATE()
    );
END
GO

-- Bảng PhanMems (Phần mềm)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'PhanMems')
BEGIN
    CREATE TABLE PhanMems (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        TenPhanMem NVARCHAR(100) NOT NULL,
        PhienBan NVARCHAR(50) NULL,
        MoTa NVARCHAR(500) NULL,
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE()
    );
END
GO

-- Bảng PhongThucHanhPhanMems (Liên kết phòng - phần mềm)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'PhongThucHanhPhanMems')
BEGIN
    CREATE TABLE PhongThucHanhPhanMems (
        PhongThucHanhId INT NOT NULL REFERENCES PhongThucHanhs(Id),
        PhanMemId INT NOT NULL REFERENCES PhanMems(Id),
        PRIMARY KEY (PhongThucHanhId, PhanMemId)
    );
END
GO

-- Bảng HopDongs (Hợp đồng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'HopDongs')
BEGIN
    CREATE TABLE HopDongs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        MaHopDong NVARCHAR(50) NOT NULL UNIQUE,
        GiangVienId INT NOT NULL REFERENCES TaiKhoans(Id),
        HocKyId INT NOT NULL REFERENCES HocKys(Id),
        NgayBatDau DATETIME2 NOT NULL,
        NgayKetThuc DATETIME2 NOT NULL,
        TrangThai INT NOT NULL DEFAULT 0, -- 0: Chờ duyệt, 1: Đã duyệt, 2: Từ chối
        GhiChu NVARCHAR(500) NULL,
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE(),
        NguoiTaoId INT NULL REFERENCES TaiKhoans(Id),
        NgayDuyet DATETIME2 NULL,
        NguoiDuyetId INT NULL REFERENCES TaiKhoans(Id)
    );
END
GO

-- Bảng HopDongMonHocs (Liên kết hợp đồng - môn học)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'HopDongMonHocs')
BEGIN
    CREATE TABLE HopDongMonHocs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        HopDongId INT NOT NULL REFERENCES HopDongs(Id) ON DELETE CASCADE,
        MonHocId INT NOT NULL REFERENCES MonHocs(Id),
        SoBuoi INT NOT NULL DEFAULT 5
    );
END
GO

-- Bảng HocPhans (Học phần)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'HocPhans')
BEGIN
    CREATE TABLE HocPhans (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        MaHocPhan NVARCHAR(50) NOT NULL,
        TenHocPhan NVARCHAR(200) NOT NULL,
        MonHocId INT NOT NULL REFERENCES MonHocs(Id),
        HocKyId INT NOT NULL REFERENCES HocKys(Id),
        GiangVienId INT NULL REFERENCES TaiKhoans(Id),
        Nhom INT NOT NULL DEFAULT 1,
        SiSo INT NOT NULL DEFAULT 40,
        TrangThaiHoatDong BIT NOT NULL DEFAULT 1,
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE()
    );
END
GO

-- Bảng DangKyLichThinhGiangs (Đăng ký lịch thỉnh giảng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DangKyLichThinhGiangs')
BEGIN
    CREATE TABLE DangKyLichThinhGiangs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        GiangVienId INT NOT NULL REFERENCES TaiKhoans(Id),
        HocKyId INT NOT NULL REFERENCES HocKys(Id),
        HopDongId INT NULL REFERENCES HopDongs(Id),
        ThuTrongTuan INT NOT NULL, -- 2-7 (Thứ 2 - Thứ 7)
        CaHoc INT NOT NULL, -- 1: Sáng, 2: Chiều
        TuanBatDau INT NOT NULL DEFAULT 1,
        SoTuanLienTiep INT NOT NULL DEFAULT 15,
        GhiChu NVARCHAR(500) NULL,
        TrangThai INT NOT NULL DEFAULT 0, -- 0: Chờ duyệt, 1: Đã duyệt, 2: Từ chối
        LyDoTuChoi NVARCHAR(500) NULL,
        NgayDangKy DATETIME2 NOT NULL DEFAULT GETDATE(),
        NgayDuyet DATETIME2 NULL,
        NguoiDuyetId INT NULL REFERENCES TaiKhoans(Id)
    );
END
GO

-- Bảng LichThucHanhs (Lịch thực hành)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LichThucHanhs')
BEGIN
    CREATE TABLE LichThucHanhs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        HocPhanId INT NOT NULL REFERENCES HocPhans(Id),
        PhongThucHanhId INT NOT NULL REFERENCES PhongThucHanhs(Id),
        HocKyId INT NOT NULL REFERENCES HocKys(Id),
        NgayThucHanh DATETIME2 NOT NULL,
        ThuTrongTuan INT NOT NULL,
        CaHoc INT NOT NULL,
        TuanHoc INT NOT NULL,
        BuoiThu INT NOT NULL DEFAULT 1,
        GhiChu NVARCHAR(500) NULL,
        TrangThai INT NOT NULL DEFAULT 0, -- 0: Chờ duyệt, 1: Đã duyệt TTDT, 2: Đã thông báo
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE(),
        NguoiTaoId INT NULL REFERENCES TaiKhoans(Id),
        NgayDuyetTTDT DATETIME2 NULL,
        NguoiDuyetTTDTId INT NULL REFERENCES TaiKhoans(Id)
    );
END
GO

-- Bảng ThongBaos (Thông báo)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ThongBaos')
BEGIN
    CREATE TABLE ThongBaos (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        TieuDe NVARCHAR(200) NOT NULL,
        NoiDung NVARCHAR(MAX) NOT NULL,
        LoaiThongBao INT NOT NULL DEFAULT 0,
        NguoiGuiId INT NOT NULL REFERENCES TaiKhoans(Id),
        NguoiNhanId INT NOT NULL REFERENCES TaiKhoans(Id),
        DaDoc BIT NOT NULL DEFAULT 0,
        NgayTao DATETIME2 NOT NULL DEFAULT GETDATE(),
        NgayDoc DATETIME2 NULL
    );
END
GO

-- Bảng YeuCauDoiPhongs (Yêu cầu đổi phòng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'YeuCauDoiPhongs')
BEGIN
    CREATE TABLE YeuCauDoiPhongs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        LichThucHanhId INT NOT NULL REFERENCES LichThucHanhs(Id),
        PhongMoiId INT NOT NULL REFERENCES PhongThucHanhs(Id),
        LyDo NVARCHAR(500) NOT NULL,
        TrangThai INT NOT NULL DEFAULT 0,
        NguoiYeuCauId INT NOT NULL REFERENCES TaiKhoans(Id),
        NgayYeuCau DATETIME2 NOT NULL DEFAULT GETDATE(),
        NgayXuLy DATETIME2 NULL,
        NguoiXuLyId INT NULL REFERENCES TaiKhoans(Id),
        GhiChu NVARCHAR(500) NULL
    );
END
GO

-- Bảng YeuCauMuonBus (Yêu cầu mượn bù)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'YeuCauMuonBus')
BEGIN
    CREATE TABLE YeuCauMuonBus (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        HocPhanId INT NOT NULL REFERENCES HocPhans(Id),
        PhongThucHanhId INT NOT NULL REFERENCES PhongThucHanhs(Id),
        NgayMuon DATETIME2 NOT NULL,
        CaHoc INT NOT NULL,
        LyDo NVARCHAR(500) NOT NULL,
        TrangThai INT NOT NULL DEFAULT 0,
        NguoiYeuCauId INT NOT NULL REFERENCES TaiKhoans(Id),
        NgayYeuCau DATETIME2 NOT NULL DEFAULT GETDATE(),
        NgayXuLy DATETIME2 NULL,
        NguoiXuLyId INT NULL REFERENCES TaiKhoans(Id),
        GhiChu NVARCHAR(500) NULL
    );
END
GO

-- Bảng EF Migrations History
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = '__EFMigrationsHistory')
BEGIN
    CREATE TABLE __EFMigrationsHistory (
        MigrationId NVARCHAR(150) NOT NULL PRIMARY KEY,
        ProductVersion NVARCHAR(32) NOT NULL
    );
END
GO

-- ============================================
-- Bước 3: Chèn dữ liệu mẫu
-- ============================================

-- Tài khoản mẫu (Mật khẩu: 123456)
-- Hash password: $2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u
SET IDENTITY_INSERT TaiKhoans ON;

IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 1)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, TrangThaiHoatDong, NgayTao)
VALUES (1, 'admin', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Administrator', 'admin@utc2.edu.vn', 1, 1, '2026-01-01');

IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 2)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, TrangThaiHoatDong, NgayTao)
VALUES (2, 'pdt', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Phòng Đào Tạo', 'pdt@utc2.edu.vn', 2, 1, '2026-01-01');

IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 3)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, TrangThaiHoatDong, NgayTao)
VALUES (3, 'ttdtth', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Trung tâm Đào tạo Thực hành', 'ttdtth@utc2.edu.vn', 3, 1, '2026-01-01');

-- Giảng viên thỉnh giảng
IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 4)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, LoaiGiangVien, TrangThaiHoatDong, NgayTao)
VALUES (4, 'tranphongnha', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Trần Phong Nha', 'tranphongnha@utc2.edu.vn', 4, 2, 1, '2026-01-01');

IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 5)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, LoaiGiangVien, TrangThaiHoatDong, NgayTao)
VALUES (5, 'tranthidung', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Trần Thị Dung', 'tranthidung@utc2.edu.vn', 4, 2, 1, '2026-01-01');

IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 6)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, LoaiGiangVien, TrangThaiHoatDong, NgayTao)
VALUES (6, 'phamthimien', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Phạm Thị Miên', 'phamthimien@utc2.edu.vn', 4, 2, 1, '2026-01-01');

IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 7)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, LoaiGiangVien, TrangThaiHoatDong, NgayTao)
VALUES (7, 'nguyenvuthai', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Nguyễn Vũ Thái', 'nguyenvuthai@utc2.edu.vn', 4, 2, 1, '2026-01-01');

-- Giảng viên cơ hữu
IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 12)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, LoaiGiangVien, TrangThaiHoatDong, NgayTao)
VALUES (12, 'nguyendinhhien', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Nguyễn Đình Hiền', 'nguyendinhhien@utc2.edu.vn', 4, 1, 1, '2026-01-01');

IF NOT EXISTS (SELECT * FROM TaiKhoans WHERE Id = 13)
INSERT INTO TaiKhoans (Id, TenDangNhap, MatKhauHash, HoTen, Email, VaiTro, LoaiGiangVien, TrangThaiHoatDong, NgayTao)
VALUES (13, 'luutoandinh', '$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u', N'Lưu Toàn Định', 'luutoandinh@utc2.edu.vn', 4, 1, 1, '2026-01-01');

SET IDENTITY_INSERT TaiKhoans OFF;
GO

-- Môn học mẫu
IF NOT EXISTS (SELECT * FROM MonHocs WHERE MaMonHoc = 'IT0.004.2')
INSERT INTO MonHocs (MaMonHoc, TenMonHoc, SoTinChi, SoBuoiThucHanh, MoTa, TrangThaiHoatDong)
VALUES 
('IT0.004.2', N'Tin học đại cương', 2, 5, N'Kiến thức tin học cơ bản', 1),
('IT1.001.3', N'Nhập môn ngành CNTT', 3, 5, N'Giới thiệu ngành CNTT', 1),
('IT1.103.3', N'Kỹ thuật lập trình', 3, 5, N'Kỹ thuật lập trình cơ bản', 1),
('IT1.106.3', N'Thiết kế Web', 3, 5, N'Thiết kế giao diện Web', 1),
('IT1.108.3', N'Lập trình hướng đối tượng', 3, 5, N'OOP Programming', 1),
('IT1.109.3', N'Cấu trúc dữ liệu và giải thuật', 3, 5, N'Data Structures & Algorithms', 1),
('IT1.110.3', N'Cơ sở dữ liệu', 3, 10, N'Database fundamentals', 1),
('IT1.112.3', N'Nguyên lý hệ điều hành', 3, 10, N'Operating System Principles', 1),
('IT1.113.3', N'Công nghệ Java', 3, 5, N'Java Technology', 1),
('IT1.115.3', N'Mạng máy tính', 3, 10, N'Computer Networks', 1),
('IT1.217.3', N'Lập trình Web', 3, 5, N'Web Programming', 1);
GO

-- Phòng thực hành mẫu
IF NOT EXISTS (SELECT * FROM PhongThucHanhs WHERE MaPhong = '202.E7')
INSERT INTO PhongThucHanhs (MaPhong, TenPhong, ViTri, SucChua, SoMayHoatDong, MoTa, TrangThaiHoatDong)
VALUES 
('202.E7', N'Phòng máy 202.E7', N'Tầng 2, Nhà E7', 40, 38, N'Phòng thực hành tin học cơ bản', 1),
('203.E7', N'Phòng máy 203.E7', N'Tầng 2, Nhà E7', 40, 40, N'Phòng tiêu chuẩn tổ chức thi', 1),
('204.E7', N'Phòng máy 204.E7', N'Tầng 2, Nhà E7', 40, 39, N'Phòng tiêu chuẩn tổ chức thi', 1),
('205.E7', N'Phòng máy 205.E7', N'Tầng 2, Nhà E7', 45, 43, N'Phòng máy lớn cho lớp chuyên ngành', 1),
('206.E7', N'Phòng máy 206.E7', N'Tầng 2, Nhà E7', 38, 35, N'Phòng thực hành chuyên sâu', 1);
GO

-- Học kỳ mẫu (HK2 2025-2026 đang hoạt động)
SET IDENTITY_INSERT HocKys ON;

IF NOT EXISTS (SELECT * FROM HocKys WHERE Id = 3)
INSERT INTO HocKys (Id, TenHocKy, NamHoc, SoHocKy, TienHocKy, BatDauHocKy, KetThucHocKy, 
    KetThucNhapHopDong, KetThucDangKyLich, KetThucSapXepLich, KetThucThongBao, TrangThai, NgayTao, NguoiTaoId)
VALUES (3, N'HK2 2025-2026', '2025-2026', 2, '2026-02-04', '2026-03-04', '2026-06-24',
    '2026-02-11', '2026-02-18', '2026-02-25', '2026-03-04', 1, GETDATE(), 1);

SET IDENTITY_INSERT HocKys OFF;
GO

-- EF Migrations History
IF NOT EXISTS (SELECT * FROM __EFMigrationsHistory WHERE MigrationId = '20260204092957_InitWithSeedData')
INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion) VALUES ('20260204092957_InitWithSeedData', '8.0.0');

IF NOT EXISTS (SELECT * FROM __EFMigrationsHistory WHERE MigrationId = '20260204120517_AddHopDongMonHocTable')
INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion) VALUES ('20260204120517_AddHopDongMonHocTable', '8.0.0');
GO

-- ============================================
-- Bước 4: Tạo Indexes
-- ============================================
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_HocPhans_HocKyId')
    CREATE INDEX IX_HocPhans_HocKyId ON HocPhans(HocKyId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_HocPhans_GiangVienId')
    CREATE INDEX IX_HocPhans_GiangVienId ON HocPhans(GiangVienId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LichThucHanhs_HocKyId')
    CREATE INDEX IX_LichThucHanhs_HocKyId ON LichThucHanhs(HocKyId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LichThucHanhs_HocPhanId')
    CREATE INDEX IX_LichThucHanhs_HocPhanId ON LichThucHanhs(HocPhanId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LichThucHanhs_PhongThucHanhId')
    CREATE INDEX IX_LichThucHanhs_PhongThucHanhId ON LichThucHanhs(PhongThucHanhId);
GO

PRINT N'============================================';
PRINT N'Database QL_PHONG_TH đã được tạo thành công!';
PRINT N'============================================';
PRINT N'';
PRINT N'Tài khoản đăng nhập mẫu:';
PRINT N'- Admin: admin / 123456';
PRINT N'- Phòng Đào Tạo: pdt / 123456';
PRINT N'- Trung tâm DTTH: ttdtth / 123456';
PRINT N'- Giảng viên: tranthidung / 123456';
PRINT N'============================================';
GO
