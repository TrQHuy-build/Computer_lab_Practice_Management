-- =============================================
-- SCRIPT TẠO DỮ LIỆU MẪU ĐẦY ĐỦ CHO KIỂM THỬ
-- Phù hợp với schema database thực tế
-- Ngày tạo: 03/02/2026
-- =============================================

USE QL_PHONG_TH;
GO

-- Xóa dữ liệu cũ (theo thứ tự đúng để tránh lỗi FK)
DELETE FROM ThongBaos;
DELETE FROM MuonBus;
DELETE FROM DangKyPhongs;
DELETE FROM PhongMayPhanMems;
DELETE FROM BaoTriPhongs;
DELETE FROM TemplateDangKys;
DELETE FROM TaiKhoans;
DELETE FROM NhanViens;
DELETE FROM HocPhans;
DELETE FROM PhanMems;
DELETE FROM PhongMays;
DELETE FROM PhongBans;
DELETE FROM VaiTros;
DELETE FROM Quyens;
GO

-- =============================================
-- 1. QUYỀN
-- =============================================
SET IDENTITY_INSERT Quyens ON;
INSERT INTO Quyens (QuyenId, TenQuyen, MoTa) VALUES
(1, N'QuanLyTaiKhoan', N'Quản lý tài khoản người dùng'),
(2, N'QuanLyPhongMay', N'Quản lý phòng máy'),
(3, N'QuanLyHocPhan', N'Quản lý học phần'),
(4, N'QuanLyPhanMem', N'Quản lý phần mềm'),
(5, N'DuyetDangKy', N'Duyệt đăng ký phòng'),
(6, N'DangKyPhong', N'Đăng ký sử dụng phòng'),
(7, N'QuanLyBaoTri', N'Quản lý bảo trì phòng máy'),
(8, N'XemBaoCao', N'Xem báo cáo thống kê'),
(9, N'QuanLyThongBao', N'Quản lý thông báo'),
(10, N'YeuCauCaiDat', N'Yêu cầu cài đặt phần mềm');
SET IDENTITY_INSERT Quyens OFF;
GO

-- =============================================
-- 2. VAI TRÒ
-- =============================================
SET IDENTITY_INSERT VaiTros ON;
INSERT INTO VaiTros (VaiTroId, TenVaiTro, MoTa) VALUES
(1, N'Admin', N'Quản trị viên hệ thống'),
(2, N'QL_TT', N'Quản lý trung tâm'),
(3, N'NV_TT', N'Nhân viên trung tâm'),
(4, N'PDT', N'Phòng đào tạo'),
(5, N'GiaoVien', N'Giảng viên');
SET IDENTITY_INSERT VaiTros OFF;
GO

-- =============================================
-- 3. PHÒNG BAN
-- =============================================
SET IDENTITY_INSERT PhongBans ON;
INSERT INTO PhongBans (PhongBanId, TenPhongBan, MoTa) VALUES
(1, N'Trung tâm Tin học', N'Quản lý phòng máy và hệ thống CNTT'),
(2, N'Phòng Đào tạo', N'Quản lý chương trình đào tạo'),
(3, N'Khoa Công nghệ thông tin', N'Khoa đào tạo ngành CNTT'),
(4, N'Khoa Kinh tế', N'Khoa đào tạo ngành Kinh tế'),
(5, N'Khoa Ngoại ngữ', N'Khoa đào tạo ngành Ngoại ngữ'),
(6, N'Khoa Điện - Điện tử', N'Khoa đào tạo ngành Điện'),
(7, N'Khoa Cơ khí', N'Khoa đào tạo ngành Cơ khí'),
(8, N'Khoa Xây dựng', N'Khoa đào tạo ngành Xây dựng'),
(9, N'Khoa Du lịch', N'Khoa đào tạo ngành Du lịch'),
(10, N'Trung tâm NN-TH', N'Trung tâm đào tạo ngắn hạn');
SET IDENTITY_INSERT PhongBans OFF;
GO

-- =============================================
-- 4. NHÂN VIÊN (50 người)
-- =============================================
SET IDENTITY_INSERT NhanViens ON;
INSERT INTO NhanViens (MaNhanVien, HoTen, SoDienThoai, Email, PhongBanId) VALUES
-- Trung tâm Tin học
(1, N'Nguyễn Văn Admin', N'0901234567', N'admin@university.edu.vn', 1),
(2, N'Trần Thị Quản Lý', N'0901234568', N'quanly.tt@university.edu.vn', 1),
(3, N'Lê Văn Kỹ Thuật', N'0901234569', N'kythuat.tt@university.edu.vn', 1),
(4, N'Phạm Thị Hỗ Trợ', N'0901234570', N'hotro.tt@university.edu.vn', 1),
(5, N'Hoàng Văn Bảo Trì', N'0901234571', N'baotri.tt@university.edu.vn', 1),

-- Phòng Đào tạo
(6, N'Nguyễn Thị Phòng ĐT', N'0902234567', N'pdt1@university.edu.vn', 2),
(7, N'Trần Văn Lịch Học', N'0902234568', N'pdt2@university.edu.vn', 2),
(8, N'Lê Thị Sắp Xếp', N'0902234569', N'pdt3@university.edu.vn', 2),

-- Khoa CNTT - Giảng viên
(9, N'Nguyễn Văn An', N'0903234567', N'nva@university.edu.vn', 3),
(10, N'Trần Thị Bình', N'0903234568', N'ttb@university.edu.vn', 3),
(11, N'Lê Văn Cường', N'0903234569', N'lvc@university.edu.vn', 3),
(12, N'Phạm Thị Dung', N'0903234570', N'ptd@university.edu.vn', 3),
(13, N'Hoàng Văn Em', N'0903234571', N'hve@university.edu.vn', 3),
(14, N'Ngô Thị Phương', N'0903234572', N'ntp@university.edu.vn', 3),
(15, N'Vũ Văn Giang', N'0903234573', N'vvg@university.edu.vn', 3),
(16, N'Đặng Thị Hoa', N'0903234574', N'dth@university.edu.vn', 3),
(17, N'Bùi Văn Hùng', N'0903234575', N'bvh@university.edu.vn', 3),
(18, N'Đỗ Thị Kim', N'0903234576', N'dtk@university.edu.vn', 3),

-- Khoa Kinh tế
(19, N'Nguyễn Văn Lộc', N'0904234567', N'nvl@university.edu.vn', 4),
(20, N'Trần Thị Mai', N'0904234568', N'ttm@university.edu.vn', 4),
(21, N'Lê Văn Nam', N'0904234569', N'lvn@university.edu.vn', 4),
(22, N'Phạm Thị Oanh', N'0904234570', N'pto@university.edu.vn', 4),
(23, N'Hoàng Văn Phú', N'0904234571', N'hvp@university.edu.vn', 4),
(24, N'Ngô Thị Quỳnh', N'0904234572', N'ntq@university.edu.vn', 4),
(25, N'Vũ Văn Sang', N'0904234573', N'vvs@university.edu.vn', 4),
(26, N'Đặng Thị Tâm', N'0904234574', N'dtt@university.edu.vn', 4),

-- Khoa Ngoại ngữ
(27, N'Bùi Văn Uy', N'0905234567', N'bvu@university.edu.vn', 5),
(28, N'Đỗ Thị Vân', N'0905234568', N'dtv@university.edu.vn', 5),
(29, N'Nguyễn Văn Xuân', N'0905234569', N'nvx@university.edu.vn', 5),
(30, N'Trần Thị Yến', N'0905234570', N'tty@university.edu.vn', 5),
(31, N'Lê Văn Zung', N'0905234571', N'lvz@university.edu.vn', 5),
(32, N'Phạm Thị Ánh', N'0905234572', N'pta@university.edu.vn', 5),

-- Khoa Điện - Điện tử
(33, N'Hoàng Văn Bảo', N'0906234567', N'hvb@university.edu.vn', 6),
(34, N'Ngô Thị Châu', N'0906234568', N'ntc@university.edu.vn', 6),
(35, N'Vũ Văn Đạt', N'0906234569', N'vvd@university.edu.vn', 6),
(36, N'Đặng Thị Êm', N'0906234570', N'dte@university.edu.vn', 6),
(37, N'Bùi Văn Phong', N'0906234571', N'bvp@university.edu.vn', 6),
(38, N'Đỗ Thị Giang', N'0906234572', N'dtg@university.edu.vn', 6),

-- Khoa Cơ khí
(39, N'Nguyễn Văn Hải', N'0907234567', N'nvh@university.edu.vn', 7),
(40, N'Trần Thị Ích', N'0907234568', N'tti@university.edu.vn', 7),
(41, N'Lê Văn Khánh', N'0907234569', N'lvk@university.edu.vn', 7),
(42, N'Phạm Thị Lan', N'0907234570', N'ptl@university.edu.vn', 7),
(43, N'Hoàng Văn Minh', N'0907234571', N'hvm@university.edu.vn', 7),

-- Khoa Xây dựng
(44, N'Ngô Thị Ngọc', N'0908234567', N'ntn@university.edu.vn', 8),
(45, N'Vũ Văn Ơn', N'0908234568', N'vvo@university.edu.vn', 8),
(46, N'Đặng Thị Phượng', N'0908234569', N'dtp@university.edu.vn', 8),
(47, N'Bùi Văn Quân', N'0908234570', N'bvq@university.edu.vn', 8),

-- Khoa Du lịch
(48, N'Đỗ Thị Rồng', N'0909234567', N'dtr@university.edu.vn', 9),
(49, N'Nguyễn Văn Sơn', N'0909234568', N'nvs@university.edu.vn', 9),
(50, N'Trần Thị Thương', N'0909234569', N'ttt@university.edu.vn', 9);
SET IDENTITY_INSERT NhanViens OFF;
GO

-- =============================================
-- 5. TÀI KHOẢN (50 tài khoản)
-- =============================================
SET IDENTITY_INSERT TaiKhoans ON;
INSERT INTO TaiKhoans (TaiKhoanId, TenDangNhap, MatKhau, MaNhanVien, VaiTroId, NgayTao) VALUES
-- Admin & Quản lý TT
(1, N'admin', N'123456', 1, 1, GETDATE()),
(2, N'quanly.tt', N'123456', 2, 2, GETDATE()),
(3, N'kythuat.tt', N'123456', 3, 3, GETDATE()),
(4, N'hotro.tt', N'123456', 4, 3, GETDATE()),
(5, N'baotri.tt', N'123456', 5, 3, GETDATE()),

-- Phòng Đào tạo
(6, N'pdt1', N'123456', 6, 4, GETDATE()),
(7, N'pdt2', N'123456', 7, 4, GETDATE()),
(8, N'pdt3', N'123456', 8, 4, GETDATE()),

