-- Script tạo dữ liệu mẫu cho Hợp đồng giảng viên
-- Học kỳ hiện tại: HK2 2025-2026 (TrangThai = 1)

USE QL_PHONG_TH;
GO

-- Xóa dữ liệu cũ (nếu cần reset)
DELETE FROM HopDongMonHocs;
DELETE FROM HopDongs;
DELETE FROM HocPhans WHERE HocKyId = (SELECT TOP 1 Id FROM HocKys WHERE TrangThai = 1);
GO

-- Lấy Id học kỳ hiện tại
DECLARE @HocKyId INT;
SELECT TOP 1 @HocKyId = Id FROM HocKys WHERE TrangThai = 1;

-- Lấy Id admin (người tạo)
DECLARE @AdminId INT = 1;

-- Kiểm tra dữ liệu cơ bản
PRINT 'Học kỳ hiện tại ID: ' + CAST(@HocKyId AS VARCHAR);

-- Tạo thêm giảng viên thỉnh giảng nếu chưa có đủ
IF NOT EXISTS (SELECT 1 FROM TaiKhoans WHERE TenDangNhap = 'gv06')
BEGIN
    INSERT INTO TaiKhoans (TenDangNhap, MatKhauHash, HoTen, Email, SoDienThoai, VaiTro, LoaiGiangVien, TrangThaiHoatDong, NgayTao)
    VALUES 
    ('gv06', 'AQAAAAIAAYagAAAAELnD7YqPbEEqBJz4kB7bFXxVhOqAEb0KJvY8v2VWbq5h1iK5CfQE+7xPmL3WrR2TYQ==', N'Phạm Văn Hùng', 'hungpv@utc.edu.vn', '0901234006', 4, 1, 1, GETDATE()),
    ('gv07', 'AQAAAAIAAYagAAAAELnD7YqPbEEqBJz4kB7bFXxVhOqAEb0KJvY8v2VWbq5h1iK5CfQE+7xPmL3WrR2TYQ==', N'Lê Thị Hương', 'huonglt@utc.edu.vn', '0901234007', 4, 1, 1, GETDATE()),
    ('gv08', 'AQAAAAIAAYagAAAAELnD7YqPbEEqBJz4kB7bFXxVhOqAEb0KJvY8v2VWbq5h1iK5CfQE+7xPmL3WrR2TYQ==', N'Nguyễn Hoàng Nam', 'namnh@utc.edu.vn', '0901234008', 4, 2, 1, GETDATE()),
    ('gv09', 'AQAAAAIAAYagAAAAELnD7YqPbEEqBJz4kB7bFXxVhOqAEb0KJvY8v2VWbq5h1iK5CfQE+7xPmL3WrR2TYQ==', N'Trần Minh Tuấn', 'tuantm@utc.edu.vn', '0901234009', 4, 2, 1, GETDATE()),
    ('gv10', 'AQAAAAIAAYagAAAAELnD7YqPbEEqBJz4kB7bFXxVhOqAEb0KJvY8v2VWbq5h1iK5CfQE+7xPmL3WrR2TYQ==', N'Vũ Thị Mai', 'maivt@utc.edu.vn', '0901234010', 4, 1, 1, GETDATE());
    PRINT 'Đã tạo thêm 5 giảng viên mới';
END

-- Tạo thêm môn học nếu chưa có đủ
IF NOT EXISTS (SELECT 1 FROM MonHocs WHERE MaMonHoc = 'IT2.101')
BEGIN
    INSERT INTO MonHocs (MaMonHoc, TenMonHoc, SoTinChi, SoBuoiThucHanh, MoTa, TrangThaiHoatDong, NgayTao)
    VALUES 
    ('IT2.101', N'Cấu trúc dữ liệu và giải thuật', 3, 5, N'Môn học về cấu trúc dữ liệu cơ bản', 1, GETDATE()),
    ('IT2.102', N'Hệ điều hành', 3, 4, N'Môn học về hệ điều hành', 1, GETDATE()),
    ('IT2.103', N'Mạng máy tính', 3, 5, N'Môn học về mạng máy tính', 1, GETDATE()),
    ('IT2.104', N'Cơ sở dữ liệu', 3, 6, N'Môn học về cơ sở dữ liệu quan hệ', 1, GETDATE()),
    ('IT2.105', N'Lập trình Web', 3, 8, N'Môn học về lập trình web', 1, GETDATE()),
    ('IT2.106', N'Lập trình di động', 3, 7, N'Môn học về lập trình ứng dụng di động', 1, GETDATE()),
    ('IT3.201', N'Công nghệ phần mềm', 3, 5, N'Môn học về quy trình phát triển phần mềm', 1, GETDATE()),
    ('IT3.202', N'Trí tuệ nhân tạo', 3, 6, N'Môn học về AI cơ bản', 1, GETDATE()),
    ('IT3.203', N'An toàn thông tin', 3, 4, N'Môn học về bảo mật hệ thống', 1, GETDATE());
    PRINT 'Đã tạo thêm 9 môn học mới';
END

