IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [HocPhans] (
    [HocPhanId] int NOT NULL IDENTITY,
    [MaHocPhan] nvarchar(20) NOT NULL,
    [TenHocPhan] nvarchar(200) NOT NULL,
    [SoTinChi] int NOT NULL,
    [MoTa] nvarchar(500) NULL,
    CONSTRAINT [PK_HocPhans] PRIMARY KEY ([HocPhanId])
);
GO

CREATE TABLE [PhanMems] (
    [PhanMemId] int NOT NULL IDENTITY,
    [TenPhanMem] nvarchar(100) NOT NULL,
    [PhienBan] nvarchar(50) NULL,
    [NhaSanXuat] nvarchar(100) NULL,
    [MoTa] nvarchar(500) NULL,
    [TrangThai] bit NOT NULL,
    CONSTRAINT [PK_PhanMems] PRIMARY KEY ([PhanMemId])
);
GO

CREATE TABLE [PhongBans] (
    [PhongBanId] int NOT NULL IDENTITY,
    [TenPhongBan] nvarchar(100) NOT NULL,
    [MoTa] nvarchar(200) NULL,
    CONSTRAINT [PK_PhongBans] PRIMARY KEY ([PhongBanId])
);
GO

CREATE TABLE [PhongMays] (
    [PhongMayId] int NOT NULL IDENTITY,
    [MaPhong] nvarchar(50) NOT NULL,
    [TenPhong] nvarchar(100) NOT NULL,
    [SoLuongMay] int NOT NULL,
    [SoMayHong] int NOT NULL,
    [ViTri] nvarchar(200) NULL,
    [TrangThai] bit NOT NULL,
    [GhiChu] nvarchar(500) NULL,
    CONSTRAINT [PK_PhongMays] PRIMARY KEY ([PhongMayId])
);
GO

CREATE TABLE [Quyens] (
    [QuyenId] int NOT NULL IDENTITY,
    [TenQuyen] nvarchar(100) NOT NULL,
    [MaQuyen] nvarchar(50) NULL,
    [MoTa] nvarchar(200) NULL,
    CONSTRAINT [PK_Quyens] PRIMARY KEY ([QuyenId])
);
GO

CREATE TABLE [VaiTros] (
    [VaiTroId] int NOT NULL IDENTITY,
    [TenVaiTro] nvarchar(50) NOT NULL,
    [MoTa] nvarchar(200) NULL,
    CONSTRAINT [PK_VaiTros] PRIMARY KEY ([VaiTroId])
);
GO

CREATE TABLE [NhanViens] (
    [MaNhanVien] int NOT NULL IDENTITY,
    [HoTen] nvarchar(100) NOT NULL,
    [SoDienThoai] nvarchar(50) NULL,
    [Email] nvarchar(100) NULL,
    [PhongBanId] int NULL,
    CONSTRAINT [PK_NhanViens] PRIMARY KEY ([MaNhanVien]),
    CONSTRAINT [FK_NhanViens_PhongBans_PhongBanId] FOREIGN KEY ([PhongBanId]) REFERENCES [PhongBans] ([PhongBanId])
);
GO

CREATE TABLE [PhongMayPhanMems] (
    [PhongMayPhanMemId] int NOT NULL IDENTITY,
    [PhongMayId] int NOT NULL,
    [PhanMemId] int NOT NULL,
    [NgayCaiDat] datetime2 NOT NULL,
    [GhiChu] nvarchar(500) NULL,
    CONSTRAINT [PK_PhongMayPhanMems] PRIMARY KEY ([PhongMayPhanMemId]),
    CONSTRAINT [FK_PhongMayPhanMems_PhanMems_PhanMemId] FOREIGN KEY ([PhanMemId]) REFERENCES [PhanMems] ([PhanMemId]) ON DELETE CASCADE,
    CONSTRAINT [FK_PhongMayPhanMems_PhongMays_PhongMayId] FOREIGN KEY ([PhongMayId]) REFERENCES [PhongMays] ([PhongMayId]) ON DELETE CASCADE
);
GO

CREATE TABLE [VaiTroQuyens] (
    [VaiTroQuyenId] int NOT NULL IDENTITY,
    [VaiTroId] int NOT NULL,
    [QuyenId] int NOT NULL,
    CONSTRAINT [PK_VaiTroQuyens] PRIMARY KEY ([VaiTroQuyenId]),
    CONSTRAINT [FK_VaiTroQuyens_Quyens_QuyenId] FOREIGN KEY ([QuyenId]) REFERENCES [Quyens] ([QuyenId]) ON DELETE CASCADE,
    CONSTRAINT [FK_VaiTroQuyens_VaiTros_VaiTroId] FOREIGN KEY ([VaiTroId]) REFERENCES [VaiTros] ([VaiTroId]) ON DELETE CASCADE
);
GO

