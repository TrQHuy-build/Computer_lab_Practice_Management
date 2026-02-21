-- ============================================
-- Script tạo dữ liệu test cho hệ thống thông báo
-- Ngày tạo: 28/01/2026
-- ============================================

USE QL_PHONG_TH;
GO

-- Xóa dữ liệu cũ (nếu có)
DELETE FROM ThongBaos;
DELETE FROM DangKyPhongs;
DELETE FROM LichHocs;
DELETE FROM HocPhans;
DELETE FROM PhongMays;
DELETE FROM TaiKhoans;
DELETE FROM NhanViens;
GO

-- ============================================
-- 1. TẠO NHÂN VIÊN VÀ TÀI KHOẢN
-- ============================================

-- Admin
INSERT INTO NhanViens (MaNhanVien, HoTen, Email, SoDienThoai, DiaChi) 
VALUES ('NV001', N'Nguyễn Văn Admin', 'admin@example.com', '0901234567', N'Hà Nội');

INSERT INTO TaiKhoans (TenDangNhap, MatKhau, VaiTroId, MaNhanVien, IsActive) 
VALUES ('admin', 'admin123', 1, 'NV001', 1);

-- Quản lý Trung tâm (QL_TT - VaiTroId = 2)
INSERT INTO NhanViens (MaNhanVien, HoTen, Email, SoDienThoai, DiaChi) 
VALUES ('NV002', N'Trần Thị Quản Lý', 'qltt@example.com', '0901234568', N'Hà Nội');

INSERT INTO TaiKhoans (TenDangNhap, MatKhau, VaiTroId, MaNhanVien, IsActive) 
VALUES ('qltt', 'qltt123', 2, 'NV002', 1);

-- Nhân viên Trung tâm (NV_TT - VaiTroId = 3)
INSERT INTO NhanViens (MaNhanVien, HoTen, Email, SoDienThoai, DiaChi) 
VALUES ('NV003', N'Lê Văn Nhân Viên', 'nvtt@example.com', '0901234569', N'Hà Nội');

INSERT INTO TaiKhoans (TenDangNhap, MatKhau, VaiTroId, MaNhanVien, IsActive) 
VALUES ('nvtt', 'nvtt123', 3, 'NV003', 1);

-- Phụ trách Đào tạo (PDT - VaiTroId = 4)
INSERT INTO NhanViens (MaNhanVien, HoTen, Email, SoDienThoai, DiaChi) 
VALUES ('NV004', N'Phạm Văn Phụ Trách', 'pdt@example.com', '0901234570', N'Hà Nội');

INSERT INTO TaiKhoans (TenDangNhap, MatKhau, VaiTroId, MaNhanVien, IsActive) 
VALUES ('pdt', 'pdt123', 4, 'NV004', 1);

-- Giáo viên 1
INSERT INTO NhanViens (MaNhanVien, HoTen, Email, SoDienThoai, DiaChi) 
VALUES ('GV001', N'Nguyễn Thị Thu Hà', 'gv1@example.com', '0901234571', N'Hà Nội');

INSERT INTO TaiKhoans (TenDangNhap, MatKhau, VaiTroId, MaNhanVien, IsActive) 
VALUES ('gv1', 'gv123', 5, 'GV001', 1);

-- Giáo viên 2
INSERT INTO NhanViens (MaNhanVien, HoTen, Email, SoDienThoai, DiaChi) 
VALUES ('GV002', N'Trần Văn Minh', 'gv2@example.com', '0901234572', N'Hà Nội');

INSERT INTO TaiKhoans (TenDangNhap, MatKhau, VaiTroId, MaNhanVien, IsActive) 
VALUES ('gv2', 'gv123', 5, 'GV002', 1);

-- Giáo viên 3
INSERT INTO NhanViens (MaNhanVien, HoTen, Email, SoDienThoai, DiaChi) 
VALUES ('GV003', N'Lê Thị Lan Anh', 'gv3@example.com', '0901234573', N'Hà Nội');

INSERT INTO TaiKhoans (TenDangNhap, MatKhau, VaiTroId, MaNhanVien, IsActive) 
VALUES ('gv3', 'gv123', 5, 'GV003', 1);

GO

-- ============================================
-- 2. TẠO PHÒNG MÁY
-- ============================================