-- Giảng viên Khoa CNTT
(9, N'gv.nva', N'123456', 9, 5, GETDATE()),
(10, N'gv.ttb', N'123456', 10, 5, GETDATE()),
(11, N'gv.lvc', N'123456', 11, 5, GETDATE()),
(12, N'gv.ptd', N'123456', 12, 5, GETDATE()),
(13, N'gv.hve', N'123456', 13, 5, GETDATE()),
(14, N'gv.ntp', N'123456', 14, 5, GETDATE()),
(15, N'gv.vvg', N'123456', 15, 5, GETDATE()),
(16, N'gv.dth', N'123456', 16, 5, GETDATE()),
(17, N'gv.bvh', N'123456', 17, 5, GETDATE()),
(18, N'gv.dtk', N'123456', 18, 5, GETDATE()),

-- Giảng viên Khoa Kinh tế
(19, N'gv.nvl', N'123456', 19, 5, GETDATE()),
(20, N'gv.ttm', N'123456', 20, 5, GETDATE()),
(21, N'gv.lvn', N'123456', 21, 5, GETDATE()),
(22, N'gv.pto', N'123456', 22, 5, GETDATE()),
(23, N'gv.hvp', N'123456', 23, 5, GETDATE()),
(24, N'gv.ntq', N'123456', 24, 5, GETDATE()),
(25, N'gv.vvs', N'123456', 25, 5, GETDATE()),
(26, N'gv.dtt', N'123456', 26, 5, GETDATE()),

-- Giảng viên Khoa Ngoại ngữ
(27, N'gv.bvu', N'123456', 27, 5, GETDATE()),
(28, N'gv.dtv', N'123456', 28, 5, GETDATE()),
(29, N'gv.nvx', N'123456', 29, 5, GETDATE()),
(30, N'gv.tty', N'123456', 30, 5, GETDATE()),
(31, N'gv.lvz', N'123456', 31, 5, GETDATE()),
(32, N'gv.pta', N'123456', 32, 5, GETDATE()),

-- Giảng viên Khoa Điện
(33, N'gv.hvb', N'123456', 33, 5, GETDATE()),
(34, N'gv.ntc', N'123456', 34, 5, GETDATE()),
(35, N'gv.vvd', N'123456', 35, 5, GETDATE()),
(36, N'gv.dte', N'123456', 36, 5, GETDATE()),
(37, N'gv.bvp', N'123456', 37, 5, GETDATE()),
(38, N'gv.dtg', N'123456', 38, 5, GETDATE()),

-- Giảng viên Khoa Cơ khí
(39, N'gv.nvh', N'123456', 39, 5, GETDATE()),
(40, N'gv.tti', N'123456', 40, 5, GETDATE()),
(41, N'gv.lvk', N'123456', 41, 5, GETDATE()),
(42, N'gv.ptl', N'123456', 42, 5, GETDATE()),
(43, N'gv.hvm', N'123456', 43, 5, GETDATE()),

-- Giảng viên Khoa Xây dựng
(44, N'gv.ntn', N'123456', 44, 5, GETDATE()),
(45, N'gv.vvo', N'123456', 45, 5, GETDATE()),
(46, N'gv.dtp', N'123456', 46, 5, GETDATE()),
(47, N'gv.bvq', N'123456', 47, 5, GETDATE()),

-- Giảng viên Khoa Du lịch
(48, N'gv.dtr', N'123456', 48, 5, GETDATE()),
(49, N'gv.nvs', N'123456', 49, 5, GETDATE()),
(50, N'gv.ttt', N'123456', 50, 5, GETDATE());
SET IDENTITY_INSERT TaiKhoans OFF;
GO

-- =============================================
-- 6. PHÒNG MÁY (15 phòng) - Sử dụng đúng schema
-- =============================================
SET IDENTITY_INSERT PhongMays ON;
INSERT INTO PhongMays (PhongMayId, MaPhong, TenPhong, SoLuongMay, SoMayHong, ViTri, TrangThai, GhiChu, TrangThaiDuyet, NgayTao, NguoiTaoId) VALUES
(1, N'PM-A101', N'Phòng máy A101', 40, 0, N'Tòa A, Tầng 1', 1, N'Phòng máy chung, cấu hình cao', 1, GETDATE(), 1),
(2, N'PM-A102', N'Phòng máy A102', 35, 2, N'Tòa A, Tầng 1', 1, N'Phòng máy chung, cấu hình trung bình', 1, GETDATE(), 1),
(3, N'PM-A201', N'Phòng máy CNTT 1', 40, 0, N'Tòa A, Tầng 2', 1, N'Phòng máy CNTT chuyên dụng', 1, GETDATE(), 1),
(4, N'PM-A202', N'Phòng máy CNTT 2', 40, 1, N'Tòa A, Tầng 2', 1, N'Phòng máy CNTT chuyên dụng', 1, GETDATE(), 1),
(5, N'PM-A203', N'Phòng máy mạng', 35, 0, N'Tòa A, Tầng 2', 1, N'Phòng máy mạng và bảo mật', 1, GETDATE(), 1),
(6, N'PM-A301', N'Phòng máy đồ họa', 30, 0, N'Tòa A, Tầng 3', 1, N'Phòng máy đồ họa', 1, GETDATE(), 1),
(7, N'PM-A302', N'Phòng multimedia', 30, 1, N'Tòa A, Tầng 3', 1, N'Phòng máy multimedia', 1, GETDATE(), 1),
(8, N'PM-B101', N'Phòng máy kinh tế 1', 45, 0, N'Tòa B, Tầng 1', 1, N'Phòng máy kinh tế', 1, GETDATE(), 1),
(9, N'PM-B102', N'Phòng máy kinh tế 2', 45, 2, N'Tòa B, Tầng 1', 1, N'Phòng máy kinh tế', 1, GETDATE(), 1),
(10, N'PM-B201', N'Phòng máy ngoại ngữ 1', 40, 0, N'Tòa B, Tầng 2', 1, N'Phòng máy ngoại ngữ', 1, GETDATE(), 1),
(11, N'PM-B202', N'Phòng máy ngoại ngữ 2', 40, 0, N'Tòa B, Tầng 2', 1, N'Phòng máy ngoại ngữ', 1, GETDATE(), 1),
(12, N'PM-C101', N'Phòng máy kỹ thuật 1', 35, 0, N'Tòa C, Tầng 1', 1, N'Phòng máy kỹ thuật', 1, GETDATE(), 1),
(13, N'PM-C102', N'Phòng máy kỹ thuật 2', 35, 1, N'Tòa C, Tầng 1', 1, N'Phòng máy kỹ thuật', 1, GETDATE(), 1),
(14, N'PM-C201', N'Phòng máy AutoCAD', 30, 0, N'Tòa C, Tầng 2', 1, N'Phòng máy AutoCAD', 1, GETDATE(), 1),
(15, N'PM-TEST', N'Phòng thử nghiệm', 25, 5, N'Tòa C, Tầng 2', 0, N'Phòng máy thử nghiệm - Chờ duyệt', 0, GETDATE(), 1);
SET IDENTITY_INSERT PhongMays OFF;
GO

-- =============================================
-- 7. PHẦN MỀM (30 phần mềm) - Sử dụng đúng schema
-- =============================================
SET IDENTITY_INSERT PhanMems ON;
INSERT INTO PhanMems (PhanMemId, TenPhanMem, PhienBan, NhaSanXuat, MoTa, TrangThai) VALUES
-- Phần mềm văn phòng
(1, N'Microsoft Office 365', N'2024', N'Microsoft', N'Bộ ứng dụng văn phòng', 1),
(2, N'LibreOffice', N'7.6', N'Document Foundation', N'Bộ ứng dụng văn phòng mã nguồn mở', 1),
(3, N'Adobe Acrobat Pro', N'2024', N'Adobe', N'Phần mềm xử lý PDF', 1),

-- IDE & Development
(4, N'Visual Studio 2022', N'17.8', N'Microsoft', N'IDE phát triển ứng dụng', 1),
(5, N'Visual Studio Code', N'1.85', N'Microsoft', N'Code editor đa năng', 1),
(6, N'IntelliJ IDEA', N'2024.1', N'JetBrains', N'IDE Java/Kotlin', 1),
(7, N'PyCharm', N'2024.1', N'JetBrains', N'IDE Python', 1),
(8, N'Eclipse IDE', N'2024-03', N'Eclipse Foundation', N'IDE Java', 1),
(9, N'Android Studio', N'2024.1', N'Google', N'IDE phát triển Android', 1),
(10, N'Xcode', N'15.2', N'Apple', N'IDE phát triển iOS/macOS', 1),

-- Database
(11, N'SQL Server Management Studio', N'19.2', N'Microsoft', N'Quản lý SQL Server', 1),
(12, N'MySQL Workbench', N'8.0', N'Oracle', N'Quản lý MySQL', 1),
(13, N'pgAdmin', N'7.8', N'PostgreSQL', N'Quản lý PostgreSQL', 1),
(14, N'MongoDB Compass', N'1.42', N'MongoDB', N'Quản lý MongoDB', 1),

-- Đồ họa & Multimedia
(15, N'Adobe Photoshop', N'2024', N'Adobe', N'Xử lý ảnh chuyên nghiệp', 1),
(16, N'Adobe Illustrator', N'2024', N'Adobe', N'Thiết kế vector', 1),
(17, N'Adobe Premiere Pro', N'2024', N'Adobe', N'Chỉnh sửa video', 1),
(18, N'Figma', N'2024', N'Figma', N'Thiết kế UI/UX', 1),
(19, N'Blender', N'4.0', N'Blender Foundation', N'Đồ họa 3D', 1),
(20, N'CorelDRAW', N'2024', N'Corel', N'Thiết kế đồ họa', 1),

-- CAD & Engineering
(21, N'AutoCAD', N'2024', N'Autodesk', N'Phần mềm CAD', 1),
(22, N'SolidWorks', N'2024', N'Dassault', N'Thiết kế 3D cơ khí', 1),
(23, N'MATLAB', N'R2024a', N'MathWorks', N'Tính toán kỹ thuật', 1),
(24, N'Proteus', N'8.16', N'Labcenter', N'Mô phỏng mạch điện', 1),

-- Mạng & Bảo mật
(25, N'Cisco Packet Tracer', N'8.2', N'Cisco', N'Mô phỏng mạng', 1),
(26, N'Wireshark', N'4.2', N'Wireshark Foundation', N'Phân tích gói tin mạng', 1),
(27, N'VMware Workstation', N'17', N'VMware', N'Máy ảo', 1),
(28, N'VirtualBox', N'7.0', N'Oracle', N'Máy ảo mã nguồn mở', 1),

-- Ngôn ngữ & Framework
(29, N'Node.js', N'20 LTS', N'OpenJS Foundation', N'Runtime JavaScript', 1),
(30, N'Python', N'3.12', N'Python Software Foundation', N'Ngôn ngữ lập trình Python', 1);
SET IDENTITY_INSERT PhanMems OFF;
GO