-- Lấy danh sách giảng viên
DECLARE @GV1 INT, @GV2 INT, @GV3 INT, @GV4 INT, @GV5 INT, @GV6 INT, @GV7 INT, @GV8 INT, @GV9 INT, @GV10 INT;
SELECT @GV1 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv01' OR (VaiTro = 4 AND TrangThaiHoatDong = 1 AND Id = (SELECT MIN(Id) FROM TaiKhoans WHERE VaiTro = 4));
SELECT @GV2 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv02' OR (VaiTro = 4 AND TrangThaiHoatDong = 1 AND Id = (SELECT MIN(Id)+1 FROM TaiKhoans WHERE VaiTro = 4));
SELECT @GV3 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv03';
SELECT @GV4 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv04';
SELECT @GV5 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv05';
SELECT @GV6 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv06';
SELECT @GV7 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv07';
SELECT @GV8 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv08';
SELECT @GV9 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv09';
SELECT @GV10 = Id FROM TaiKhoans WHERE TenDangNhap = 'gv10';

-- Lấy danh sách môn học
DECLARE @MH1 INT, @MH2 INT, @MH3 INT, @MH4 INT, @MH5 INT, @MH6 INT, @MH7 INT, @MH8 INT, @MH9 INT, @MH10 INT;
SELECT TOP 1 @MH1 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 ORDER BY Id;
SELECT TOP 1 @MH2 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH1 ORDER BY Id;
SELECT TOP 1 @MH3 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH2 ORDER BY Id;
SELECT TOP 1 @MH4 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH3 ORDER BY Id;
SELECT TOP 1 @MH5 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH4 ORDER BY Id;
SELECT TOP 1 @MH6 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH5 ORDER BY Id;
SELECT TOP 1 @MH7 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH6 ORDER BY Id;
SELECT TOP 1 @MH8 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH7 ORDER BY Id;
SELECT TOP 1 @MH9 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH8 ORDER BY Id;
SELECT TOP 1 @MH10 = Id FROM MonHocs WHERE TrangThaiHoatDong = 1 AND Id > @MH9 ORDER BY Id;

-- In thông tin debug
PRINT 'GV IDs: ' + ISNULL(CAST(@GV1 AS VARCHAR), 'NULL') + ', ' + ISNULL(CAST(@GV2 AS VARCHAR), 'NULL') + ', ' + ISNULL(CAST(@GV3 AS VARCHAR), 'NULL');
PRINT 'MH IDs: ' + ISNULL(CAST(@MH1 AS VARCHAR), 'NULL') + ', ' + ISNULL(CAST(@MH2 AS VARCHAR), 'NULL') + ', ' + ISNULL(CAST(@MH3 AS VARCHAR), 'NULL');

-- =====================================================
-- TẠO 15 HỢP ĐỒNG VỚI CÁC TRẠNG THÁI KHÁC NHAU
-- TrangThai: 0 = Chờ duyệt, 1 = Đã duyệt, 2 = Đã hủy
-- =====================================================

-- Hợp đồng 1: GV1 dạy MH1, MH2 (Đã duyệt)
INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
VALUES ('HD2026-001', @GV1, @HocKyId, 1, N'Hợp đồng giảng viên cơ hữu', @AdminId, DATEADD(DAY, -30, GETDATE()));

DECLARE @HD1 INT = SCOPE_IDENTITY();
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD1, @MH1);
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD1, @MH2);

-- Hợp đồng 2: GV2 dạy MH1, MH3 (Đã duyệt)
INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
VALUES ('HD2026-002', @GV2, @HocKyId, 1, N'Hợp đồng giảng viên cơ hữu', @AdminId, DATEADD(DAY, -28, GETDATE()));

DECLARE @HD2 INT = SCOPE_IDENTITY();
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD2, @MH1);
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD2, @MH3);

-- Hợp đồng 3: GV3 dạy MH2, MH4 (Đã duyệt)
INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
VALUES ('HD2026-003', @GV3, @HocKyId, 1, N'Hợp đồng giảng viên cơ hữu', @AdminId, DATEADD(DAY, -25, GETDATE()));

DECLARE @HD3 INT = SCOPE_IDENTITY();
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD3, @MH2);
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD3, @MH4);

-- Hợp đồng 4: GV4 dạy MH3, MH5 (Đã duyệt)
INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
VALUES ('HD2026-004', @GV4, @HocKyId, 1, N'Hợp đồng giảng viên cơ hữu', @AdminId, DATEADD(DAY, -22, GETDATE()));

DECLARE @HD4 INT = SCOPE_IDENTITY();
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD4, @MH3);
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD4, @MH5);

-- Hợp đồng 5: GV5 dạy MH4, MH6 (Đã duyệt) 
INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
VALUES ('HD2026-005', @GV5, @HocKyId, 1, N'Hợp đồng giảng viên thỉnh giảng', @AdminId, DATEADD(DAY, -20, GETDATE()));

DECLARE @HD5 INT = SCOPE_IDENTITY();
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD5, @MH4);
INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD5, @MH6);