INSERT INTO PhongMays (TenPhong, ViTri, SoMay, TrangThai, MoTa, NguoiTaoId, NgayTao, DaDuyet) 
VALUES 
(N'Phòng A101', N'Tầng 1, Nhà A', 40, N'Hoạt động', N'Phòng máy hiện đại, điều hòa', 'NV002', GETDATE(), 1),
(N'Phòng A102', N'Tầng 1, Nhà A', 35, N'Hoạt động', N'Phòng máy cấu hình cao', 'NV002', GETDATE(), 1),
(N'Phòng B201', N'Tầng 2, Nhà B', 30, N'Hoạt động', N'Phòng máy dùng cho lập trình', 'NV002', GETDATE(), 1),
(N'Phòng B202', N'Tầng 2, Nhà B', 25, N'Hoạt động', N'Phòng máy thiết kế đồ họa', 'NV002', GETDATE(), 1),
(N'Phòng C301', N'Tầng 3, Nhà C', 45, N'Hoạt động', N'Phòng máy cho sinh viên', 'NV002', GETDATE(), 1);

GO

-- ============================================
-- 3. TẠO HỌC PHẦN
-- ============================================

INSERT INTO HocPhans (MaHocPhan, TenHocPhan, SoTinChi, MoTa) 
VALUES 
('IT001', N'Lập trình C++', 3, N'Môn học lập trình cơ bản'),
('IT002', N'Cấu trúc dữ liệu và Giải thuật', 4, N'Môn học về cấu trúc dữ liệu'),
('IT003', N'Lập trình Web', 3, N'Môn học phát triển web'),
('IT004', N'Cơ sở dữ liệu', 3, N'Môn học về database'),
('IT005', N'Đồ họa máy tính', 3, N'Môn học thiết kế đồ họa');

GO

-- ============================================
-- 4. TẠO LỊCH HỌC
-- ============================================

-- Lịch học cho IT001 - Lập trình C++
INSERT INTO LichHocs (MaHocPhan, GiaoVienId, Thu, TietBatDau, SoTiet, PhongMayId) 
VALUES 
('IT001', 'GV001', 2, 1, 3, 1), -- Thứ 2, tiết 1-3, Phòng A101
('IT001', 'GV001', 4, 4, 3, 1); -- Thứ 4, tiết 4-6, Phòng A101

-- Lịch học cho IT002 - CTDL&GT
INSERT INTO LichHocs (MaHocPhan, GiaoVienId, Thu, TietBatDau, SoTiet, PhongMayId) 
VALUES 
('IT002', 'GV002', 3, 1, 4, 2), -- Thứ 3, tiết 1-4, Phòng A102
('IT002', 'GV002', 5, 1, 4, 2); -- Thứ 5, tiết 1-4, Phòng A102

-- Lịch học cho IT003 - Lập trình Web
INSERT INTO LichHocs (MaHocPhan, GiaoVienId, Thu, TietBatDau, SoTiet, PhongMayId) 
VALUES 
('IT003', 'GV003', 2, 7, 3, 3), -- Thứ 2, tiết 7-9, Phòng B201
('IT003', 'GV003', 4, 7, 3, 3); -- Thứ 4, tiết 7-9, Phòng B201

GO

-- ============================================
-- 5. TẠO ĐĂNG KÝ PHÒNG - DEMO CÁC TRẠNG THÁI
-- ============================================

-- Đăng ký 1: CHỜ DUYỆT PDT (GV001 tạo đơn)
INSERT INTO DangKyPhongs (GiaoVienId, MaHocPhan, PhongMayId, NgayBatDau, NgayKetThuc, LyDo, TrangThai, NgayTao)
VALUES 
('GV001', 'IT001', 1, DATEADD(day, 3, GETDATE()), DATEADD(day, 10, GETDATE()), 
 N'Đăng ký phòng máy cho môn Lập trình C++ - Lớp K18', 0, GETDATE());

-- Đăng ký 2: CHỜ DUYỆT TTDT (GV002 tạo, PDT đã duyệt)
INSERT INTO DangKyPhongs (GiaoVienId, MaHocPhan, PhongMayId, NgayBatDau, NgayKetThuc, LyDo, TrangThai, NgayTao, NgayDuyetPDT, NguoiDuyetPDTId)
VALUES 
('GV002', 'IT002', 2, DATEADD(day, 5, GETDATE()), DATEADD(day, 12, GETDATE()), 
 N'Đăng ký phòng máy cho môn CTDL&GT - Thực hành thuật toán', 1, GETDATE(), GETDATE(), 'NV004');