CREATE TABLE [BaoTriPhongs] (
    [BaoTriId] int NOT NULL IDENTITY,
    [PhongMayId] int NOT NULL,
    [NoiDung] nvarchar(500) NOT NULL,
    [SoMayHong] int NOT NULL,
    [ChiTietThietBiHong] nvarchar(1000) NULL,
    [TrangThai] int NOT NULL,
    [NgayBaoCao] datetime2 NOT NULL,
    [NguoiBaoCaoId] int NOT NULL,
    [NgayXuLy] datetime2 NULL,
    [NguoiXuLyId] int NULL,
    [KetQuaXuLy] nvarchar(1000) NULL,
    CONSTRAINT [PK_BaoTriPhongs] PRIMARY KEY ([BaoTriId]),
    CONSTRAINT [FK_BaoTriPhongs_NhanViens_NguoiBaoCaoId] FOREIGN KEY ([NguoiBaoCaoId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_BaoTriPhongs_NhanViens_NguoiXuLyId] FOREIGN KEY ([NguoiXuLyId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_BaoTriPhongs_PhongMays_PhongMayId] FOREIGN KEY ([PhongMayId]) REFERENCES [PhongMays] ([PhongMayId]) ON DELETE CASCADE
);
GO

CREATE TABLE [DangKyPhongs] (
    [DangKyPhongId] int NOT NULL IDENTITY,
    [HocPhanId] int NOT NULL,
    [PhongMayId] int NOT NULL,
    [GiaoVienId] int NOT NULL,
    [NgayBatDau] datetime2 NOT NULL,
    [NgayKetThuc] datetime2 NOT NULL,
    [GioBatDau] time NOT NULL,
    [GioKetThuc] time NOT NULL,
    [SoLuongSinhVien] int NOT NULL,
    [GhiChu] nvarchar(1000) NULL,
    [TrangThai] int NOT NULL,
    [MucDoUuTien] int NOT NULL,
    [CanVanBanXacNhan] bit NOT NULL,
    [DaDongDau] bit NOT NULL,
    [NgayDangKy] datetime2 NOT NULL,
    [NguoiDuyetPDTId] int NULL,
    [NgayDuyetPDT] datetime2 NULL,
    [LyDoTuChoiPDT] nvarchar(500) NULL,
    [NguoiDuyetTTDTId] int NULL,
    [NgayDuyetTTDT] datetime2 NULL,
    [LyDoTuChoiTTDT] nvarchar(500) NULL,
    [LaDangKyDauNam] bit NOT NULL,
    [TuDongDuyet] bit NOT NULL,
    [SoVanBan] nvarchar(200) NULL,
    CONSTRAINT [PK_DangKyPhongs] PRIMARY KEY ([DangKyPhongId]),
    CONSTRAINT [FK_DangKyPhongs_HocPhans_HocPhanId] FOREIGN KEY ([HocPhanId]) REFERENCES [HocPhans] ([HocPhanId]) ON DELETE CASCADE,
    CONSTRAINT [FK_DangKyPhongs_NhanViens_GiaoVienId] FOREIGN KEY ([GiaoVienId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_DangKyPhongs_NhanViens_NguoiDuyetPDTId] FOREIGN KEY ([NguoiDuyetPDTId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_DangKyPhongs_NhanViens_NguoiDuyetTTDTId] FOREIGN KEY ([NguoiDuyetTTDTId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_DangKyPhongs_PhongMays_PhongMayId] FOREIGN KEY ([PhongMayId]) REFERENCES [PhongMays] ([PhongMayId]) ON DELETE CASCADE
);
GO

CREATE TABLE [TaiKhoans] (
    [TaiKhoanId] int NOT NULL IDENTITY,
    [TenDangNhap] nvarchar(50) NOT NULL,
    [MatKhau] nvarchar(255) NOT NULL,
    [MaNhanVien] int NOT NULL,
    [NhanVienMaNhanVien] int NULL,
    [VaiTroId] int NOT NULL,
    [IsActive] bit NOT NULL,
    [NgayTao] datetime2 NOT NULL,
    CONSTRAINT [PK_TaiKhoans] PRIMARY KEY ([TaiKhoanId]),
    CONSTRAINT [FK_TaiKhoans_NhanViens_NhanVienMaNhanVien] FOREIGN KEY ([NhanVienMaNhanVien]) REFERENCES [NhanViens] ([MaNhanVien]),
    CONSTRAINT [FK_TaiKhoans_VaiTros_VaiTroId] FOREIGN KEY ([VaiTroId]) REFERENCES [VaiTros] ([VaiTroId]) ON DELETE CASCADE
);
GO

CREATE TABLE [ThongBaos] (
    [ThongBaoId] int NOT NULL IDENTITY,
    [NguoiNhanId] int NOT NULL,
    [TieuDe] nvarchar(200) NOT NULL,
    [NoiDung] nvarchar(1000) NOT NULL,
    [ThoiGian] datetime2 NOT NULL,
    [DaDoc] bit NOT NULL,
    [DuongDan] nvarchar(200) NULL,
    [DangKyPhongId] int NULL,
    CONSTRAINT [PK_ThongBaos] PRIMARY KEY ([ThongBaoId]),
    CONSTRAINT [FK_ThongBaos_NhanViens_NguoiNhanId] FOREIGN KEY ([NguoiNhanId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE CASCADE
);
GO

CREATE TABLE [YeuCauCaiDatPhanMems] (
    [YeuCauId] int NOT NULL IDENTITY,
    [PhanMemId] int NULL,
    [TenPhanMemMoi] nvarchar(200) NULL,
    [PhienBan] nvarchar(50) NULL,
    [MoTa] nvarchar(1000) NULL,
    [LinkTaiVe] nvarchar(500) NULL,
    [HuongDanCaiDat] nvarchar(1000) NULL,
    [NguoiYeuCauId] int NOT NULL,
    [NgayYeuCau] datetime2 NOT NULL,
    [TrangThai] int NOT NULL,
    [NguoiDuyetId] int NULL,
    [NgayDuyet] datetime2 NULL,
    [LyDoTuChoi] nvarchar(500) NULL,
    [NgayHoanThanh] datetime2 NULL,
    CONSTRAINT [PK_YeuCauCaiDatPhanMems] PRIMARY KEY ([YeuCauId]),
    CONSTRAINT [FK_YeuCauCaiDatPhanMems_NhanViens_NguoiDuyetId] FOREIGN KEY ([NguoiDuyetId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_YeuCauCaiDatPhanMems_NhanViens_NguoiYeuCauId] FOREIGN KEY ([NguoiYeuCauId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_YeuCauCaiDatPhanMems_PhanMems_PhanMemId] FOREIGN KEY ([PhanMemId]) REFERENCES [PhanMems] ([PhanMemId])
);
GO

CREATE TABLE [DangKyPhanMems] (
    [DangKyPhanMemId] int NOT NULL IDENTITY,
    [DangKyPhongId] int NOT NULL,
    [PhanMemId] int NOT NULL,
    CONSTRAINT [PK_DangKyPhanMems] PRIMARY KEY ([DangKyPhanMemId]),
    CONSTRAINT [FK_DangKyPhanMems_DangKyPhongs_DangKyPhongId] FOREIGN KEY ([DangKyPhongId]) REFERENCES [DangKyPhongs] ([DangKyPhongId]) ON DELETE CASCADE,
    CONSTRAINT [FK_DangKyPhanMems_PhanMems_PhanMemId] FOREIGN KEY ([PhanMemId]) REFERENCES [PhanMems] ([PhanMemId]) ON DELETE CASCADE
);
GO

CREATE TABLE [LichSuDangKys] (
    [LichSuId] int NOT NULL IDENTITY,
    [DangKyPhongId] int NOT NULL,
    [NguoiThucHienId] int NOT NULL,
    [HanhDong] nvarchar(100) NOT NULL,
    [NoiDung] nvarchar(500) NULL,
    [ThoiGian] datetime2 NOT NULL,
    [TrangThaiCu] int NOT NULL,
    [TrangThaiMoi] int NOT NULL,
    CONSTRAINT [PK_LichSuDangKys] PRIMARY KEY ([LichSuId]),
    CONSTRAINT [FK_LichSuDangKys_DangKyPhongs_DangKyPhongId] FOREIGN KEY ([DangKyPhongId]) REFERENCES [DangKyPhongs] ([DangKyPhongId]) ON DELETE CASCADE,
    CONSTRAINT [FK_LichSuDangKys_NhanViens_NguoiThucHienId] FOREIGN KEY ([NguoiThucHienId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MaNhanVien', N'Email', N'HoTen', N'PhongBanId', N'SoDienThoai') AND [object_id] = OBJECT_ID(N'[NhanViens]'))
    SET IDENTITY_INSERT [NhanViens] ON;
INSERT INTO [NhanViens] ([MaNhanVien], [Email], [HoTen], [PhongBanId], [SoDienThoai])
VALUES (5, N'gv@test.com', N'Giáo viên', NULL, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MaNhanVien', N'Email', N'HoTen', N'PhongBanId', N'SoDienThoai') AND [object_id] = OBJECT_ID(N'[NhanViens]'))
    SET IDENTITY_INSERT [NhanViens] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'PhongBanId', N'MoTa', N'TenPhongBan') AND [object_id] = OBJECT_ID(N'[PhongBans]'))
    SET IDENTITY_INSERT [PhongBans] ON;
INSERT INTO [PhongBans] ([PhongBanId], [MoTa], [TenPhongBan])
VALUES (1, N'Phòng đào tạo', N'Phòng Đào Tạo'),
(2, N'Trung tâm đào tạo', N'Trung Tâm Đào Tạo');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'PhongBanId', N'MoTa', N'TenPhongBan') AND [object_id] = OBJECT_ID(N'[PhongBans]'))
    SET IDENTITY_INSERT [PhongBans] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'QuyenId', N'MaQuyen', N'MoTa', N'TenQuyen') AND [object_id] = OBJECT_ID(N'[Quyens]'))
    SET IDENTITY_INSERT [Quyens] ON;
INSERT INTO [Quyens] ([QuyenId], [MaQuyen], [MoTa], [TenQuyen])
VALUES (1, N'LOGIN', NULL, N'Đăng nhập'),
(2, N'CREATE_BOOKING', NULL, N'Tạo booking'),
(3, N'EDIT_BOOKING', NULL, N'Sửa booking của mình'),
(4, N'APPROVE_PDT', NULL, N'Duyệt PDT'),
(5, N'APPROVE_TTDT', NULL, N'Duyệt TTDT'),
(6, N'REJECT_BOOKING', NULL, N'Từ chối booking'),
(7, N'MANAGE_ROOM', NULL, N'Quản lý phòng'),
(8, N'MANAGE_SOFTWARE', NULL, N'Quản lý phần mềm'),
(9, N'VIEW_REPORT', NULL, N'Xem báo cáo'),
(10, N'OVERRIDE_SCHEDULE', NULL, N'Ghi đè lịch');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'QuyenId', N'MaQuyen', N'MoTa', N'TenQuyen') AND [object_id] = OBJECT_ID(N'[Quyens]'))
    SET IDENTITY_INSERT [Quyens] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'VaiTroId', N'MoTa', N'TenVaiTro') AND [object_id] = OBJECT_ID(N'[VaiTros]'))
    SET IDENTITY_INSERT [VaiTros] ON;
INSERT INTO [VaiTros] ([VaiTroId], [MoTa], [TenVaiTro])
VALUES (1, N'Quản trị viên hệ thống', N'Admin'),
(2, N'Quản lý trung tâm', N'QL_TrungTam'),
(3, N'Nhân viên trung tâm đào tạo', N'NV_TrungTam'),
(4, N'Nhân viên phòng đào tạo', N'NV_PhongDaoTao'),
(5, N'Giáo viên', N'GiaoVien');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'VaiTroId', N'MoTa', N'TenVaiTro') AND [object_id] = OBJECT_ID(N'[VaiTros]'))
    SET IDENTITY_INSERT [VaiTros] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MaNhanVien', N'Email', N'HoTen', N'PhongBanId', N'SoDienThoai') AND [object_id] = OBJECT_ID(N'[NhanViens]'))
    SET IDENTITY_INSERT [NhanViens] ON;
INSERT INTO [NhanViens] ([MaNhanVien], [Email], [HoTen], [PhongBanId], [SoDienThoai])
VALUES (1, N'admin@test.com', N'Admin', 2, NULL),
(2, N'qltt@test.com', N'Quản lý TT', 2, NULL),
(3, N'nvtt@test.com', N'NV Trung tâm', 2, NULL),
(4, N'nvpdt@test.com', N'NV Phòng ĐT', 1, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MaNhanVien', N'Email', N'HoTen', N'PhongBanId', N'SoDienThoai') AND [object_id] = OBJECT_ID(N'[NhanViens]'))
    SET IDENTITY_INSERT [NhanViens] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'TaiKhoanId', N'IsActive', N'MaNhanVien', N'MatKhau', N'NgayTao', N'NhanVienMaNhanVien', N'TenDangNhap', N'VaiTroId') AND [object_id] = OBJECT_ID(N'[TaiKhoans]'))
    SET IDENTITY_INSERT [TaiKhoans] ON;