-- =============================================
-- 8. PHÒNG MÁY - PHẦN MỀM (Mapping)
-- =============================================
INSERT INTO PhongMayPhanMems (PhongMayId, PhanMemId, NgayCaiDat) VALUES
-- PM-A101, A102
(1, 1, GETDATE()), (1, 4, GETDATE()), (1, 5, GETDATE()), (1, 11, GETDATE()), (1, 29, GETDATE()), (1, 30, GETDATE()),
(2, 1, GETDATE()), (2, 5, GETDATE()), (2, 11, GETDATE()), (2, 29, GETDATE()), (2, 30, GETDATE()),

-- PM-A201, A202, A203
(3, 1, GETDATE()), (3, 4, GETDATE()), (3, 5, GETDATE()), (3, 6, GETDATE()), (3, 7, GETDATE()), (3, 11, GETDATE()), (3, 12, GETDATE()), (3, 29, GETDATE()), (3, 30, GETDATE()),
(4, 1, GETDATE()), (4, 4, GETDATE()), (4, 5, GETDATE()), (4, 6, GETDATE()), (4, 7, GETDATE()), (4, 11, GETDATE()), (4, 12, GETDATE()), (4, 29, GETDATE()), (4, 30, GETDATE()),
(5, 1, GETDATE()), (5, 5, GETDATE()), (5, 25, GETDATE()), (5, 26, GETDATE()), (5, 27, GETDATE()), (5, 28, GETDATE()),

-- PM-A301, A302
(6, 1, GETDATE()), (6, 3, GETDATE()), (6, 15, GETDATE()), (6, 16, GETDATE()), (6, 18, GETDATE()), (6, 19, GETDATE()), (6, 20, GETDATE()),
(7, 1, GETDATE()), (7, 3, GETDATE()), (7, 15, GETDATE()), (7, 16, GETDATE()), (7, 17, GETDATE()), (7, 18, GETDATE()), (7, 19, GETDATE()),

-- PM-B101, B102
(8, 1, GETDATE()), (8, 3, GETDATE()), (8, 5, GETDATE()), (8, 11, GETDATE()),
(9, 1, GETDATE()), (9, 3, GETDATE()), (9, 5, GETDATE()), (9, 11, GETDATE()),

-- PM-B201, B202
(10, 1, GETDATE()), (10, 3, GETDATE()), (10, 5, GETDATE()),
(11, 1, GETDATE()), (11, 3, GETDATE()), (11, 5, GETDATE()),

-- PM-C101, C102, C201
(12, 1, GETDATE()), (12, 5, GETDATE()), (12, 23, GETDATE()), (12, 24, GETDATE()), (12, 27, GETDATE()),
(13, 1, GETDATE()), (13, 5, GETDATE()), (13, 23, GETDATE()), (13, 24, GETDATE()), (13, 27, GETDATE()),
(14, 1, GETDATE()), (14, 5, GETDATE()), (14, 21, GETDATE()), (14, 22, GETDATE()), (14, 23, GETDATE());
GO

-- =============================================
-- 9. HỌC PHẦN (40 học phần)
-- =============================================
SET IDENTITY_INSERT HocPhans ON;
INSERT INTO HocPhans (HocPhanId, MaHocPhan, TenHocPhan, SoTinChi, MoTa, TrangThaiHoatDong) VALUES
-- Khoa CNTT
(1, N'IT101', N'Nhập môn lập trình', 3, N'Học phần cơ bản về lập trình', 1),
(2, N'IT102', N'Cấu trúc dữ liệu và giải thuật', 4, N'Học về CTDL và các thuật toán', 1),
(3, N'IT103', N'Lập trình hướng đối tượng', 3, N'Học về OOP', 1),
(4, N'IT201', N'Cơ sở dữ liệu', 4, N'Học về thiết kế và quản trị CSDL', 1),
(5, N'IT202', N'Mạng máy tính', 3, N'Học về mạng và truyền thông', 1),
(6, N'IT203', N'Hệ điều hành', 3, N'Học về nguyên lý hệ điều hành', 1),
(7, N'IT301', N'Phát triển ứng dụng Web', 4, N'Lập trình Web frontend & backend', 1),
(8, N'IT302', N'Phát triển ứng dụng di động', 3, N'Lập trình Android/iOS', 1),
(9, N'IT303', N'An toàn thông tin', 3, N'Bảo mật hệ thống và ứng dụng', 1),
(10, N'IT401', N'Trí tuệ nhân tạo', 4, N'Machine Learning và AI', 1),
(11, N'IT402', N'Điện toán đám mây', 3, N'Cloud Computing', 1),
(12, N'IT403', N'Big Data', 3, N'Xử lý dữ liệu lớn', 1),

-- Khoa Kinh tế
(13, N'KT101', N'Tin học văn phòng', 2, N'Sử dụng MS Office', 1),
(14, N'KT102', N'Tin học ứng dụng trong kinh doanh', 3, N'Excel nâng cao, Power BI', 1),
(15, N'KT201', N'Phần mềm kế toán', 3, N'Sử dụng phần mềm kế toán', 1),
(16, N'KT202', N'Thương mại điện tử', 3, N'E-commerce cơ bản', 1),
(17, N'KT301', N'Hệ thống thông tin quản lý', 3, N'MIS', 1),
(18, N'KT302', N'Phân tích dữ liệu kinh doanh', 3, N'Business Analytics', 1),

-- Khoa Ngoại ngữ
(19, N'NN101', N'Tiếng Anh thực hành 1', 3, N'Nghe nói cơ bản', 1),
(20, N'NN102', N'Tiếng Anh thực hành 2', 3, N'Nghe nói trung cấp', 1),
(21, N'NN201', N'Tiếng Anh thương mại', 3, N'Business English', 1),
(22, N'NN202', N'Tiếng Anh CNTT', 3, N'English for IT', 1),
(23, N'NN301', N'Phiên dịch có máy hỗ trợ', 3, N'CAT Tools', 1),
(24, N'NN302', N'Tiếng Nhật cơ bản', 3, N'Japanese N5', 1),

-- Khoa Điện - Điện tử
(25, N'DT101', N'Mạch điện tử cơ bản', 3, N'Điện tử analog', 1),
(26, N'DT102', N'Mạch số', 3, N'Digital circuits', 1),
(27, N'DT201', N'Vi xử lý và vi điều khiển', 4, N'Microprocessor & MCU', 1),
(28, N'DT202', N'Thiết kế mạch in', 3, N'PCB Design', 1),
(29, N'DT301', N'Hệ thống nhúng', 4, N'Embedded Systems', 1),
(30, N'DT302', N'IoT và ứng dụng', 3, N'Internet of Things', 1),

-- Khoa Cơ khí
(31, N'CK101', N'Vẽ kỹ thuật', 3, N'Vẽ kỹ thuật cơ bản', 1),
(32, N'CK102', N'AutoCAD 2D', 3, N'Vẽ AutoCAD 2D', 1),
(33, N'CK201', N'AutoCAD 3D', 3, N'Thiết kế 3D với AutoCAD', 1),
(34, N'CK202', N'SolidWorks cơ bản', 3, N'Thiết kế 3D với SolidWorks', 1),
(35, N'CK301', N'CAD/CAM', 4, N'Gia công CNC', 1),
(36, N'CK302', N'Mô phỏng kỹ thuật', 3, N'Engineering Simulation', 1),

-- Khoa Xây dựng
(37, N'XD101', N'Vẽ kỹ thuật xây dựng', 3, N'Bản vẽ xây dựng', 1),
(38, N'XD201', N'AutoCAD kiến trúc', 3, N'AutoCAD cho kiến trúc', 1),
(39, N'XD301', N'Revit Architecture', 4, N'BIM với Revit', 1),
(40, N'XD302', N'Dự toán công trình', 3, N'Phần mềm dự toán', 1);
SET IDENTITY_INSERT HocPhans OFF;
GO

-- =============================================
-- 10. BẢO TRÌ PHÒNG MÁY (Sử dụng đúng schema)
-- =============================================
SET IDENTITY_INSERT BaoTriPhongs ON;
INSERT INTO BaoTriPhongs (BaoTriId, PhongMayId, NoiDung, MoTaSuCo, SoMayHong, ChiTietThietBiHong, TrangThai, MucDoUuTien, NgayBaoCao, NguoiBaoCaoId, NgayXuLy, NguoiXuLyId, KetQuaXuLy) VALUES
-- Bảo trì đã hoàn thành
(1, 1, N'Bảo trì định kỳ - Cài đặt lại hệ thống', N'Hệ thống chạy chậm', 0, NULL, 2, 1, DATEADD(day, -30, GETDATE()), 3, DATEADD(day, -28, GETDATE()), 3, N'Hoàn thành'),
(2, 2, N'Thay thế 5 bộ nguồn', N'Nguồn bị hỏng', 5, N'Nguồn máy 5,10,15,20,25', 2, 2, DATEADD(day, -28, GETDATE()), 4, DATEADD(day, -25, GETDATE()), 3, N'Đã thay thế'),
(3, 3, N'Nâng cấp RAM lên 16GB', N'RAM không đủ', 0, NULL, 2, 1, DATEADD(day, -25, GETDATE()), 5, DATEADD(day, -22, GETDATE()), 4, N'Đã nâng cấp 40 máy'),
(4, 4, N'Cài đặt Visual Studio 2022', N'Cần cập nhật phần mềm', 0, NULL, 2, 0, DATEADD(day, -20, GETDATE()), 3, DATEADD(day, -18, GETDATE()), 3, N'Đã cài đặt'),
(5, 5, N'Cấu hình lại switch mạng', N'Mạng không ổn định', 0, NULL, 2, 2, DATEADD(day, -15, GETDATE()), 4, DATEADD(day, -12, GETDATE()), 4, N'Đã tối ưu VLAN'),
(6, 6, N'Cài Adobe Creative Suite', N'Cần cài phần mềm mới', 0, NULL, 2, 1, DATEADD(day, -10, GETDATE()), 5, DATEADD(day, -7, GETDATE()), 3, N'Đã cài đặt bộ Adobe'),
(7, 7, N'Sửa chữa 3 máy bị hỏng ổ cứng', N'Ổ cứng bad sector', 3, N'Máy 8,12,20', 2, 2, DATEADD(day, -7, GETDATE()), 3, DATEADD(day, -5, GETDATE()), 5, N'Đã thay SSD mới'),

-- Bảo trì đang thực hiện
(8, 8, N'Bảo trì định kỳ tháng 2', N'Bảo trì theo lịch', 0, NULL, 1, 1, GETDATE(), 4, NULL, 3, NULL),
(9, 9, N'Cập nhật Windows và Office', N'Cần bản vá bảo mật', 0, NULL, 1, 2, GETDATE(), 5, NULL, 4, NULL),
(10, 10, N'Kiểm tra headphone và microphone', N'Thiết bị âm thanh lỗi', 5, N'Máy 1,5,10,15,20', 0, 1, DATEADD(day, 1, GETDATE()), 3, NULL, NULL, NULL),