-- Đăng ký 3: ĐÃ DUYỆT (Hoàn tất cả 2 cấp)
INSERT INTO DangKyPhongs (GiaoVienId, MaHocPhan, PhongMayId, NgayBatDau, NgayKetThuc, LyDo, TrangThai, NgayTao, NgayDuyetPDT, NguoiDuyetPDTId, NgayDuyetTTDT, NguoiDuyetTTDTId)
VALUES 
('GV003', 'IT003', 3, DATEADD(day, 1, GETDATE()), DATEADD(day, 7, GETDATE()), 
 N'Đăng ký phòng máy cho môn Lập trình Web - Thực hành HTML/CSS', 2, DATEADD(day, -2, GETDATE()), 
 DATEADD(day, -2, GETDATE()), 'NV004', DATEADD(day, -1, GETDATE()), 'NV002');

-- Đăng ký 4: TỪ CHỐI BỞI PDT
INSERT INTO DangKyPhongs (GiaoVienId, MaHocPhan, PhongMayId, NgayBatDau, NgayKetThuc, LyDo, TrangThai, NgayTao, NgayDuyetPDT, NguoiDuyetPDTId, LyDoTuChoiPDT)
VALUES 
('GV001', 'IT004', 4, DATEADD(day, 15, GETDATE()), DATEADD(day, 20, GETDATE()), 
 N'Đăng ký phòng máy cho môn Cơ sở dữ liệu', 3, DATEADD(day, -3, GETDATE()), 
 DATEADD(day, -2, GETDATE()), 'NV004', N'Thời gian trùng với lịch học chính khóa');

-- Đăng ký 5: TỪ CHỐI BỞI TTDT
INSERT INTO DangKyPhongs (GiaoVienId, MaHocPhan, PhongMayId, NgayBatDau, NgayKetThuc, LyDo, TrangThai, NgayTao, NgayDuyetPDT, NguoiDuyetPDTId, NgayDuyetTTDT, NguoiDuyetTTDTId, LyDoTuChoiTTDT)
VALUES 
('GV002', 'IT005', 5, DATEADD(day, 20, GETDATE()), DATEADD(day, 25, GETDATE()), 
 N'Đăng ký phòng máy cho môn Đồ họa máy tính', 4, DATEADD(day, -5, GETDATE()), 
 DATEADD(day, -4, GETDATE()), 'NV004', DATEADD(day, -2, GETDATE()), 'NV002', 
 N'Phòng máy đang trong kế hoạch bảo trì');

-- Đăng ký 6: ĐÃ HỦY
INSERT INTO DangKyPhongs (GiaoVienId, MaHocPhan, PhongMayId, NgayBatDau, NgayKetThuc, LyDo, TrangThai, NgayTao, NgayHuy, NguoiHuyId, LyDoHuy)
VALUES 
('GV003', 'IT001', 1, DATEADD(day, 8, GETDATE()), DATEADD(day, 15, GETDATE()), 
 N'Đăng ký phòng máy dự phòng', 5, DATEADD(day, -4, GETDATE()), 
 DATEADD(day, -1, GETDATE()), 'GV003', N'Đã tìm được phòng máy phù hợp hơn');

GO

-- ============================================
-- 6. TẠO THÔNG BÁO MẪU
-- ============================================

-- Thông báo cho PDT về đăng ký mới
INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, DangKyPhongId, ThoiGian, DaDoc)
VALUES 
('NV004', N'🔔 Yêu cầu duyệt đăng ký phòng mới', 
 N'GV Nguyễn Thị Thu Hà đã tạo đăng ký phòng Phòng A101 cho học phần Lập trình C++ từ ' + 
 CONVERT(varchar, DATEADD(day, 3, GETDATE()), 103) + N' đến ' + 
 CONVERT(varchar, DATEADD(day, 10, GETDATE()), 103) + N'. Vui lòng xem xét và duyệt đơn.',
 '/DangKyPhong/Details/1', 1, GETDATE(), 0);