INSERT INTO [TaiKhoans] ([TaiKhoanId], [IsActive], [MaNhanVien], [MatKhau], [NgayTao], [NhanVienMaNhanVien], [TenDangNhap], [VaiTroId])
VALUES (1, CAST(1 AS bit), 1, N'admin123', '2026-01-27T21:24:00.2123593+07:00', NULL, N'admin', 1),
(2, CAST(1 AS bit), 2, N'qltt123', '2026-01-27T21:24:00.2123610+07:00', NULL, N'qltt', 2),
(3, CAST(1 AS bit), 3, N'nvtt123', '2026-01-27T21:24:00.2123611+07:00', NULL, N'nvtt', 3),
(4, CAST(1 AS bit), 4, N'nvpdt123', '2026-01-27T21:24:00.2123612+07:00', NULL, N'nvpdt', 4),
(5, CAST(1 AS bit), 5, N'gv123', '2026-01-27T21:24:00.2123613+07:00', NULL, N'gv', 5);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'TaiKhoanId', N'IsActive', N'MaNhanVien', N'MatKhau', N'NgayTao', N'NhanVienMaNhanVien', N'TenDangNhap', N'VaiTroId') AND [object_id] = OBJECT_ID(N'[TaiKhoans]'))
    SET IDENTITY_INSERT [TaiKhoans] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'VaiTroQuyenId', N'QuyenId', N'VaiTroId') AND [object_id] = OBJECT_ID(N'[VaiTroQuyens]'))
    SET IDENTITY_INSERT [VaiTroQuyens] ON;