-- Bảo trì sắp tới
(11, 11, N'Bảo trì định kỳ', N'Theo lịch', 0, NULL, 0, 0, DATEADD(day, 3, GETDATE()), 4, NULL, NULL, NULL),
(12, 12, N'Cài đặt MATLAB mới', N'Cần phiên bản mới', 0, NULL, 0, 1, DATEADD(day, 5, GETDATE()), 5, NULL, NULL, NULL),
(13, 13, N'Nâng cấp Proteus', N'Phiên bản cũ', 0, NULL, 0, 0, DATEADD(day, 7, GETDATE()), 3, NULL, NULL, NULL),
(14, 14, N'Cài AutoCAD 2025', N'Cần version mới', 0, NULL, 0, 1, DATEADD(day, 10, GETDATE()), 4, NULL, NULL, NULL),
(15, 1, N'Bảo trì định kỳ quý 1', N'Bảo trì theo quý', 0, NULL, 0, 0, DATEADD(day, 14, GETDATE()), 5, NULL, NULL, NULL);
SET IDENTITY_INSERT BaoTriPhongs OFF;
GO

-- =============================================
-- 11. ĐĂNG KÝ PHÒNG (100 đăng ký - schema thực tế)
-- =============================================
SET IDENTITY_INSERT DangKyPhongs ON;

-- Các đăng ký đã hoàn thành (trong quá khứ) - TrangThai = 5 (TTDTDongY)
INSERT INTO DangKyPhongs (DangKyPhongId, HocPhanId, PhongMayId, GiaoVienId, NgayDangKy, NgayBatDau, NgayKetThuc, GioBatDau, GioKetThuc, SoLuongSinhVien, MucDoUuTien, TrangThai, GhiChu, ThuTrongTuan, NguoiDuyetPDTId, NgayDuyetPDT, NguoiDuyetTTDTId, NgayDuyetTTDT) VALUES
-- Tuần trước - Đã duyệt hoàn tất
(1, 1, 3, 9, DATEADD(day, -14, GETDATE()), DATEADD(day, -7, GETDATE()), DATEADD(day, -7, GETDATE()), 7, 9, 35, 0, 5, N'Thực hành C++', 2, 6, DATEADD(day, -13, GETDATE()), 2, DATEADD(day, -12, GETDATE())),
(2, 2, 3, 10, DATEADD(day, -14, GETDATE()), DATEADD(day, -7, GETDATE()), DATEADD(day, -7, GETDATE()), 9, 11, 38, 0, 5, N'Thực hành CTDL', 2, 6, DATEADD(day, -13, GETDATE()), 2, DATEADD(day, -12, GETDATE())),
(3, 3, 4, 11, DATEADD(day, -13, GETDATE()), DATEADD(day, -6, GETDATE()), DATEADD(day, -6, GETDATE()), 7, 9, 40, 0, 5, N'Thực hành Java OOP', 3, 7, DATEADD(day, -12, GETDATE()), 2, DATEADD(day, -11, GETDATE())),
(4, 4, 4, 12, DATEADD(day, -13, GETDATE()), DATEADD(day, -6, GETDATE()), DATEADD(day, -6, GETDATE()), 9, 11, 35, 0, 5, N'Thực hành SQL Server', 3, 7, DATEADD(day, -12, GETDATE()), 2, DATEADD(day, -11, GETDATE())),
(5, 5, 5, 13, DATEADD(day, -12, GETDATE()), DATEADD(day, -5, GETDATE()), DATEADD(day, -5, GETDATE()), 7, 9, 30, 0, 5, N'Thực hành Cisco', 4, 6, DATEADD(day, -11, GETDATE()), 3, DATEADD(day, -10, GETDATE())),
(6, 13, 8, 19, DATEADD(day, -12, GETDATE()), DATEADD(day, -5, GETDATE()), DATEADD(day, -5, GETDATE()), 9, 11, 42, 0, 5, N'Thực hành Word, Excel', 4, 6, DATEADD(day, -11, GETDATE()), 3, DATEADD(day, -10, GETDATE())),
(7, 14, 8, 20, DATEADD(day, -11, GETDATE()), DATEADD(day, -4, GETDATE()), DATEADD(day, -4, GETDATE()), 7, 9, 40, 0, 5, N'Thực hành Excel nâng cao', 5, 7, DATEADD(day, -10, GETDATE()), 2, DATEADD(day, -9, GETDATE())),
(8, 19, 10, 27, DATEADD(day, -11, GETDATE()), DATEADD(day, -4, GETDATE()), DATEADD(day, -4, GETDATE()), 9, 11, 38, 0, 5, N'Luyện nghe nói', 5, 7, DATEADD(day, -10, GETDATE()), 2, DATEADD(day, -9, GETDATE())),
(9, 25, 12, 33, DATEADD(day, -10, GETDATE()), DATEADD(day, -3, GETDATE()), DATEADD(day, -3, GETDATE()), 7, 9, 32, 0, 5, N'Thực hành mạch', 6, 6, DATEADD(day, -9, GETDATE()), 3, DATEADD(day, -8, GETDATE())),
(10, 31, 14, 39, DATEADD(day, -10, GETDATE()), DATEADD(day, -3, GETDATE()), DATEADD(day, -3, GETDATE()), 9, 11, 28, 0, 5, N'Vẽ kỹ thuật', 6, 6, DATEADD(day, -9, GETDATE()), 3, DATEADD(day, -8, GETDATE())),

-- Đăng ký đang chờ PDT duyệt - TrangThai = 0 (ChoDuyetPDT)
(11, 1, 3, 9, GETDATE(), DATEADD(day, 3, GETDATE()), DATEADD(day, 3, GETDATE()), 7, 9, 35, 0, 0, N'Thực hành C++ - Nhóm 1', 2, NULL, NULL, NULL, NULL),
(12, 1, 3, 9, GETDATE(), DATEADD(day, 3, GETDATE()), DATEADD(day, 3, GETDATE()), 9, 11, 35, 0, 0, N'Thực hành C++ - Nhóm 2', 2, NULL, NULL, NULL, NULL),
(13, 2, 4, 10, GETDATE(), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 7, 9, 38, 0, 0, N'Thực hành CTDL', 3, NULL, NULL, NULL, NULL),
(14, 3, 4, 11, GETDATE(), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 9, 11, 40, 0, 0, N'Thực hành Java', 3, NULL, NULL, NULL, NULL),
(15, 4, 3, 12, GETDATE(), DATEADD(day, 5, GETDATE()), DATEADD(day, 5, GETDATE()), 7, 9, 35, 0, 0, N'Lab SQL Server', 4, NULL, NULL, NULL, NULL),
(16, 5, 5, 13, GETDATE(), DATEADD(day, 5, GETDATE()), DATEADD(day, 5, GETDATE()), 9, 11, 30, 0, 0, N'Lab mạng Cisco', 4, NULL, NULL, NULL, NULL),
(17, 6, 4, 14, GETDATE(), DATEADD(day, 6, GETDATE()), DATEADD(day, 6, GETDATE()), 7, 9, 38, 0, 0, N'Lab hệ điều hành', 5, NULL, NULL, NULL, NULL),
(18, 7, 3, 15, GETDATE(), DATEADD(day, 6, GETDATE()), DATEADD(day, 6, GETDATE()), 9, 11, 35, 1, 0, N'Lab Web ASP.NET - Khẩn cấp', 5, NULL, NULL, NULL, NULL),
(19, 8, 4, 16, GETDATE(), DATEADD(day, 7, GETDATE()), DATEADD(day, 7, GETDATE()), 7, 9, 40, 0, 0, N'Lab Android Studio', 6, NULL, NULL, NULL, NULL),
(20, 9, 5, 17, GETDATE(), DATEADD(day, 7, GETDATE()), DATEADD(day, 7, GETDATE()), 9, 11, 28, 2, 0, N'Lab bảo mật - Kiểm tra', 6, NULL, NULL, NULL, NULL),

-- Đăng ký chờ TTDT duyệt (PDT đã duyệt) - TrangThai = 3 (ChoDuyetTTDT)
(21, 10, 3, 18, DATEADD(day, -2, GETDATE()), DATEADD(day, 5, GETDATE()), DATEADD(day, 5, GETDATE()), 7, 9, 35, 0, 3, N'Lab Machine Learning', 4, 6, DATEADD(day, -1, GETDATE()), NULL, NULL),
(22, 11, 4, 9, DATEADD(day, -2, GETDATE()), DATEADD(day, 5, GETDATE()), DATEADD(day, 5, GETDATE()), 9, 11, 38, 0, 3, N'Lab Cloud Computing', 4, 6, DATEADD(day, -1, GETDATE()), NULL, NULL),
(23, 12, 3, 10, DATEADD(day, -2, GETDATE()), DATEADD(day, 6, GETDATE()), DATEADD(day, 6, GETDATE()), 7, 9, 40, 0, 3, N'Lab Big Data', 5, 7, DATEADD(day, -1, GETDATE()), NULL, NULL),
(24, 13, 8, 21, DATEADD(day, -1, GETDATE()), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 7, 9, 45, 0, 3, N'Tin học văn phòng K22', 2, 6, GETDATE(), NULL, NULL),
(25, 14, 9, 22, DATEADD(day, -1, GETDATE()), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 9, 11, 42, 0, 3, N'Excel nâng cao K21', 2, 6, GETDATE(), NULL, NULL),
(26, 15, 8, 23, DATEADD(day, -1, GETDATE()), DATEADD(day, 5, GETDATE()), DATEADD(day, 5, GETDATE()), 7, 9, 40, 0, 3, N'Phần mềm kế toán', 3, 7, GETDATE(), NULL, NULL),
(27, 16, 9, 24, DATEADD(day, -1, GETDATE()), DATEADD(day, 5, GETDATE()), DATEADD(day, 5, GETDATE()), 9, 11, 38, 0, 3, N'Thương mại điện tử', 3, 7, GETDATE(), NULL, NULL),
(28, 19, 10, 28, DATEADD(day, -1, GETDATE()), DATEADD(day, 3, GETDATE()), DATEADD(day, 3, GETDATE()), 7, 9, 38, 0, 3, N'English Practice 1', 2, 6, GETDATE(), NULL, NULL),
(29, 20, 11, 29, DATEADD(day, -1, GETDATE()), DATEADD(day, 3, GETDATE()), DATEADD(day, 3, GETDATE()), 9, 11, 40, 0, 3, N'English Practice 2', 2, 6, GETDATE(), NULL, NULL),
(30, 21, 10, 30, DATEADD(day, -1, GETDATE()), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 7, 9, 35, 0, 3, N'Business English', 3, 7, GETDATE(), NULL, NULL),