-- Thông báo cho TTDT về đăng ký đã duyệt PDT
INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, DangKyPhongId, ThoiGian, DaDoc)
VALUES 
('NV002', N'📋 Đăng ký phòng cần duyệt cấp TTDT', 
 N'PDT Phạm Văn Phụ Trách đã duyệt đăng ký phòng của GV Trần Văn Minh cho môn CTDL&GT. Vui lòng xem xét và duyệt cấp TTDT.',
 '/DangKyPhong/Details/2', 2, GETDATE(), 0);

INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, DangKyPhongId, ThoiGian, DaDoc)
VALUES 
('NV003', N'📋 Đăng ký phòng cần duyệt cấp TTDT', 
 N'PDT Phạm Văn Phụ Trách đã duyệt đăng ký phòng của GV Trần Văn Minh cho môn CTDL&GT. Vui lòng xem xét và duyệt cấp TTDT.',
 '/DangKyPhong/Details/2', 2, GETDATE(), 0);

-- Thông báo cho GV về kết quả duyệt thành công
INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, DangKyPhongId, ThoiGian, DaDoc)
VALUES 
('GV003', N'✅ Đăng ký phòng đã được duyệt', 
 N'Đăng ký phòng Phòng B201 cho môn Lập trình Web của bạn đã được TTDT Trần Thị Quản Lý duyệt. Bạn có thể sử dụng phòng từ ngày ' +
 CONVERT(varchar, DATEADD(day, 1, GETDATE()), 103) + N' đến ' + 
 CONVERT(varchar, DATEADD(day, 7, GETDATE()), 103) + N'.',
 '/DangKyPhong/Details/3', 3, DATEADD(day, -1, GETDATE()), 1);

-- Thông báo cho GV về kết quả từ chối
INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, DangKyPhongId, ThoiGian, DaDoc)
VALUES 
('GV001', N'❌ Đăng ký phòng bị từ chối', 
 N'Đăng ký phòng Phòng B202 cho môn Cơ sở dữ liệu của bạn đã bị PDT Phạm Văn Phụ Trách từ chối. ' +
 N'Lý do: Thời gian trùng với lịch học chính khóa. Vui lòng tạo đơn mới với thời gian khác.',
 '/DangKyPhong/Details/4', 4, DATEADD(day, -2, GETDATE()), 0);

-- Thông báo cho PDT về đơn bị hủy
INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, DangKyPhongId, ThoiGian, DaDoc)
VALUES 
('NV004', N'🚫 Đăng ký phòng đã bị hủy', 
 N'GV Lê Thị Lan Anh đã hủy đăng ký phòng Phòng A101 cho môn Lập trình C++. ' +
 N'Lý do: Đã tìm được phòng máy phù hợp hơn.',
 '/DangKyPhong/Details/6', 6, DATEADD(day, -1, GETDATE()), 1);

-- Thông báo cho GV2 về đơn bị từ chối bởi TTDT
INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, DangKyPhongId, ThoiGian, DaDoc)
VALUES 
('GV002', N'❌ Đăng ký phòng bị từ chối bởi TTDT', 
 N'Đăng ký phòng Phòng C301 cho môn Đồ họa máy tính của bạn đã bị TTDT Trần Thị Quản Lý từ chối. ' +
 N'Lý do: Phòng máy đang trong kế hoạch bảo trì. Vui lòng chọn phòng khác hoặc thời gian khác.',
 '/DangKyPhong/Details/5', 5, DATEADD(day, -2, GETDATE()), 0);

-- Thêm vài thông báo đã đọc để test
INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, ThoiGian, DaDoc)
VALUES 
('NV004', N'📢 Thông báo hệ thống', 
 N'Hệ thống thông báo tự động đã được kích hoạt. Bạn sẽ nhận được thông báo về tất cả các hoạt động liên quan.',
 '/ThongBao', DATEADD(hour, -2, GETDATE()), 1);

INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, DuongDan, ThoiGian, DaDoc)
VALUES 
('GV001', N'📢 Chào mừng đến với hệ thống', 
 N'Chào mừng bạn sử dụng hệ thống quản lý phòng máy. Bạn có thể tạo đăng ký phòng và theo dõi trạng thái qua thông báo.',
 '/ThongBao', DATEADD(hour, -3, GETDATE()), 1);

GO