INSERT INTO [VaiTroQuyens] ([VaiTroQuyenId], [QuyenId], [VaiTroId])
VALUES (1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 1, 2),
(12, 2, 2),
(13, 3, 2),
(14, 5, 2),
(15, 6, 2),
(16, 7, 2),
(17, 8, 2),
(18, 9, 2),
(19, 10, 2),
(20, 1, 3),
(21, 2, 3),
(22, 3, 3),
(23, 5, 3),
(24, 6, 3),
(25, 8, 3),
(26, 9, 3),
(27, 1, 4),
(28, 4, 4),
(29, 6, 4),
(30, 9, 4),
(31, 1, 5),
(32, 2, 5),
(33, 3, 5);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'VaiTroQuyenId', N'QuyenId', N'VaiTroId') AND [object_id] = OBJECT_ID(N'[VaiTroQuyens]'))
    SET IDENTITY_INSERT [VaiTroQuyens] OFF;
GO

CREATE INDEX [IX_BaoTriPhongs_NguoiBaoCaoId] ON [BaoTriPhongs] ([NguoiBaoCaoId]);
GO

CREATE INDEX [IX_BaoTriPhongs_NguoiXuLyId] ON [BaoTriPhongs] ([NguoiXuLyId]);
GO

CREATE INDEX [IX_BaoTriPhongs_PhongMayId] ON [BaoTriPhongs] ([PhongMayId]);
GO