-- PDT đã từ chối - TrangThai = 1 (PDTTuChoi)
(31, 7, 1, 15, DATEADD(day, -5, GETDATE()), DATEADD(day, 2, GETDATE()), DATEADD(day, 2, GETDATE()), 7, 9, 50, 0, 1, N'Web Lab - Quá đông', 2, 6, DATEADD(day, -4, GETDATE()), NULL, NULL),
(32, 8, 2, 16, DATEADD(day, -4, GETDATE()), DATEADD(day, 1, GETDATE()), DATEADD(day, 1, GETDATE()), 9, 11, 45, 0, 1, N'Mobile Lab - Trùng lịch bảo trì', 3, 7, DATEADD(day, -3, GETDATE()), NULL, NULL),

-- TTDT đã từ chối - TrangThai = 4 (TTDTTuChoi)
(33, 9, 5, 17, DATEADD(day, -6, GETDATE()), DATEADD(day, 1, GETDATE()), DATEADD(day, 1, GETDATE()), 7, 9, 30, 0, 4, N'Security Lab - Thiếu phần mềm', 4, 6, DATEADD(day, -5, GETDATE()), 2, DATEADD(day, -4, GETDATE())),
(34, 10, 3, 18, DATEADD(day, -5, GETDATE()), DATEADD(day, 2, GETDATE()), DATEADD(day, 2, GETDATE()), 9, 11, 35, 0, 4, N'AI Lab - Không đủ GPU', 5, 7, DATEADD(day, -4, GETDATE()), 3, DATEADD(day, -3, GETDATE())),

-- Đã hủy - TrangThai = 6 (DaHuy)
(35, 11, 4, 9, DATEADD(day, -7, GETDATE()), DATEADD(day, -1, GETDATE()), DATEADD(day, -1, GETDATE()), 7, 9, 38, 0, 6, N'Cloud Lab - GV nghỉ phép', 2, 6, DATEADD(day, -6, GETDATE()), 2, DATEADD(day, -5, GETDATE())),
(36, 12, 3, 10, DATEADD(day, -8, GETDATE()), DATEADD(day, -2, GETDATE()), DATEADD(day, -2, GETDATE()), 9, 11, 40, 0, 6, N'Big Data Lab - SV bận thi', 3, 7, DATEADD(day, -7, GETDATE()), 3, DATEADD(day, -6, GETDATE())),

-- Đã được TTDT duyệt (sắp diễn ra) - TrangThai = 5 (TTDTDongY)
(37, 1, 3, 9, DATEADD(day, -3, GETDATE()), DATEADD(day, 1, GETDATE()), DATEADD(day, 1, GETDATE()), 7, 9, 35, 0, 5, N'C++ Basics', 2, 6, DATEADD(day, -2, GETDATE()), 2, DATEADD(day, -1, GETDATE())),
(38, 2, 4, 10, DATEADD(day, -3, GETDATE()), DATEADD(day, 1, GETDATE()), DATEADD(day, 1, GETDATE()), 9, 11, 38, 0, 5, N'CTDL nâng cao', 2, 6, DATEADD(day, -2, GETDATE()), 2, DATEADD(day, -1, GETDATE())),
(39, 3, 3, 11, DATEADD(day, -3, GETDATE()), DATEADD(day, 2, GETDATE()), DATEADD(day, 2, GETDATE()), 7, 9, 40, 0, 5, N'Java Design Patterns', 3, 7, DATEADD(day, -2, GETDATE()), 3, DATEADD(day, -1, GETDATE())),
(40, 4, 4, 12, DATEADD(day, -3, GETDATE()), DATEADD(day, 2, GETDATE()), DATEADD(day, 2, GETDATE()), 9, 11, 35, 0, 5, N'Database Design', 3, 7, DATEADD(day, -2, GETDATE()), 3, DATEADD(day, -1, GETDATE())),
(41, 13, 8, 19, DATEADD(day, -2, GETDATE()), DATEADD(day, 1, GETDATE()), DATEADD(day, 1, GETDATE()), 7, 9, 45, 0, 5, N'MS Word cơ bản', 2, 6, DATEADD(day, -1, GETDATE()), 2, GETDATE()),
(42, 14, 9, 20, DATEADD(day, -2, GETDATE()), DATEADD(day, 1, GETDATE()), DATEADD(day, 1, GETDATE()), 9, 11, 42, 0, 5, N'Excel Pivot Table', 2, 6, DATEADD(day, -1, GETDATE()), 2, GETDATE()),
(43, 19, 10, 27, DATEADD(day, -2, GETDATE()), DATEADD(day, 2, GETDATE()), DATEADD(day, 2, GETDATE()), 7, 9, 38, 0, 5, N'TOEIC Listening', 3, 7, DATEADD(day, -1, GETDATE()), 3, GETDATE()),
(44, 20, 11, 28, DATEADD(day, -2, GETDATE()), DATEADD(day, 2, GETDATE()), DATEADD(day, 2, GETDATE()), 9, 11, 40, 0, 5, N'TOEIC Speaking', 3, 7, DATEADD(day, -1, GETDATE()), 3, GETDATE()),
(45, 25, 12, 33, DATEADD(day, -2, GETDATE()), DATEADD(day, 1, GETDATE()), DATEADD(day, 1, GETDATE()), 7, 9, 32, 0, 5, N'Analog circuits', 2, 6, DATEADD(day, -1, GETDATE()), 2, GETDATE()),
(46, 26, 13, 34, DATEADD(day, -2, GETDATE()), DATEADD(day, 1, GETDATE()), DATEADD(day, 1, GETDATE()), 9, 11, 30, 0, 5, N'Digital circuits', 2, 6, DATEADD(day, -1, GETDATE()), 2, GETDATE()),
(47, 31, 14, 39, DATEADD(day, -2, GETDATE()), DATEADD(day, 2, GETDATE()), DATEADD(day, 2, GETDATE()), 7, 9, 28, 0, 5, N'AutoCAD 2D', 3, 7, DATEADD(day, -1, GETDATE()), 3, GETDATE()),
(48, 32, 14, 40, DATEADD(day, -2, GETDATE()), DATEADD(day, 2, GETDATE()), DATEADD(day, 2, GETDATE()), 9, 11, 25, 0, 5, N'AutoCAD 3D', 3, 7, DATEADD(day, -1, GETDATE()), 3, GETDATE()),

-- PDT đã duyệt nhưng chưa đến TTDT - TrangThai = 2 (PDTDongY)
(49, 5, 5, 13, DATEADD(day, -1, GETDATE()), DATEADD(day, 6, GETDATE()), DATEADD(day, 6, GETDATE()), 7, 9, 30, 0, 2, N'Network Lab', 4, 6, GETDATE(), NULL, NULL),
(50, 6, 4, 14, DATEADD(day, -1, GETDATE()), DATEADD(day, 6, GETDATE()), DATEADD(day, 6, GETDATE()), 9, 11, 38, 0, 2, N'OS Lab - Linux', 4, 6, GETDATE(), NULL, NULL),

-- Thêm nhiều đăng ký cho các tuần tới
(51, 7, 3, 15, GETDATE(), DATEADD(day, 8, GETDATE()), DATEADD(day, 8, GETDATE()), 7, 9, 35, 0, 0, N'ASP.NET Core MVC', 2, NULL, NULL, NULL, NULL),
(52, 7, 3, 15, GETDATE(), DATEADD(day, 8, GETDATE()), DATEADD(day, 8, GETDATE()), 9, 11, 35, 0, 0, N'ASP.NET Core API', 2, NULL, NULL, NULL, NULL),
(53, 8, 4, 16, GETDATE(), DATEADD(day, 9, GETDATE()), DATEADD(day, 9, GETDATE()), 7, 9, 40, 0, 0, N'Flutter Development', 3, NULL, NULL, NULL, NULL),
(54, 8, 4, 16, GETDATE(), DATEADD(day, 9, GETDATE()), DATEADD(day, 9, GETDATE()), 9, 11, 40, 0, 0, N'React Native', 3, NULL, NULL, NULL, NULL),
(55, 9, 5, 17, GETDATE(), DATEADD(day, 10, GETDATE()), DATEADD(day, 10, GETDATE()), 7, 9, 28, 1, 0, N'Penetration Testing', 4, NULL, NULL, NULL, NULL),
(56, 10, 3, 18, GETDATE(), DATEADD(day, 10, GETDATE()), DATEADD(day, 10, GETDATE()), 9, 11, 35, 0, 0, N'Deep Learning', 4, NULL, NULL, NULL, NULL),
(57, 11, 4, 9, GETDATE(), DATEADD(day, 11, GETDATE()), DATEADD(day, 11, GETDATE()), 7, 9, 38, 0, 0, N'AWS Fundamentals', 5, NULL, NULL, NULL, NULL),
(58, 12, 3, 10, GETDATE(), DATEADD(day, 11, GETDATE()), DATEADD(day, 11, GETDATE()), 9, 11, 40, 0, 0, N'Spark Processing', 5, NULL, NULL, NULL, NULL),
(59, 15, 8, 23, GETDATE(), DATEADD(day, 8, GETDATE()), DATEADD(day, 8, GETDATE()), 7, 9, 40, 0, 0, N'SAP Training', 2, NULL, NULL, NULL, NULL),
(60, 16, 9, 24, GETDATE(), DATEADD(day, 8, GETDATE()), DATEADD(day, 8, GETDATE()), 9, 11, 38, 0, 0, N'E-commerce Analytics', 2, NULL, NULL, NULL, NULL),

-- Đăng ký ưu tiên cao
(61, 17, 8, 25, GETDATE(), DATEADD(day, 3, GETDATE()), DATEADD(day, 3, GETDATE()), 7, 9, 42, 2, 0, N'MIS Exam - Kiểm tra', 2, NULL, NULL, NULL, NULL),
(62, 18, 9, 26, GETDATE(), DATEADD(day, 3, GETDATE()), DATEADD(day, 3, GETDATE()), 9, 11, 40, 2, 0, N'Analytics Exam - Thi cuối kỳ', 2, NULL, NULL, NULL, NULL),