-- ============================================
-- 7. HIỂN THỊ THỐNG KÊ
-- ============================================

PRINT '========================================';
PRINT 'DỮ LIỆU TEST ĐÃ ĐƯỢC TẠO THÀNH CÔNG!';
PRINT '========================================';
PRINT '';

PRINT 'TỔNG SỐ BẢN GHI:';
PRINT '- Nhân viên: ' + CAST((SELECT COUNT(*) FROM NhanViens) AS VARCHAR);
PRINT '- Tài khoản: ' + CAST((SELECT COUNT(*) FROM TaiKhoans) AS VARCHAR);
PRINT '- Phòng máy: ' + CAST((SELECT COUNT(*) FROM PhongMays) AS VARCHAR);
PRINT '- Học phần: ' + CAST((SELECT COUNT(*) FROM HocPhans) AS VARCHAR);
PRINT '- Lịch học: ' + CAST((SELECT COUNT(*) FROM LichHocs) AS VARCHAR);
PRINT '- Đăng ký phòng: ' + CAST((SELECT COUNT(*) FROM DangKyPhongs) AS VARCHAR);
PRINT '- Thông báo: ' + CAST((SELECT COUNT(*) FROM ThongBaos) AS VARCHAR);
PRINT '';

PRINT 'TÀI KHOẢN TEST:';
PRINT '----------------------------------------';
PRINT 'Admin:     admin / admin123';
PRINT 'QL Trung tâm: qltt / qltt123';
PRINT 'NV Trung tâm: nvtt / nvtt123';
PRINT 'Phụ trách ĐT: pdt / pdt123';
PRINT 'Giáo viên 1:  gv1 / gv123';
PRINT 'Giáo viên 2:  gv2 / gv123';
PRINT 'Giáo viên 3:  gv3 / gv123';
PRINT '';

PRINT 'THỐNG KÊ ĐĂNG KÝ PHÒNG:';
PRINT '----------------------------------------';
PRINT '- Chờ duyệt PDT: ' + CAST((SELECT COUNT(*) FROM DangKyPhongs WHERE TrangThai = 0) AS VARCHAR);
PRINT '- Chờ duyệt TTDT: ' + CAST((SELECT COUNT(*) FROM DangKyPhongs WHERE TrangThai = 1) AS VARCHAR);
PRINT '- Đã duyệt: ' + CAST((SELECT COUNT(*) FROM DangKyPhongs WHERE TrangThai = 2) AS VARCHAR);
PRINT '- Từ chối PDT: ' + CAST((SELECT COUNT(*) FROM DangKyPhongs WHERE TrangThai = 3) AS VARCHAR);
PRINT '- Từ chối TTDT: ' + CAST((SELECT COUNT(*) FROM DangKyPhongs WHERE TrangThai = 4) AS VARCHAR);
PRINT '- Đã hủy: ' + CAST((SELECT COUNT(*) FROM DangKyPhongs WHERE TrangThai = 5) AS VARCHAR);
PRINT '';

PRINT 'THỐNG KÊ THÔNG BÁO:';
PRINT '----------------------------------------';
PRINT '- Tổng số: ' + CAST((SELECT COUNT(*) FROM ThongBaos) AS VARCHAR);
PRINT '- Chưa đọc: ' + CAST((SELECT COUNT(*) FROM ThongBaos WHERE DaDoc = 0) AS VARCHAR);
PRINT '- Đã đọc: ' + CAST((SELECT COUNT(*) FROM ThongBaos WHERE DaDoc = 1) AS VARCHAR);
PRINT '';

PRINT '========================================';
PRINT 'HƯỚNG DẪN TEST:';
PRINT '========================================';
PRINT '1. Đăng nhập với tài khoản "pdt" → Xem badge thông báo (2 chưa đọc)';
PRINT '2. Click vào icon chuông → Xem dropdown 5 thông báo mới nhất';
PRINT '3. Truy cập /ThongBao → Xem danh sách đầy đủ';
PRINT '4. Đăng nhập "gv1" → Tạo đăng ký mới → PDT nhận thông báo';
PRINT '5. Đăng nhập "pdt" → Duyệt đơn → GV nhận thông báo';
PRINT '6. Kiểm tra auto-refresh mỗi 30 giây';
PRINT '';
PRINT 'URL: http://localhost:5199';
PRINT '========================================';
GO