CREATE INDEX [IX_DangKyPhanMems_DangKyPhongId] ON [DangKyPhanMems] ([DangKyPhongId]);
GO

CREATE INDEX [IX_DangKyPhanMems_PhanMemId] ON [DangKyPhanMems] ([PhanMemId]);
GO

CREATE INDEX [IX_DangKyPhongs_GiaoVienId] ON [DangKyPhongs] ([GiaoVienId]);
GO

CREATE INDEX [IX_DangKyPhongs_HocPhanId] ON [DangKyPhongs] ([HocPhanId]);
GO

CREATE INDEX [IX_DangKyPhongs_NguoiDuyetPDTId] ON [DangKyPhongs] ([NguoiDuyetPDTId]);
GO

CREATE INDEX [IX_DangKyPhongs_NguoiDuyetTTDTId] ON [DangKyPhongs] ([NguoiDuyetTTDTId]);
GO

CREATE INDEX [IX_DangKyPhongs_PhongMayId] ON [DangKyPhongs] ([PhongMayId]);
GO

CREATE INDEX [IX_LichSuDangKys_DangKyPhongId] ON [LichSuDangKys] ([DangKyPhongId]);
GO

CREATE INDEX [IX_LichSuDangKys_NguoiThucHienId] ON [LichSuDangKys] ([NguoiThucHienId]);
GO

CREATE INDEX [IX_NhanViens_PhongBanId] ON [NhanViens] ([PhongBanId]);
GO

CREATE INDEX [IX_PhongMayPhanMems_PhanMemId] ON [PhongMayPhanMems] ([PhanMemId]);
GO

CREATE INDEX [IX_PhongMayPhanMems_PhongMayId] ON [PhongMayPhanMems] ([PhongMayId]);
GO

CREATE INDEX [IX_TaiKhoans_NhanVienMaNhanVien] ON [TaiKhoans] ([NhanVienMaNhanVien]);
GO

CREATE INDEX [IX_TaiKhoans_VaiTroId] ON [TaiKhoans] ([VaiTroId]);
GO

CREATE INDEX [IX_ThongBaos_NguoiNhanId] ON [ThongBaos] ([NguoiNhanId]);
GO

CREATE INDEX [IX_VaiTroQuyens_QuyenId] ON [VaiTroQuyens] ([QuyenId]);
GO

CREATE INDEX [IX_VaiTroQuyens_VaiTroId] ON [VaiTroQuyens] ([VaiTroId]);
GO

CREATE INDEX [IX_YeuCauCaiDatPhanMems_NguoiDuyetId] ON [YeuCauCaiDatPhanMems] ([NguoiDuyetId]);
GO

CREATE INDEX [IX_YeuCauCaiDatPhanMems_NguoiYeuCauId] ON [YeuCauCaiDatPhanMems] ([NguoiYeuCauId]);
GO