-- Thêm các đăng ký khác
(63, 21, 10, 30, GETDATE(), DATEADD(day, 7, GETDATE()), DATEADD(day, 7, GETDATE()), 7, 9, 35, 0, 0, N'Business Communication', 5, NULL, NULL, NULL, NULL),
(64, 22, 11, 31, GETDATE(), DATEADD(day, 7, GETDATE()), DATEADD(day, 7, GETDATE()), 9, 11, 38, 0, 0, N'IT English', 5, NULL, NULL, NULL, NULL),
(65, 23, 10, 32, GETDATE(), DATEADD(day, 8, GETDATE()), DATEADD(day, 8, GETDATE()), 7, 9, 30, 0, 0, N'CAT Tools Training', 6, NULL, NULL, NULL, NULL),
(66, 24, 11, 27, GETDATE(), DATEADD(day, 8, GETDATE()), DATEADD(day, 8, GETDATE()), 9, 11, 35, 0, 0, N'Japanese N5', 6, NULL, NULL, NULL, NULL),
(67, 27, 12, 35, GETDATE(), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 7, 9, 30, 0, 0, N'Arduino Programming', 3, NULL, NULL, NULL, NULL),
(68, 28, 13, 36, GETDATE(), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 9, 11, 28, 0, 0, N'PCB Design Altium', 3, NULL, NULL, NULL, NULL),
(69, 29, 12, 37, GETDATE(), DATEADD(day, 5, GETDATE()), DATEADD(day, 5, GETDATE()), 7, 9, 32, 1, 0, N'Embedded Linux', 4, NULL, NULL, NULL, NULL),
(70, 30, 13, 38, GETDATE(), DATEADD(day, 5, GETDATE()), DATEADD(day, 5, GETDATE()), 9, 11, 30, 0, 0, N'IoT with ESP32', 4, NULL, NULL, NULL, NULL),
(71, 33, 14, 41, GETDATE(), DATEADD(day, 6, GETDATE()), DATEADD(day, 6, GETDATE()), 7, 9, 25, 0, 0, N'AutoCAD 3D Advanced', 5, NULL, NULL, NULL, NULL),
(72, 34, 14, 42, GETDATE(), DATEADD(day, 6, GETDATE()), DATEADD(day, 6, GETDATE()), 9, 11, 28, 0, 0, N'SolidWorks Assembly', 5, NULL, NULL, NULL, NULL),
(73, 35, 14, 43, GETDATE(), DATEADD(day, 7, GETDATE()), DATEADD(day, 7, GETDATE()), 7, 9, 25, 0, 0, N'CNC Programming', 6, NULL, NULL, NULL, NULL),
(74, 36, 12, 39, GETDATE(), DATEADD(day, 7, GETDATE()), DATEADD(day, 7, GETDATE()), 9, 11, 30, 0, 0, N'FEA Simulation', 6, NULL, NULL, NULL, NULL),
(75, 37, 14, 44, GETDATE(), DATEADD(day, 9, GETDATE()), DATEADD(day, 9, GETDATE()), 7, 9, 28, 0, 0, N'Construction Drawing', 2, NULL, NULL, NULL, NULL),
(76, 38, 14, 45, GETDATE(), DATEADD(day, 9, GETDATE()), DATEADD(day, 9, GETDATE()), 9, 11, 25, 0, 0, N'Architecture CAD', 2, NULL, NULL, NULL, NULL),
(77, 39, 14, 46, GETDATE(), DATEADD(day, 10, GETDATE()), DATEADD(day, 10, GETDATE()), 7, 9, 30, 0, 0, N'Revit Basics', 3, NULL, NULL, NULL, NULL),
(78, 40, 8, 47, GETDATE(), DATEADD(day, 10, GETDATE()), DATEADD(day, 10, GETDATE()), 9, 11, 35, 0, 0, N'Cost Estimation', 3, NULL, NULL, NULL, NULL),
(79, 13, 9, 48, GETDATE(), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 7, 9, 40, 0, 0, N'Office cho Du lịch', 3, NULL, NULL, NULL, NULL),
(80, 14, 8, 49, GETDATE(), DATEADD(day, 4, GETDATE()), DATEADD(day, 4, GETDATE()), 9, 11, 42, 0, 0, N'Excel Du lịch', 3, NULL, NULL, NULL, NULL),

-- Đăng ký có conflict (cùng phòng, cùng thời gian)
(81, 1, 3, 11, GETDATE(), DATEADD(day, 3, GETDATE()), DATEADD(day, 3, GETDATE()), 7, 9, 35, 0, 0, N'Conflict test - C++ khác GV', 2, NULL, NULL, NULL, NULL),
(82, 2, 3, 12, GETDATE(), DATEADD(day, 3, GETDATE()), DATEADD(day, 3, GETDATE()), 7, 9, 38, 1, 0, N'Conflict test - CTDL ưu tiên', 2, NULL, NULL, NULL, NULL),

-- Đăng ký đã duyệt xong cho tháng sau
(83, 1, 3, 9, DATEADD(day, -5, GETDATE()), DATEADD(day, 14, GETDATE()), DATEADD(day, 14, GETDATE()), 7, 9, 35, 0, 5, N'C++ Advanced', 2, 6, DATEADD(day, -4, GETDATE()), 2, DATEADD(day, -3, GETDATE())),
(84, 2, 4, 10, DATEADD(day, -5, GETDATE()), DATEADD(day, 14, GETDATE()), DATEADD(day, 14, GETDATE()), 9, 11, 38, 0, 5, N'Algorithm Contest', 2, 6, DATEADD(day, -4, GETDATE()), 2, DATEADD(day, -3, GETDATE())),
(85, 3, 3, 11, DATEADD(day, -5, GETDATE()), DATEADD(day, 15, GETDATE()), DATEADD(day, 15, GETDATE()), 7, 9, 40, 0, 5, N'Spring Boot', 3, 7, DATEADD(day, -4, GETDATE()), 3, DATEADD(day, -3, GETDATE())),
(86, 4, 4, 12, DATEADD(day, -5, GETDATE()), DATEADD(day, 15, GETDATE()), DATEADD(day, 15, GETDATE()), 9, 11, 35, 0, 5, N'MongoDB Lab', 3, 7, DATEADD(day, -4, GETDATE()), 3, DATEADD(day, -3, GETDATE())),
(87, 5, 5, 13, DATEADD(day, -4, GETDATE()), DATEADD(day, 16, GETDATE()), DATEADD(day, 16, GETDATE()), 7, 9, 30, 0, 5, N'Network Security', 4, 6, DATEADD(day, -3, GETDATE()), 2, DATEADD(day, -2, GETDATE())),
(88, 6, 4, 14, DATEADD(day, -4, GETDATE()), DATEADD(day, 16, GETDATE()), DATEADD(day, 16, GETDATE()), 9, 11, 38, 0, 5, N'Container Lab', 4, 6, DATEADD(day, -3, GETDATE()), 2, DATEADD(day, -2, GETDATE())),
(89, 13, 8, 19, DATEADD(day, -4, GETDATE()), DATEADD(day, 17, GETDATE()), DATEADD(day, 17, GETDATE()), 7, 9, 45, 0, 5, N'PowerPoint K23', 2, 7, DATEADD(day, -3, GETDATE()), 3, DATEADD(day, -2, GETDATE())),
(90, 14, 9, 20, DATEADD(day, -4, GETDATE()), DATEADD(day, 17, GETDATE()), DATEADD(day, 17, GETDATE()), 9, 11, 42, 0, 5, N'Data Analysis K22', 2, 7, DATEADD(day, -3, GETDATE()), 3, DATEADD(day, -2, GETDATE())),

-- Thêm đăng ký với mức độ ưu tiên khác nhau
(91, 7, 3, 15, GETDATE(), DATEADD(day, 12, GETDATE()), DATEADD(day, 12, GETDATE()), 7, 9, 35, 0, 0, N'Web Normal Priority', 2, NULL, NULL, NULL, NULL),
(92, 7, 4, 15, GETDATE(), DATEADD(day, 12, GETDATE()), DATEADD(day, 12, GETDATE()), 9, 11, 35, 1, 0, N'Web High Priority', 2, NULL, NULL, NULL, NULL),
(93, 8, 4, 16, GETDATE(), DATEADD(day, 13, GETDATE()), DATEADD(day, 13, GETDATE()), 7, 9, 40, 2, 0, N'Mobile Exam - Urgent', 3, NULL, NULL, NULL, NULL),
(94, 9, 5, 17, GETDATE(), DATEADD(day, 13, GETDATE()), DATEADD(day, 13, GETDATE()), 9, 11, 28, 0, 0, N'Security Workshop', 3, NULL, NULL, NULL, NULL),
(95, 10, 3, 18, GETDATE(), DATEADD(day, 14, GETDATE()), DATEADD(day, 14, GETDATE()), 7, 9, 35, 1, 0, N'AI Project Demo', 4, NULL, NULL, NULL, NULL),

-- Đăng ký vào ngày hôm nay (để test dashboard)
(96, 1, 1, 9, DATEADD(day, -1, GETDATE()), GETDATE(), GETDATE(), 13, 15, 35, 0, 5, N'Lab C++ chiều nay', 2, 6, GETDATE(), 2, GETDATE()),
(97, 13, 2, 19, DATEADD(day, -1, GETDATE()), GETDATE(), GETDATE(), 7, 9, 40, 0, 5, N'Lab Word sáng nay', 2, 6, GETDATE(), 2, GETDATE()),
(98, 19, 10, 27, DATEADD(day, -1, GETDATE()), GETDATE(), GETDATE(), 9, 11, 38, 0, 5, N'English Lab trưa nay', 3, 7, GETDATE(), 3, GETDATE()),
(99, 25, 12, 33, DATEADD(day, -1, GETDATE()), GETDATE(), GETDATE(), 13, 15, 30, 0, 5, N'Lab mạch chiều nay', 4, 6, GETDATE(), 2, GETDATE()),
(100, 31, 14, 39, DATEADD(day, -1, GETDATE()), GETDATE(), GETDATE(), 15, 17, 25, 0, 5, N'Lab CAD tối nay', 5, 7, GETDATE(), 3, GETDATE());

SET IDENTITY_INSERT DangKyPhongs OFF;
GO

-- =============================================
-- 12. MƯỢN BÙ (Sử dụng đúng schema)
-- =============================================
SET IDENTITY_INSERT MuonBus ON;
INSERT INTO MuonBus (MuonBuId, DangKyPhongMuonId, GiaoVienChoMuonId, NgayMuon, GioMuonBatDau, GioMuonKetThuc, LyDoMuon, GiaoVienMuonId, NgayTraBu, GioTraBuBatDau, GioTraBuKetThuc, DangKyPhongTraBuId, GhiChuTraBu, HanTraBu, TrangThai, NguoiDuyetId, NgayDuyet, LyDoTuChoi, NgayTao) VALUES
-- Mượn bù đã duyệt
(1, 37, 10, DATEADD(day, 1, GETDATE()), 7, 9, N'GV nghỉ ốm buổi trước', 9, DATEADD(day, 8, GETDATE()), 7, 9, 83, N'Sẽ trả bù tuần sau', DATEADD(day, 14, GETDATE()), 1, 2, DATEADD(day, -1, GETDATE()), NULL, DATEADD(day, -2, GETDATE())),
(2, 38, 11, DATEADD(day, 1, GETDATE()), 9, 11, N'Thiếu tiết thực hành', 10, DATEADD(day, 8, GETDATE()), 9, 11, 84, N'Bù lại buổi thiếu', DATEADD(day, 14, GETDATE()), 1, 2, DATEADD(day, -1, GETDATE()), NULL, DATEADD(day, -2, GETDATE())),
(3, 39, 12, DATEADD(day, 2, GETDATE()), 7, 9, N'Bù lại buổi nghỉ lễ', 11, DATEADD(day, 9, GETDATE()), 7, 9, 85, N'Đã xác nhận', DATEADD(day, 15, GETDATE()), 1, 3, GETDATE(), NULL, DATEADD(day, -1, GETDATE())),