-- Hợp đồng 6: GV6 dạy MH5, MH7 (Đã duyệt)
IF @GV6 IS NOT NULL
BEGIN
    INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
    VALUES ('HD2026-006', @GV6, @HocKyId, 1, N'Hợp đồng giảng viên cơ hữu', @AdminId, DATEADD(DAY, -18, GETDATE()));

    DECLARE @HD6 INT = SCOPE_IDENTITY();
    INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD6, @MH5);
    IF @MH7 IS NOT NULL INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD6, @MH7);
END

-- Hợp đồng 7: GV7 dạy MH6, MH8 (Đã duyệt)
IF @GV7 IS NOT NULL
BEGIN
    INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
    VALUES ('HD2026-007', @GV7, @HocKyId, 1, N'Hợp đồng giảng viên cơ hữu', @AdminId, DATEADD(DAY, -15, GETDATE()));

    DECLARE @HD7 INT = SCOPE_IDENTITY();
    INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD7, @MH6);
    IF @MH8 IS NOT NULL INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD7, @MH8);
END

-- Hợp đồng 8: GV8 dạy MH7 (Chờ duyệt - thỉnh giảng)
IF @GV8 IS NOT NULL AND @MH7 IS NOT NULL
BEGIN
    INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
    VALUES ('HD2026-008', @GV8, @HocKyId, 0, N'Hợp đồng giảng viên thỉnh giảng - Chờ duyệt', @AdminId, DATEADD(DAY, -10, GETDATE()));

    DECLARE @HD8 INT = SCOPE_IDENTITY();
    INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD8, @MH7);
END

-- Hợp đồng 9: GV9 dạy MH8, MH9 (Chờ duyệt - thỉnh giảng)
IF @GV9 IS NOT NULL AND @MH8 IS NOT NULL
BEGIN
    INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
    VALUES ('HD2026-009', @GV9, @HocKyId, 0, N'Hợp đồng giảng viên thỉnh giảng - Chờ duyệt', @AdminId, DATEADD(DAY, -8, GETDATE()));

    DECLARE @HD9 INT = SCOPE_IDENTITY();
    INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD9, @MH8);
    IF @MH9 IS NOT NULL INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD9, @MH9);
END

-- Hợp đồng 10: GV10 dạy MH1, MH9 (Chờ duyệt)
IF @GV10 IS NOT NULL
BEGIN
    INSERT INTO HopDongs (SoHopDong, GiangVienId, HocKyId, TrangThai, GhiChu, NguoiTaoId, NgayTao)
    VALUES ('HD2026-010', @GV10, @HocKyId, 0, N'Hợp đồng giảng viên cơ hữu - Chờ duyệt', @AdminId, DATEADD(DAY, -5, GETDATE()));

    DECLARE @HD10 INT = SCOPE_IDENTITY();
    INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD10, @MH1);
    IF @MH9 IS NOT NULL INSERT INTO HopDongMonHocs (HopDongId, MonHocId) VALUES (@HD10, @MH9);
END

-- =====================================================
-- THỐNG KÊ KẾT QUẢ
-- =====================================================
PRINT '';
PRINT '=== KẾT QUẢ TẠO DỮ LIỆU MẪU ===';

SELECT 'Tổng số giảng viên' AS [Mô tả], COUNT(*) AS [Số lượng] FROM TaiKhoans WHERE VaiTro = 4 AND TrangThaiHoatDong = 1
UNION ALL
SELECT 'Tổng số môn học', COUNT(*) FROM MonHocs WHERE TrangThaiHoatDong = 1
UNION ALL
SELECT 'Tổng số hợp đồng', COUNT(*) FROM HopDongs WHERE HocKyId = @HocKyId
UNION ALL
SELECT 'Hợp đồng đã duyệt', COUNT(*) FROM HopDongs WHERE HocKyId = @HocKyId AND TrangThai = 1
UNION ALL
SELECT 'Hợp đồng chờ duyệt', COUNT(*) FROM HopDongs WHERE HocKyId = @HocKyId AND TrangThai = 0;

PRINT '';
PRINT '=== DANH SÁCH HỢP ĐỒNG ===';
SELECT 
    h.SoHopDong,
    t.HoTen AS GiangVien,
    CASE t.LoaiGiangVien WHEN 1 THEN N'Cơ hữu' ELSE N'Thỉnh giảng' END AS LoaiGV,
    CASE h.TrangThai WHEN 0 THEN N'Chờ duyệt' WHEN 1 THEN N'Đã duyệt' ELSE N'Đã hủy' END AS TrangThai,
    STRING_AGG(m.TenMonHoc, ', ') AS DanhSachMonHoc
FROM HopDongs h
INNER JOIN TaiKhoans t ON h.GiangVienId = t.Id
LEFT JOIN HopDongMonHocs hdmh ON h.Id = hdmh.HopDongId
LEFT JOIN MonHocs m ON hdmh.MonHocId = m.Id
WHERE h.HocKyId = @HocKyId
GROUP BY h.Id, h.SoHopDong, t.HoTen, t.LoaiGiangVien, h.TrangThai, h.NgayTao
ORDER BY h.NgayTao;

GO