CREATE INDEX [IX_YeuCauCaiDatPhanMems_PhanMemId] ON [YeuCauCaiDatPhanMems] ([PhanMemId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260127142400_InitialCreate', N'8.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [HocPhans] ADD [TrangThaiHoatDong] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T21:52:58.3653290+07:00'
WHERE [TaiKhoanId] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T21:52:58.3653302+07:00'
WHERE [TaiKhoanId] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T21:52:58.3653304+07:00'
WHERE [TaiKhoanId] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T21:52:58.3653305+07:00'
WHERE [TaiKhoanId] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T21:52:58.3653306+07:00'
WHERE [TaiKhoanId] = 5;
SELECT @@ROWCOUNT;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260127145259_AddTrangThaiHoatDongToHocPhan', N'8.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [PhongMays] ADD [LyDoTuChoi] nvarchar(500) NULL;
GO

ALTER TABLE [PhongMays] ADD [NgayDuyet] datetime2 NULL;
GO

ALTER TABLE [PhongMays] ADD [NgayTao] datetime2 NULL;
GO

ALTER TABLE [PhongMays] ADD [NguoiDuyetId] int NULL;
GO

ALTER TABLE [PhongMays] ADD [NguoiTaoId] int NULL;
GO

ALTER TABLE [PhongMays] ADD [TrangThaiDuyet] int NOT NULL DEFAULT 0;
GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T22:19:31.3219860+07:00'
WHERE [TaiKhoanId] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T22:19:31.3219873+07:00'
WHERE [TaiKhoanId] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T22:19:31.3219874+07:00'
WHERE [TaiKhoanId] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T22:19:31.3219875+07:00'
WHERE [TaiKhoanId] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-27T22:19:31.3219876+07:00'
WHERE [TaiKhoanId] = 5;
SELECT @@ROWCOUNT;

GO

CREATE INDEX [IX_PhongMays_NguoiDuyetId] ON [PhongMays] ([NguoiDuyetId]);
GO

CREATE INDEX [IX_PhongMays_NguoiTaoId] ON [PhongMays] ([NguoiTaoId]);
GO

ALTER TABLE [PhongMays] ADD CONSTRAINT [FK_PhongMays_NhanViens_NguoiDuyetId] FOREIGN KEY ([NguoiDuyetId]) REFERENCES [NhanViens] ([MaNhanVien]);
GO

ALTER TABLE [PhongMays] ADD CONSTRAINT [FK_PhongMays_NhanViens_NguoiTaoId] FOREIGN KEY ([NguoiTaoId]) REFERENCES [NhanViens] ([MaNhanVien]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260127151931_AddApprovalToPhongMay', N'8.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [DangKyPhongs] ADD [GhiDeLich] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

ALTER TABLE [DangKyPhongs] ADD [LyDoGhiDe] nvarchar(1000) NULL;
GO

ALTER TABLE [DangKyPhongs] ADD [NgayDuyetGhiDe] datetime2 NULL;
GO

ALTER TABLE [DangKyPhongs] ADD [NguoiDuyetGhiDeId] int NULL;
GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:11:37.7366025+07:00'
WHERE [TaiKhoanId] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:11:37.7366041+07:00'
WHERE [TaiKhoanId] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:11:37.7366044+07:00'
WHERE [TaiKhoanId] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:11:37.7366045+07:00'
WHERE [TaiKhoanId] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:11:37.7366046+07:00'
WHERE [TaiKhoanId] = 5;
SELECT @@ROWCOUNT;

GO

CREATE INDEX [IX_DangKyPhongs_NguoiDuyetGhiDeId] ON [DangKyPhongs] ([NguoiDuyetGhiDeId]);
GO

ALTER TABLE [DangKyPhongs] ADD CONSTRAINT [FK_DangKyPhongs_NhanViens_NguoiDuyetGhiDeId] FOREIGN KEY ([NguoiDuyetGhiDeId]) REFERENCES [NhanViens] ([MaNhanVien]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260127181138_AddGhiDeLichToDangKyPhong', N'8.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [MuonBus] (
    [MuonBuId] int NOT NULL IDENTITY,
    [GiaoVienId] int NOT NULL,
    [HocPhanId] int NOT NULL,
    [PhongMayId] int NOT NULL,
    [NgayMuon] datetime2 NOT NULL,
    [GioMuonBatDau] time NOT NULL,
    [GioMuonKetThuc] time NOT NULL,
    [LyDoMuon] nvarchar(1000) NOT NULL,
    [SoLuongSinhVien] int NOT NULL,
    [NgayTraBu] datetime2 NULL,
    [GioTraBuBatDau] time NULL,
    [GioTraBuKetThuc] time NULL,
    [PhongMayTraBuId] int NULL,
    [GhiChuTraBu] nvarchar(1000) NULL,
    [HanTraBu] datetime2 NOT NULL,
    [TrangThai] int NOT NULL,
    [NguoiDuyetId] int NULL,
    [NgayDuyet] datetime2 NULL,
    [LyDoTuChoi] nvarchar(500) NULL,
    [NguoiXacNhanTraBuId] int NULL,
    [NgayXacNhanTraBu] datetime2 NULL,
    [NgayTao] datetime2 NOT NULL,
    [GhiChu] nvarchar(500) NULL,
    CONSTRAINT [PK_MuonBus] PRIMARY KEY ([MuonBuId]),
    CONSTRAINT [FK_MuonBus_HocPhans_HocPhanId] FOREIGN KEY ([HocPhanId]) REFERENCES [HocPhans] ([HocPhanId]) ON DELETE CASCADE,
    CONSTRAINT [FK_MuonBus_NhanViens_GiaoVienId] FOREIGN KEY ([GiaoVienId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_MuonBus_NhanViens_NguoiDuyetId] FOREIGN KEY ([NguoiDuyetId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_MuonBus_NhanViens_NguoiXacNhanTraBuId] FOREIGN KEY ([NguoiXacNhanTraBuId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION,
    CONSTRAINT [FK_MuonBus_PhongMays_PhongMayId] FOREIGN KEY ([PhongMayId]) REFERENCES [PhongMays] ([PhongMayId]) ON DELETE NO ACTION,
    CONSTRAINT [FK_MuonBus_PhongMays_PhongMayTraBuId] FOREIGN KEY ([PhongMayTraBuId]) REFERENCES [PhongMays] ([PhongMayId]) ON DELETE NO ACTION
);
GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:37:23.5898327+07:00'
WHERE [TaiKhoanId] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:37:23.5898344+07:00'
WHERE [TaiKhoanId] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:37:23.5898430+07:00'
WHERE [TaiKhoanId] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:37:23.5898431+07:00'
WHERE [TaiKhoanId] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:37:23.5898432+07:00'
WHERE [TaiKhoanId] = 5;
SELECT @@ROWCOUNT;

GO

CREATE INDEX [IX_MuonBus_GiaoVienId] ON [MuonBus] ([GiaoVienId]);
GO

CREATE INDEX [IX_MuonBus_HocPhanId] ON [MuonBus] ([HocPhanId]);
GO

CREATE INDEX [IX_MuonBus_NguoiDuyetId] ON [MuonBus] ([NguoiDuyetId]);
GO

CREATE INDEX [IX_MuonBus_NguoiXacNhanTraBuId] ON [MuonBus] ([NguoiXacNhanTraBuId]);
GO

CREATE INDEX [IX_MuonBus_PhongMayId] ON [MuonBus] ([PhongMayId]);
GO

CREATE INDEX [IX_MuonBus_PhongMayTraBuId] ON [MuonBus] ([PhongMayTraBuId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260127183724_AddMuonBuFeature', N'8.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [MuonBus] DROP CONSTRAINT [FK_MuonBus_HocPhans_HocPhanId];
GO

ALTER TABLE [MuonBus] DROP CONSTRAINT [FK_MuonBus_NhanViens_GiaoVienId];
GO

ALTER TABLE [MuonBus] DROP CONSTRAINT [FK_MuonBus_NhanViens_NguoiXacNhanTraBuId];
GO

ALTER TABLE [MuonBus] DROP CONSTRAINT [FK_MuonBus_PhongMays_PhongMayId];
GO

ALTER TABLE [MuonBus] DROP CONSTRAINT [FK_MuonBus_PhongMays_PhongMayTraBuId];
GO

DROP INDEX [IX_MuonBus_GiaoVienId] ON [MuonBus];
GO

DROP INDEX [IX_MuonBus_NguoiXacNhanTraBuId] ON [MuonBus];
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MuonBus]') AND [c].[name] = N'GiaoVienId');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [MuonBus] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [MuonBus] DROP COLUMN [GiaoVienId];
GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MuonBus]') AND [c].[name] = N'NguoiXacNhanTraBuId');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [MuonBus] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [MuonBus] DROP COLUMN [NguoiXacNhanTraBuId];
GO

EXEC sp_rename N'[MuonBus].[SoLuongSinhVien]', N'GiaoVienMuonId', N'COLUMN';
GO

EXEC sp_rename N'[MuonBus].[PhongMayTraBuId]', N'DangKyPhongTraBuId', N'COLUMN';
GO

EXEC sp_rename N'[MuonBus].[PhongMayId]', N'GiaoVienChoMuonId', N'COLUMN';
GO

EXEC sp_rename N'[MuonBus].[NgayXacNhanTraBu]', N'NgayTraBuThucTe', N'COLUMN';
GO

EXEC sp_rename N'[MuonBus].[HocPhanId]', N'DangKyPhongMuonId', N'COLUMN';
GO

EXEC sp_rename N'[MuonBus].[GhiChu]', N'GhiChuQuaHan', N'COLUMN';
GO

EXEC sp_rename N'[MuonBus].[IX_MuonBus_PhongMayTraBuId]', N'IX_MuonBus_DangKyPhongTraBuId', N'INDEX';
GO

EXEC sp_rename N'[MuonBus].[IX_MuonBus_PhongMayId]', N'IX_MuonBus_GiaoVienChoMuonId', N'INDEX';
GO

EXEC sp_rename N'[MuonBus].[IX_MuonBus_HocPhanId]', N'IX_MuonBus_DangKyPhongMuonId', N'INDEX';
GO

ALTER TABLE [MuonBus] ADD [QuaHan] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:40:56.2085788+07:00'
WHERE [TaiKhoanId] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:40:56.2085804+07:00'
WHERE [TaiKhoanId] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:40:56.2085805+07:00'
WHERE [TaiKhoanId] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:40:56.2085806+07:00'
WHERE [TaiKhoanId] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T01:40:56.2085808+07:00'
WHERE [TaiKhoanId] = 5;
SELECT @@ROWCOUNT;

GO

CREATE INDEX [IX_MuonBus_GiaoVienMuonId] ON [MuonBus] ([GiaoVienMuonId]);
GO

ALTER TABLE [MuonBus] ADD CONSTRAINT [FK_MuonBus_DangKyPhongs_DangKyPhongMuonId] FOREIGN KEY ([DangKyPhongMuonId]) REFERENCES [DangKyPhongs] ([DangKyPhongId]) ON DELETE NO ACTION;
GO

ALTER TABLE [MuonBus] ADD CONSTRAINT [FK_MuonBus_DangKyPhongs_DangKyPhongTraBuId] FOREIGN KEY ([DangKyPhongTraBuId]) REFERENCES [DangKyPhongs] ([DangKyPhongId]) ON DELETE NO ACTION;
GO

ALTER TABLE [MuonBus] ADD CONSTRAINT [FK_MuonBus_NhanViens_GiaoVienChoMuonId] FOREIGN KEY ([GiaoVienChoMuonId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION;
GO

ALTER TABLE [MuonBus] ADD CONSTRAINT [FK_MuonBus_NhanViens_GiaoVienMuonId] FOREIGN KEY ([GiaoVienMuonId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260127184056_AddMuonBuTable', N'8.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [DangKyPhongs] DROP CONSTRAINT [FK_DangKyPhongs_NhanViens_NguoiDuyetGhiDeId];
GO

ALTER TABLE [LichSuDangKys] DROP CONSTRAINT [FK_LichSuDangKys_NhanViens_NguoiThucHienId];
GO

ALTER TABLE [YeuCauCaiDatPhanMems] DROP CONSTRAINT [FK_YeuCauCaiDatPhanMems_NhanViens_NguoiDuyetId];
GO

ALTER TABLE [DangKyPhongs] ADD [ThuTrongTuan] nvarchar(20) NULL;
GO

UPDATE [Quyens] SET [MaQuyen] = N'VIEW_LIST', [TenQuyen] = N'XemDanhSach'
WHERE [QuyenId] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [MaQuyen] = N'REGISTER_ROOM', [TenQuyen] = N'DangKyPhong'
WHERE [QuyenId] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [MaQuyen] = N'VIEW_MY_SCHEDULE', [TenQuyen] = N'XemLichCuaToi'
WHERE [QuyenId] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [TenQuyen] = N'DuyetDangKyPDT'
WHERE [QuyenId] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [TenQuyen] = N'DuyetDangKyTTDT'
WHERE [QuyenId] = 5;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [MaQuyen] = N'MANAGE_ROOM', [TenQuyen] = N'QuanLyPhongMay'
WHERE [QuyenId] = 6;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [MaQuyen] = N'MANAGE_SUBJECT', [TenQuyen] = N'QuanLyHocPhan'
WHERE [QuyenId] = 7;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [MaQuyen] = N'MANAGE_STAFF', [TenQuyen] = N'QuanLyNhanVien'
WHERE [QuyenId] = 8;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [MaQuyen] = N'MANAGE_MAINTENANCE', [TenQuyen] = N'QuanLyBaoTri'
WHERE [QuyenId] = 9;
SELECT @@ROWCOUNT;

GO

UPDATE [Quyens] SET [MaQuyen] = N'VIEW_REPORT', [TenQuyen] = N'XemBaoCao'
WHERE [QuyenId] = 10;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T02:52:54.5311843+07:00'
WHERE [TaiKhoanId] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T02:52:54.5311898+07:00'
WHERE [TaiKhoanId] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T02:52:54.5311899+07:00'
WHERE [TaiKhoanId] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T02:52:54.5311900+07:00'
WHERE [TaiKhoanId] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TaiKhoans] SET [NgayTao] = '2026-01-28T02:52:54.5311902+07:00'
WHERE [TaiKhoanId] = 5;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 9
WHERE [VaiTroQuyenId] = 17;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 10
WHERE [VaiTroQuyenId] = 18;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 1, [VaiTroId] = 3
WHERE [VaiTroQuyenId] = 19;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 2
WHERE [VaiTroQuyenId] = 20;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 3
WHERE [VaiTroQuyenId] = 21;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 5
WHERE [VaiTroQuyenId] = 22;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 6
WHERE [VaiTroQuyenId] = 23;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 7
WHERE [VaiTroQuyenId] = 24;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 9
WHERE [VaiTroQuyenId] = 25;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTroQuyens] SET [QuyenId] = 10
WHERE [VaiTroQuyenId] = 26;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTros] SET [MoTa] = N'Nhân viên trung tâm'
WHERE [VaiTroId] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTros] SET [MoTa] = N'Phòng đào tạo', [TenVaiTro] = N'PDT'
WHERE [VaiTroId] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [VaiTros] SET [MoTa] = N'Giảng viên'
WHERE [VaiTroId] = 5;
SELECT @@ROWCOUNT;

GO

ALTER TABLE [DangKyPhongs] ADD CONSTRAINT [FK_DangKyPhongs_NhanViens_NguoiDuyetGhiDeId] FOREIGN KEY ([NguoiDuyetGhiDeId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION;
GO

ALTER TABLE [LichSuDangKys] ADD CONSTRAINT [FK_LichSuDangKys_NhanViens_NguoiThucHienId] FOREIGN KEY ([NguoiThucHienId]) REFERENCES [NhanViens] ([MaNhanVien]) ON DELETE NO ACTION;
GO

ALTER TABLE [YeuCauCaiDatPhanMems] ADD CONSTRAINT [FK_YeuCauCaiDatPhanMems_NhanViens_NguoiDuyetId] FOREIGN KEY ([NguoiDuyetId]) REFERENCES [NhanViens] ([MaNhanVien]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260127195255_ThemThuTrongTuan', N'8.0.0');
GO

COMMIT;
GO