-- Mượn bù chờ duyệt
(4, 40, 13, DATEADD(day, 2, GETDATE()), 9, 11, N'GV đi công tác', 12, NULL, NULL, NULL, NULL, N'Chờ xác nhận ngày trả', DATEADD(day, 16, GETDATE()), 0, NULL, NULL, NULL, GETDATE()),
(5, 45, 34, DATEADD(day, 1, GETDATE()), 7, 9, N'Thiếu thiết bị buổi trước', 33, NULL, NULL, NULL, NULL, N'Cần trả trong tuần', DATEADD(day, 7, GETDATE()), 0, NULL, NULL, NULL, GETDATE()),
(6, 47, 40, DATEADD(day, 2, GETDATE()), 7, 9, N'Máy chiếu hỏng', 39, NULL, NULL, NULL, NULL, N'Đợi sửa máy chiếu', DATEADD(day, 14, GETDATE()), 0, NULL, NULL, NULL, GETDATE()),

-- Mượn bù bị từ chối
(7, 1, 10, DATEADD(day, -7, GETDATE()), 7, 9, N'Test từ chối', 9, DATEADD(day, 1, GETDATE()), 9, 11, 2, NULL, DATEADD(day, 7, GETDATE()), 2, 2, DATEADD(day, -4, GETDATE()), N'Lịch trùng, không thể bù', DATEADD(day, -5, GETDATE())),
(8, 3, 12, DATEADD(day, -6, GETDATE()), 7, 9, N'Bù không hợp lệ', 11, DATEADD(day, 2, GETDATE()), 7, 9, 4, NULL, DATEADD(day, 7, GETDATE()), 2, 3, DATEADD(day, -3, GETDATE()), N'Vượt quá thời hạn mượn bù', DATEADD(day, -4, GETDATE())),

-- Thêm mượn bù
(9, 83, 10, DATEADD(day, 14, GETDATE()), 7, 9, N'Bù tháng sau', 9, DATEADD(day, 21, GETDATE()), 7, 9, 84, N'Bù cuối tháng', DATEADD(day, 28, GETDATE()), 0, NULL, NULL, NULL, GETDATE()),
(10, 85, 12, DATEADD(day, 15, GETDATE()), 7, 9, N'GV hội thảo', 11, DATEADD(day, 22, GETDATE()), 7, 9, 86, N'Bù tuần sau', DATEADD(day, 29, GETDATE()), 0, NULL, NULL, NULL, GETDATE()),
(11, 87, 14, DATEADD(day, 16, GETDATE()), 7, 9, N'Phòng bảo trì', 13, DATEADD(day, 23, GETDATE()), 7, 9, 88, NULL, DATEADD(day, 30, GETDATE()), 1, 2, GETDATE(), NULL, DATEADD(day, -1, GETDATE())),
(12, 89, 20, DATEADD(day, 17, GETDATE()), 7, 9, N'Thiếu tiết', 19, DATEADD(day, 24, GETDATE()), 7, 9, 90, NULL, DATEADD(day, 30, GETDATE()), 1, 3, GETDATE(), NULL, DATEADD(day, -1, GETDATE()));
SET IDENTITY_INSERT MuonBus OFF;
GO

-- =============================================
-- 13. THÔNG BÁO (Sử dụng đúng schema)
-- =============================================
SET IDENTITY_INSERT ThongBaos ON;
INSERT INTO ThongBaos (ThongBaoId, NguoiNhanId, TieuDe, NoiDung, ThoiGian, DaDoc, DuongDan, DangKyPhongId, LinkLienQuan, LoaiThongBao) VALUES
-- Thông báo cho Admin
(1, 1, N'Hệ thống khởi động', N'Hệ thống quản lý phòng máy đã khởi động thành công', DATEADD(day, -7, GETDATE()), 1, NULL, NULL, NULL, 0),
(2, 1, N'Backup hoàn tất', N'Backup database ngày 27/01/2026 hoàn tất', DATEADD(day, -6, GETDATE()), 1, NULL, NULL, NULL, 0),
(3, 1, N'Cảnh báo dung lượng', N'Dung lượng ổ đĩa server còn 20%', DATEADD(day, -1, GETDATE()), 0, NULL, NULL, NULL, 0),

-- Thông báo duyệt đăng ký cho PDT
(4, 6, N'Có đăng ký mới cần duyệt', N'GV Nguyễn Văn An đăng ký phòng PM-A201', GETDATE(), 0, N'/DangKyPhong/ChiTiet/11', 11, NULL, 1),
(5, 6, N'Có đăng ký mới cần duyệt', N'GV Nguyễn Văn An đăng ký phòng PM-A201', GETDATE(), 0, N'/DangKyPhong/ChiTiet/12', 12, NULL, 1),
(6, 6, N'Có đăng ký mới cần duyệt', N'GV Trần Thị Bình đăng ký phòng PM-A202', GETDATE(), 0, N'/DangKyPhong/ChiTiet/13', 13, NULL, 1),
(7, 7, N'Có đăng ký mới cần duyệt', N'GV Lê Văn Cường đăng ký phòng PM-A202', GETDATE(), 0, N'/DangKyPhong/ChiTiet/14', 14, NULL, 1),
(8, 7, N'Có đăng ký mới cần duyệt', N'GV Phạm Thị Dung đăng ký phòng PM-A201', GETDATE(), 0, N'/DangKyPhong/ChiTiet/15', 15, NULL, 1),
(9, 6, N'Có đăng ký ưu tiên cao', N'GV Vũ Văn Giang đăng ký khẩn cấp', GETDATE(), 0, N'/DangKyPhong/ChiTiet/18', 18, NULL, 1),
(10, 6, N'Có đăng ký kiểm tra', N'GV Bùi Văn Hùng đăng ký cho kỳ thi', GETDATE(), 0, N'/DangKyPhong/ChiTiet/20', 20, NULL, 1),

-- Thông báo cho TTDT
(11, 2, N'Có đăng ký chờ duyệt TTDT', N'Lab Machine Learning cần duyệt', GETDATE(), 0, N'/DangKyPhong/ChiTiet/21', 21, NULL, 1),
(12, 2, N'Có đăng ký chờ duyệt TTDT', N'Lab Cloud Computing cần duyệt', GETDATE(), 0, N'/DangKyPhong/ChiTiet/22', 22, NULL, 1),
(13, 2, N'Có đăng ký chờ duyệt TTDT', N'Lab Big Data cần duyệt', GETDATE(), 0, N'/DangKyPhong/ChiTiet/23', 23, NULL, 1),
(14, 3, N'Có đăng ký chờ duyệt TTDT', N'Tin học văn phòng K22 cần duyệt', GETDATE(), 0, N'/DangKyPhong/ChiTiet/24', 24, NULL, 1),
(15, 3, N'Có đăng ký chờ duyệt TTDT', N'Excel nâng cao K21 cần duyệt', GETDATE(), 0, N'/DangKyPhong/ChiTiet/25', 25, NULL, 1),

-- Thông báo phản hồi cho giảng viên (đã đọc)
(16, 9, N'Đăng ký đã được PDT duyệt', N'Đăng ký phòng PM-A201 ngày 04/02 đã được duyệt', DATEADD(day, -2, GETDATE()), 1, N'/DangKyPhong/ChiTiet/37', 37, NULL, 2),
(17, 9, N'Đăng ký đã được TTDT duyệt', N'Đăng ký đã hoàn tất. Bạn có thể sử dụng phòng.', DATEADD(day, -1, GETDATE()), 1, N'/DangKyPhong/ChiTiet/37', 37, NULL, 2),
(18, 10, N'Đăng ký đã được PDT duyệt', N'Đăng ký phòng PM-A202 đã được duyệt', DATEADD(day, -2, GETDATE()), 1, N'/DangKyPhong/ChiTiet/38', 38, NULL, 2),
(19, 10, N'Đăng ký đã được TTDT duyệt', N'Đăng ký đã hoàn tất', DATEADD(day, -1, GETDATE()), 1, N'/DangKyPhong/ChiTiet/38', 38, NULL, 2),
(20, 11, N'Đăng ký đã được PDT duyệt', N'Đăng ký phòng PM-A201 đã được duyệt', DATEADD(day, -2, GETDATE()), 1, N'/DangKyPhong/ChiTiet/39', 39, NULL, 2),

-- Thông báo phản hồi cho giảng viên (chưa đọc)
(21, 11, N'Đăng ký đã được TTDT duyệt', N'Đăng ký đã hoàn tất', DATEADD(day, -1, GETDATE()), 0, N'/DangKyPhong/ChiTiet/39', 39, NULL, 2),
(22, 12, N'Đăng ký đã được PDT duyệt', N'Đăng ký phòng PM-A202 đã được duyệt', DATEADD(day, -2, GETDATE()), 0, N'/DangKyPhong/ChiTiet/40', 40, NULL, 2),
(23, 12, N'Đăng ký đã được TTDT duyệt', N'Đăng ký đã hoàn tất', DATEADD(day, -1, GETDATE()), 0, N'/DangKyPhong/ChiTiet/40', 40, NULL, 2),

-- Thông báo từ chối
(24, 15, N'Đăng ký bị từ chối', N'Lý do: Số lượng sinh viên vượt quá sức chứa phòng', DATEADD(day, -4, GETDATE()), 0, N'/DangKyPhong/ChiTiet/31', 31, NULL, 3),
(25, 16, N'Đăng ký bị từ chối', N'Lý do: Trùng lịch bảo trì phòng máy', DATEADD(day, -3, GETDATE()), 0, N'/DangKyPhong/ChiTiet/32', 32, NULL, 3),
(26, 17, N'Đăng ký bị TTDT từ chối', N'Lý do: Phần mềm chưa được cài đặt', DATEADD(day, -4, GETDATE()), 0, N'/DangKyPhong/ChiTiet/33', 33, NULL, 3),
(27, 18, N'Đăng ký bị TTDT từ chối', N'Lý do: Phòng không đủ GPU', DATEADD(day, -3, GETDATE()), 0, N'/DangKyPhong/ChiTiet/34', 34, NULL, 3),

-- Thông báo bảo trì
(28, NULL, N'Lịch bảo trì phòng máy', N'PM-A101 sẽ bảo trì ngày 17/02/2026', GETDATE(), 0, NULL, NULL, NULL, 4),
(29, NULL, N'Bảo trì hoàn tất', N'PM-A301 đã sẵn sàng sử dụng', DATEADD(day, -7, GETDATE()), 0, NULL, NULL, NULL, 4),
(30, 2, N'Cảnh báo thiết bị', N'5 máy tại PM-A102 cần thay thế nguồn', DATEADD(day, -2, GETDATE()), 0, NULL, NULL, NULL, 4),

-- Thông báo nhắc nhở
(31, 9, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành C++ tại PM-A201', DATEADD(day, -1, GETDATE()), 0, N'/DangKyPhong/ChiTiet/37', 37, NULL, 5),
(32, 10, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành CTDL tại PM-A202', DATEADD(day, -1, GETDATE()), 0, N'/DangKyPhong/ChiTiet/38', 38, NULL, 5),
(33, 11, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành Java', GETDATE(), 0, N'/DangKyPhong/ChiTiet/39', 39, NULL, 5),
(34, 12, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành Database', GETDATE(), 0, N'/DangKyPhong/ChiTiet/40', 40, NULL, 5),
(35, 19, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành Word tại PM-B101', DATEADD(day, -1, GETDATE()), 0, N'/DangKyPhong/ChiTiet/41', 41, NULL, 5),

-- Thông báo mượn bù
(36, 2, N'Có yêu cầu mượn bù mới', N'GV Nguyễn Văn An yêu cầu mượn bù', DATEADD(day, -2, GETDATE()), 0, N'/MuonBu/ChiTiet/1', NULL, NULL, 6),
(37, 9, N'Yêu cầu mượn bù đã duyệt', N'Yêu cầu mượn bù của bạn đã được duyệt', DATEADD(day, -1, GETDATE()), 1, N'/MuonBu/ChiTiet/1', NULL, NULL, 6),
(38, 2, N'Có yêu cầu mượn bù mới', N'GV Trần Thị Bình yêu cầu mượn bù', DATEADD(day, -2, GETDATE()), 0, N'/MuonBu/ChiTiet/2', NULL, NULL, 6),
(39, 10, N'Yêu cầu mượn bù đã duyệt', N'Yêu cầu của bạn đã được duyệt', DATEADD(day, -1, GETDATE()), 1, N'/MuonBu/ChiTiet/2', NULL, NULL, 6),
(40, 2, N'Có yêu cầu mượn bù mới', N'GV Phạm Thị Dung yêu cầu mượn bù', GETDATE(), 0, N'/MuonBu/ChiTiet/4', NULL, NULL, 6),

-- Thông báo conflict
(41, 9, N'Cảnh báo trùng lịch', N'Đăng ký của bạn có thể bị trùng', GETDATE(), 0, N'/DangKyPhong/ChiTiet/11', 11, NULL, 7),
(42, 11, N'Cảnh báo trùng lịch', N'Đăng ký của bạn có thể bị trùng', GETDATE(), 0, N'/DangKyPhong/ChiTiet/81', 81, NULL, 7),
(43, 12, N'Cảnh báo trùng lịch', N'Đăng ký của bạn có thể bị trùng', GETDATE(), 0, N'/DangKyPhong/ChiTiet/82', 82, NULL, 7),

-- Thông báo SLA
(44, 6, N'Cảnh báo SLA', N'Có 3 đăng ký chờ PDT duyệt quá 24h', GETDATE(), 0, N'/SLA/Dashboard', NULL, NULL, 8),
(45, 2, N'Cảnh báo SLA', N'Có 2 đăng ký chờ TTDT duyệt quá 48h', GETDATE(), 0, N'/SLA/Dashboard', NULL, NULL, 8),

-- Thông báo chung
(46, NULL, N'Thông báo nghỉ Tết', N'Lịch nghỉ Tết Nguyên Đán 2026: 26/01 - 02/02', DATEADD(day, -10, GETDATE()), 0, NULL, NULL, NULL, 0),
(47, NULL, N'Hướng dẫn sử dụng hệ thống', N'Đã cập nhật hướng dẫn sử dụng mới', DATEADD(day, -5, GETDATE()), 0, N'/Home/Guide', NULL, NULL, 0),
(48, NULL, N'Cập nhật phần mềm', N'Đã cài đặt VS 2022 v17.9 cho các phòng CNTT', DATEADD(day, -3, GETDATE()), 0, NULL, NULL, NULL, 0),
(49, NULL, N'Quy định mới', N'Phải đăng ký trước ít nhất 3 ngày', DATEADD(day, -2, GETDATE()), 0, NULL, NULL, NULL, 0),
(50, NULL, N'Bảo trì hệ thống', N'Hệ thống bảo trì 22h ngày 10/02/2026', GETDATE(), 0, NULL, NULL, NULL, 0);
SET IDENTITY_INSERT ThongBaos OFF;
GO

-- =============================================
-- 14. TEMPLATE ĐĂNG KÝ
-- =============================================
SET IDENTITY_INSERT TemplateDangKys ON;
INSERT INTO TemplateDangKys (Id, TenTemplate, MoTa, HocPhanId, PhongMayId, ThuTrongTuan, TietBatDau, TietKetThuc, SoLuongSinhVien, PhanMemYeuCau, GhiChuMacDinh, IsActive, IsPublic, NguoiTaoId, NgayTao, SoLanSuDung) VALUES
(1, N'Lab C++ cơ bản', N'Template cho các buổi thực hành C++ nhập môn', 1, 3, 2, 1, 3, 35, N'Visual Studio 2022', N'Sinh viên chuẩn bị bài trước', 1, 1, 9, DATEADD(day, -30, GETDATE()), 15),
(2, N'Lab CTDL', N'Template thực hành cấu trúc dữ liệu', 2, 3, 3, 4, 6, 38, N'Visual Studio 2022', N'Mang theo tài liệu', 1, 1, 10, DATEADD(day, -28, GETDATE()), 12),
(3, N'Lab Java OOP', N'Template thực hành Java hướng đối tượng', 3, 4, 4, 1, 3, 40, N'IntelliJ IDEA', NULL, 1, 1, 11, DATEADD(day, -25, GETDATE()), 10),
(4, N'Lab Database SQL', N'Template thực hành cơ sở dữ liệu', 4, 4, 5, 4, 6, 35, N'SQL Server Management Studio', N'Cài đặt SQL Server trước', 1, 1, 12, DATEADD(day, -20, GETDATE()), 8),
(5, N'Lab Mạng Cisco', N'Template thực hành mạng với Packet Tracer', 5, 5, 2, 1, 3, 30, N'Cisco Packet Tracer', NULL, 1, 1, 13, DATEADD(day, -15, GETDATE()), 6),
(6, N'Lab Tin học VP', N'Template thực hành Word, Excel, PowerPoint', 13, 8, 3, 1, 3, 45, N'Microsoft Office 365', N'Mang USB', 1, 1, 19, DATEADD(day, -30, GETDATE()), 20),
(7, N'Lab English', N'Template luyện nghe nói tiếng Anh', 19, 10, 4, 4, 6, 38, NULL, N'Mang tai nghe', 1, 1, 27, DATEADD(day, -25, GETDATE()), 14),
(8, N'Lab Điện tử', N'Template thực hành mạch điện tử', 25, 12, 5, 1, 3, 32, N'Proteus', N'Chuẩn bị linh kiện', 1, 1, 33, DATEADD(day, -20, GETDATE()), 7),
(9, N'Lab AutoCAD', N'Template thực hành vẽ kỹ thuật', 32, 14, 2, 4, 6, 28, N'AutoCAD', N'Tải bản vẽ mẫu', 1, 1, 39, DATEADD(day, -15, GETDATE()), 9),
(10, N'Lab Web Dev', N'Template thực hành phát triển Web', 7, 3, 3, 1, 3, 35, N'Visual Studio 2022, SQL Server', N'Clone repo trước', 1, 0, 15, DATEADD(day, -10, GETDATE()), 5);
SET IDENTITY_INSERT TemplateDangKys OFF;
GO

-- =============================================
-- 15. THỐNG KÊ TÓM TẮT
-- =============================================
PRINT N'=== THỐNG KÊ DỮ LIỆU MẪU ==='
SELECT N'Quyền' as [Bảng], COUNT(*) as [Số bản ghi] FROM Quyens
UNION ALL SELECT N'Vai trò', COUNT(*) FROM VaiTros
UNION ALL SELECT N'Phòng ban', COUNT(*) FROM PhongBans
UNION ALL SELECT N'Nhân viên', COUNT(*) FROM NhanViens
UNION ALL SELECT N'Tài khoản', COUNT(*) FROM TaiKhoans
UNION ALL SELECT N'Phòng máy', COUNT(*) FROM PhongMays
UNION ALL SELECT N'Phần mềm', COUNT(*) FROM PhanMems
UNION ALL SELECT N'Phòng máy - Phần mềm', COUNT(*) FROM PhongMayPhanMems
UNION ALL SELECT N'Học phần', COUNT(*) FROM HocPhans
UNION ALL SELECT N'Bảo trì phòng', COUNT(*) FROM BaoTriPhongs
UNION ALL SELECT N'Đăng ký phòng', COUNT(*) FROM DangKyPhongs
UNION ALL SELECT N'Mượn bù', COUNT(*) FROM MuonBus
UNION ALL SELECT N'Thông báo', COUNT(*) FROM ThongBaos
UNION ALL SELECT N'Template đăng ký', COUNT(*) FROM TemplateDangKys
ORDER BY [Bảng];

PRINT N''
PRINT N'=== THỐNG KÊ ĐĂNG KÝ THEO TRẠNG THÁI ==='
SELECT 
    CASE TrangThai 
        WHEN 0 THEN N'Chờ PDT duyệt'
        WHEN 1 THEN N'PDT từ chối'
        WHEN 2 THEN N'PDT đồng ý'
        WHEN 3 THEN N'Chờ TTDT duyệt'
        WHEN 4 THEN N'TTDT từ chối'
        WHEN 5 THEN N'TTDT đồng ý'
        WHEN 6 THEN N'Đã hủy'
    END as [Trạng thái],
    COUNT(*) as [Số lượng]
FROM DangKyPhongs
GROUP BY TrangThai
ORDER BY TrangThai;

PRINT N''
PRINT N'=== TÀI KHOẢN ĐĂNG NHẬP MẪU ==='
PRINT N'Admin: admin / 123456'
PRINT N'Quản lý TT: quanly.tt / 123456'
PRINT N'Nhân viên TT: kythuat.tt / 123456'
PRINT N'Phòng đào tạo: pdt1 / 123456'
PRINT N'Giảng viên CNTT: gv.nva / 123456'
PRINT N'Giảng viên Kinh tế: gv.nvl / 123456'
PRINT N'Giảng viên Ngoại ngữ: gv.bvu / 123456'
GO
