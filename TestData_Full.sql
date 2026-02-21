-- =============================================
-- SCRIPT TẠO DỮ LIỆU MẪU ĐẦY ĐỦ CHO KIỂM THỬ
-- Hệ thống Quản lý Thực hành Máy tính
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
INSERT INTO PhongBans (PhongBanId, TenPhongBan, MoTa, SoDienThoai) VALUES
(1, N'Trung tâm Tin học', N'Quản lý phòng máy và hệ thống CNTT', N'0234.3822222'),
(2, N'Phòng Đào tạo', N'Quản lý chương trình đào tạo', N'0234.3833333'),
(3, N'Khoa Công nghệ thông tin', N'Khoa đào tạo ngành CNTT', N'0234.3844444'),
(4, N'Khoa Kinh tế', N'Khoa đào tạo ngành Kinh tế', N'0234.3855555'),
(5, N'Khoa Ngoại ngữ', N'Khoa đào tạo ngành Ngoại ngữ', N'0234.3866666'),
(6, N'Khoa Điện - Điện tử', N'Khoa đào tạo ngành Điện - Điện tử', N'0234.3877777'),
(7, N'Khoa Cơ khí', N'Khoa đào tạo ngành Cơ khí', N'0234.3888888'),
(8, N'Khoa Xây dựng', N'Khoa đào tạo ngành Xây dựng', N'0234.3899999'),
(9, N'Khoa Du lịch', N'Khoa đào tạo ngành Du lịch', N'0234.3811111'),
(10, N'Trung tâm Ngoại ngữ - Tin học', N'Trung tâm đào tạo ngắn hạn', N'0234.3800000');
SET IDENTITY_INSERT PhongBans OFF;
GO

-- =============================================
-- 4. NHÂN VIÊN (50 người)
-- =============================================
SET IDENTITY_INSERT NhanViens ON;
INSERT INTO NhanViens (MaNhanVien, HoTen, SoDienThoai, Email, PhongBanId) VALUES
-- Trung tâm Tin học (5 người)
(1, N'Nguyễn Văn Admin', N'0901234567', N'admin@university.edu.vn', 1),
(2, N'Trần Thị Quản Lý', N'0901234568', N'quanly.tt@university.edu.vn', 1),
(3, N'Lê Văn Kỹ Thuật', N'0901234569', N'kythuat.tt@university.edu.vn', 1),
(4, N'Phạm Thị Hỗ Trợ', N'0901234570', N'hotro.tt@university.edu.vn', 1),
(5, N'Hoàng Văn Bảo Trì', N'0901234571', N'baotri.tt@university.edu.vn', 1),

-- Phòng Đào tạo (3 người)
(6, N'Nguyễn Thị Phòng ĐT', N'0902234567', N'pdt1@university.edu.vn', 2),
(7, N'Trần Văn Lịch Học', N'0902234568', N'pdt2@university.edu.vn', 2),
(8, N'Lê Thị Sắp Xếp', N'0902234569', N'pdt3@university.edu.vn', 2),

-- Khoa CNTT - Giảng viên (10 người)
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

-- Khoa Kinh tế - Giảng viên (8 người)
(19, N'Nguyễn Văn Lộc', N'0904234567', N'nvl@university.edu.vn', 4),
(20, N'Trần Thị Mai', N'0904234568', N'ttm@university.edu.vn', 4),
(21, N'Lê Văn Nam', N'0904234569', N'lvn@university.edu.vn', 4),
(22, N'Phạm Thị Oanh', N'0904234570', N'pto@university.edu.vn', 4),
(23, N'Hoàng Văn Phú', N'0904234571', N'hvp@university.edu.vn', 4),
(24, N'Ngô Thị Quỳnh', N'0904234572', N'ntq@university.edu.vn', 4),
(25, N'Vũ Văn Sang', N'0904234573', N'vvs@university.edu.vn', 4),
(26, N'Đặng Thị Tâm', N'0904234574', N'dtt@university.edu.vn', 4),

-- Khoa Ngoại ngữ - Giảng viên (6 người)
(27, N'Bùi Văn Uy', N'0905234567', N'bvu@university.edu.vn', 5),
(28, N'Đỗ Thị Vân', N'0905234568', N'dtv@university.edu.vn', 5),
(29, N'Nguyễn Văn Xuân', N'0905234569', N'nvx@university.edu.vn', 5),
(30, N'Trần Thị Yến', N'0905234570', N'tty@university.edu.vn', 5),
(31, N'Lê Văn Zung', N'0905234571', N'lvz@university.edu.vn', 5),
(32, N'Phạm Thị Ánh', N'0905234572', N'pta@university.edu.vn', 5),

-- Khoa Điện - Điện tử (6 người)
(33, N'Hoàng Văn Bảo', N'0906234567', N'hvb@university.edu.vn', 6),
(34, N'Ngô Thị Châu', N'0906234568', N'ntc@university.edu.vn', 6),
(35, N'Vũ Văn Đạt', N'0906234569', N'vvd@university.edu.vn', 6),
(36, N'Đặng Thị Êm', N'0906234570', N'dte@university.edu.vn', 6),
(37, N'Bùi Văn Phong', N'0906234571', N'bvp@university.edu.vn', 6),
(38, N'Đỗ Thị Giang', N'0906234572', N'dtg@university.edu.vn', 6),

-- Khoa Cơ khí (5 người)
(39, N'Nguyễn Văn Hải', N'0907234567', N'nvh@university.edu.vn', 7),
(40, N'Trần Thị Ích', N'0907234568', N'tti@university.edu.vn', 7),
(41, N'Lê Văn Khánh', N'0907234569', N'lvk@university.edu.vn', 7),
(42, N'Phạm Thị Lan', N'0907234570', N'ptl@university.edu.vn', 7),
(43, N'Hoàng Văn Minh', N'0907234571', N'hvm@university.edu.vn', 7),

-- Khoa Xây dựng (4 người)
(44, N'Ngô Thị Ngọc', N'0908234567', N'ntn@university.edu.vn', 8),
(45, N'Vũ Văn Ơn', N'0908234568', N'vvo@university.edu.vn', 8),
(46, N'Đặng Thị Phượng', N'0908234569', N'dtp@university.edu.vn', 8),
(47, N'Bùi Văn Quân', N'0908234570', N'bvq@university.edu.vn', 8),

-- Khoa Du lịch (3 người)
(48, N'Đỗ Thị Rồng', N'0909234567', N'dtr@university.edu.vn', 9),
(49, N'Nguyễn Văn Sơn', N'0909234568', N'nvs@university.edu.vn', 9),
(50, N'Trần Thị Thương', N'0909234569', N'ttt@university.edu.vn', 9);
SET IDENTITY_INSERT NhanViens OFF;
GO

-- =============================================
-- 5. TÀI KHOẢN (50 tài khoản)
-- =============================================
SET IDENTITY_INSERT TaiKhoans ON;
INSERT INTO TaiKhoans (TaiKhoanId, TenDangNhap, MatKhau, MaNhanVien, VaiTroId, TrangThaiHoatDong, NgayTao) VALUES
-- Admin & Quản lý TT
(1, N'admin', N'123456', 1, 1, 1, GETDATE()),
(2, N'quanly.tt', N'123456', 2, 2, 1, GETDATE()),
(3, N'kythuat.tt', N'123456', 3, 3, 1, GETDATE()),
(4, N'hotro.tt', N'123456', 4, 3, 1, GETDATE()),
(5, N'baotri.tt', N'123456', 5, 3, 1, GETDATE()),

-- Phòng Đào tạo
(6, N'pdt1', N'123456', 6, 4, 1, GETDATE()),
(7, N'pdt2', N'123456', 7, 4, 1, GETDATE()),
(8, N'pdt3', N'123456', 8, 4, 1, GETDATE()),

-- Giảng viên Khoa CNTT
(9, N'gv.nva', N'123456', 9, 5, 1, GETDATE()),
(10, N'gv.ttb', N'123456', 10, 5, 1, GETDATE()),
(11, N'gv.lvc', N'123456', 11, 5, 1, GETDATE()),
(12, N'gv.ptd', N'123456', 12, 5, 1, GETDATE()),
(13, N'gv.hve', N'123456', 13, 5, 1, GETDATE()),
(14, N'gv.ntp', N'123456', 14, 5, 1, GETDATE()),
(15, N'gv.vvg', N'123456', 15, 5, 1, GETDATE()),
(16, N'gv.dth', N'123456', 16, 5, 1, GETDATE()),
(17, N'gv.bvh', N'123456', 17, 5, 1, GETDATE()),
(18, N'gv.dtk', N'123456', 18, 5, 1, GETDATE()),

-- Giảng viên Khoa Kinh tế
(19, N'gv.nvl', N'123456', 19, 5, 1, GETDATE()),
(20, N'gv.ttm', N'123456', 20, 5, 1, GETDATE()),
(21, N'gv.lvn', N'123456', 21, 5, 1, GETDATE()),
(22, N'gv.pto', N'123456', 22, 5, 1, GETDATE()),
(23, N'gv.hvp', N'123456', 23, 5, 1, GETDATE()),
(24, N'gv.ntq', N'123456', 24, 5, 1, GETDATE()),
(25, N'gv.vvs', N'123456', 25, 5, 1, GETDATE()),
(26, N'gv.dtt', N'123456', 26, 5, 1, GETDATE()),

-- Giảng viên Khoa Ngoại ngữ
(27, N'gv.bvu', N'123456', 27, 5, 1, GETDATE()),
(28, N'gv.dtv', N'123456', 28, 5, 1, GETDATE()),
(29, N'gv.nvx', N'123456', 29, 5, 1, GETDATE()),
(30, N'gv.tty', N'123456', 30, 5, 1, GETDATE()),
(31, N'gv.lvz', N'123456', 31, 5, 1, GETDATE()),
(32, N'gv.pta', N'123456', 32, 5, 1, GETDATE()),

-- Giảng viên Khoa Điện - Điện tử
(33, N'gv.hvb', N'123456', 33, 5, 1, GETDATE()),
(34, N'gv.ntc', N'123456', 34, 5, 1, GETDATE()),
(35, N'gv.vvd', N'123456', 35, 5, 1, GETDATE()),
(36, N'gv.dte', N'123456', 36, 5, 1, GETDATE()),
(37, N'gv.bvp', N'123456', 37, 5, 1, GETDATE()),
(38, N'gv.dtg', N'123456', 38, 5, 1, GETDATE()),

-- Giảng viên Khoa Cơ khí
(39, N'gv.nvh', N'123456', 39, 5, 1, GETDATE()),
(40, N'gv.tti', N'123456', 40, 5, 1, GETDATE()),
(41, N'gv.lvk', N'123456', 41, 5, 1, GETDATE()),
(42, N'gv.ptl', N'123456', 42, 5, 1, GETDATE()),
(43, N'gv.hvm', N'123456', 43, 5, 1, GETDATE()),

-- Giảng viên Khoa Xây dựng
(44, N'gv.ntn', N'123456', 44, 5, 1, GETDATE()),
(45, N'gv.vvo', N'123456', 45, 5, 1, GETDATE()),
(46, N'gv.dtp', N'123456', 46, 5, 1, GETDATE()),
(47, N'gv.bvq', N'123456', 47, 5, 1, GETDATE()),

-- Giảng viên Khoa Du lịch
(48, N'gv.dtr', N'123456', 48, 5, 1, GETDATE()),
(49, N'gv.nvs', N'123456', 49, 5, 1, GETDATE()),
(50, N'gv.ttt', N'123456', 50, 5, 1, GETDATE());
SET IDENTITY_INSERT TaiKhoans OFF;
GO

-- =============================================
-- 6. PHÒNG MÁY (15 phòng)
-- =============================================
SET IDENTITY_INSERT PhongMays ON;
INSERT INTO PhongMays (PhongMayId, TenPhong, ViTri, SoMay, MoTa, TrangThai, TrangThaiDuyet, NgayTao) VALUES
(1, N'PM-A101', N'Tòa A, Tầng 1', 40, N'Phòng máy chung, cấu hình cao', 1, 1, GETDATE()),
(2, N'PM-A102', N'Tòa A, Tầng 1', 35, N'Phòng máy chung, cấu hình trung bình', 1, 1, GETDATE()),
(3, N'PM-A201', N'Tòa A, Tầng 2', 40, N'Phòng máy CNTT chuyên dụng', 1, 1, GETDATE()),
(4, N'PM-A202', N'Tòa A, Tầng 2', 40, N'Phòng máy CNTT chuyên dụng', 1, 1, GETDATE()),
(5, N'PM-A203', N'Tòa A, Tầng 2', 35, N'Phòng máy mạng và bảo mật', 1, 1, GETDATE()),
(6, N'PM-A301', N'Tòa A, Tầng 3', 30, N'Phòng máy đồ họa', 1, 1, GETDATE()),
(7, N'PM-A302', N'Tòa A, Tầng 3', 30, N'Phòng máy multimedia', 1, 1, GETDATE()),
(8, N'PM-B101', N'Tòa B, Tầng 1', 45, N'Phòng máy kinh tế', 1, 1, GETDATE()),
(9, N'PM-B102', N'Tòa B, Tầng 1', 45, N'Phòng máy kinh tế', 1, 1, GETDATE()),
(10, N'PM-B201', N'Tòa B, Tầng 2', 40, N'Phòng máy ngoại ngữ', 1, 1, GETDATE()),
(11, N'PM-B202', N'Tòa B, Tầng 2', 40, N'Phòng máy ngoại ngữ', 1, 1, GETDATE()),
(12, N'PM-C101', N'Tòa C, Tầng 1', 35, N'Phòng máy kỹ thuật', 1, 1, GETDATE()),
(13, N'PM-C102', N'Tòa C, Tầng 1', 35, N'Phòng máy kỹ thuật', 1, 1, GETDATE()),
(14, N'PM-C201', N'Tòa C, Tầng 2', 30, N'Phòng máy AutoCAD', 1, 1, GETDATE()),
(15, N'PM-TEST', N'Tòa C, Tầng 2', 25, N'Phòng máy thử nghiệm - Chờ duyệt', 0, 0, GETDATE());
SET IDENTITY_INSERT PhongMays OFF;
GO

-- =============================================
-- 7. PHẦN MỀM (30 phần mềm)
-- =============================================
SET IDENTITY_INSERT PhanMems ON;
INSERT INTO PhanMems (PhanMemId, TenPhanMem, PhienBan, MoTa, LoaiPhanMem, NhaSanXuat, TrangThaiHoatDong) VALUES
-- Phần mềm văn phòng
(1, N'Microsoft Office 365', N'2024', N'Bộ ứng dụng văn phòng', N'Văn phòng', N'Microsoft', 1),
(2, N'LibreOffice', N'7.6', N'Bộ ứng dụng văn phòng mã nguồn mở', N'Văn phòng', N'The Document Foundation', 1),
(3, N'Adobe Acrobat Pro', N'2024', N'Phần mềm xử lý PDF', N'Văn phòng', N'Adobe', 1),

-- IDE & Development
(4, N'Visual Studio 2022', N'17.8', N'IDE phát triển ứng dụng', N'Lập trình', N'Microsoft', 1),
(5, N'Visual Studio Code', N'1.85', N'Code editor đa năng', N'Lập trình', N'Microsoft', 1),
(6, N'IntelliJ IDEA', N'2024.1', N'IDE Java/Kotlin', N'Lập trình', N'JetBrains', 1),
(7, N'PyCharm', N'2024.1', N'IDE Python', N'Lập trình', N'JetBrains', 1),
(8, N'Eclipse IDE', N'2024-03', N'IDE Java', N'Lập trình', N'Eclipse Foundation', 1),
(9, N'Android Studio', N'2024.1', N'IDE phát triển Android', N'Lập trình', N'Google', 1),
(10, N'Xcode', N'15.2', N'IDE phát triển iOS/macOS', N'Lập trình', N'Apple', 1),

-- Database
(11, N'SQL Server Management Studio', N'19.2', N'Quản lý SQL Server', N'Database', N'Microsoft', 1),
(12, N'MySQL Workbench', N'8.0', N'Quản lý MySQL', N'Database', N'Oracle', 1),
(13, N'pgAdmin', N'7.8', N'Quản lý PostgreSQL', N'Database', N'PostgreSQL', 1),
(14, N'MongoDB Compass', N'1.42', N'Quản lý MongoDB', N'Database', N'MongoDB', 1),

-- Đồ họa & Multimedia
(15, N'Adobe Photoshop', N'2024', N'Xử lý ảnh chuyên nghiệp', N'Đồ họa', N'Adobe', 1),
(16, N'Adobe Illustrator', N'2024', N'Thiết kế vector', N'Đồ họa', N'Adobe', 1),
(17, N'Adobe Premiere Pro', N'2024', N'Chỉnh sửa video', N'Multimedia', N'Adobe', 1),
(18, N'Figma', N'2024', N'Thiết kế UI/UX', N'Đồ họa', N'Figma', 1),
(19, N'Blender', N'4.0', N'Đồ họa 3D', N'Đồ họa', N'Blender Foundation', 1),
(20, N'CorelDRAW', N'2024', N'Thiết kế đồ họa', N'Đồ họa', N'Corel', 1),

-- CAD & Engineering
(21, N'AutoCAD', N'2024', N'Phần mềm CAD', N'Kỹ thuật', N'Autodesk', 1),
(22, N'SolidWorks', N'2024', N'Thiết kế 3D cơ khí', N'Kỹ thuật', N'Dassault', 1),
(23, N'MATLAB', N'R2024a', N'Tính toán kỹ thuật', N'Kỹ thuật', N'MathWorks', 1),
(24, N'Proteus', N'8.16', N'Mô phỏng mạch điện', N'Kỹ thuật', N'Labcenter', 1),

-- Mạng & Bảo mật
(25, N'Cisco Packet Tracer', N'8.2', N'Mô phỏng mạng', N'Mạng', N'Cisco', 1),
(26, N'Wireshark', N'4.2', N'Phân tích gói tin mạng', N'Mạng', N'Wireshark Foundation', 1),
(27, N'VMware Workstation', N'17', N'Máy ảo', N'Hệ thống', N'VMware', 1),
(28, N'VirtualBox', N'7.0', N'Máy ảo mã nguồn mở', N'Hệ thống', N'Oracle', 1),

-- Ngôn ngữ & Framework
(29, N'Node.js', N'20 LTS', N'Runtime JavaScript', N'Lập trình', N'OpenJS Foundation', 1),
(30, N'Python', N'3.12', N'Ngôn ngữ lập trình Python', N'Lập trình', N'Python Software Foundation', 1);
SET IDENTITY_INSERT PhanMems OFF;
GO

-- =============================================
-- 8. PHÒNG MÁY - PHẦN MỀM (Mapping)
-- =============================================
-- PM-A101, A102: Phần mềm cơ bản
INSERT INTO PhongMayPhanMems (PhongMayId, PhanMemId, NgayCaiDat) VALUES
(1, 1, GETDATE()), (1, 4, GETDATE()), (1, 5, GETDATE()), (1, 11, GETDATE()), (1, 29, GETDATE()), (1, 30, GETDATE()),
(2, 1, GETDATE()), (2, 5, GETDATE()), (2, 11, GETDATE()), (2, 29, GETDATE()), (2, 30, GETDATE());

-- PM-A201, A202, A203: Phòng CNTT chuyên dụng
INSERT INTO PhongMayPhanMems (PhongMayId, PhanMemId, NgayCaiDat) VALUES
(3, 1, GETDATE()), (3, 4, GETDATE()), (3, 5, GETDATE()), (3, 6, GETDATE()), (3, 7, GETDATE()), (3, 8, GETDATE()), (3, 9, GETDATE()), (3, 11, GETDATE()), (3, 12, GETDATE()), (3, 13, GETDATE()), (3, 14, GETDATE()), (3, 29, GETDATE()), (3, 30, GETDATE()),
(4, 1, GETDATE()), (4, 4, GETDATE()), (4, 5, GETDATE()), (4, 6, GETDATE()), (4, 7, GETDATE()), (4, 8, GETDATE()), (4, 9, GETDATE()), (4, 11, GETDATE()), (4, 12, GETDATE()), (4, 13, GETDATE()), (4, 14, GETDATE()), (4, 29, GETDATE()), (4, 30, GETDATE()),
(5, 1, GETDATE()), (5, 5, GETDATE()), (5, 25, GETDATE()), (5, 26, GETDATE()), (5, 27, GETDATE()), (5, 28, GETDATE());

-- PM-A301, A302: Phòng đồ họa & multimedia
INSERT INTO PhongMayPhanMems (PhongMayId, PhanMemId, NgayCaiDat) VALUES
(6, 1, GETDATE()), (6, 3, GETDATE()), (6, 15, GETDATE()), (6, 16, GETDATE()), (6, 18, GETDATE()), (6, 19, GETDATE()), (6, 20, GETDATE()),
(7, 1, GETDATE()), (7, 3, GETDATE()), (7, 15, GETDATE()), (7, 16, GETDATE()), (7, 17, GETDATE()), (7, 18, GETDATE()), (7, 19, GETDATE());

-- PM-B101, B102: Phòng kinh tế
INSERT INTO PhongMayPhanMems (PhongMayId, PhanMemId, NgayCaiDat) VALUES
(8, 1, GETDATE()), (8, 3, GETDATE()), (8, 5, GETDATE()), (8, 11, GETDATE()),
(9, 1, GETDATE()), (9, 3, GETDATE()), (9, 5, GETDATE()), (9, 11, GETDATE());

-- PM-B201, B202: Phòng ngoại ngữ
INSERT INTO PhongMayPhanMems (PhongMayId, PhanMemId, NgayCaiDat) VALUES
(10, 1, GETDATE()), (10, 3, GETDATE()), (10, 5, GETDATE()),
(11, 1, GETDATE()), (11, 3, GETDATE()), (11, 5, GETDATE());

-- PM-C101, C102, C201: Phòng kỹ thuật
INSERT INTO PhongMayPhanMems (PhongMayId, PhanMemId, NgayCaiDat) VALUES
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
-- 10. BẢO TRÌ PHÒNG MÁY (20 lịch bảo trì)
-- =============================================
SET IDENTITY_INSERT BaoTriPhongs ON;
INSERT INTO BaoTriPhongs (BaoTriPhongId, PhongMayId, NgayBaoTri, NoiDung, NguoiThucHienId, TrangThai, GhiChu) VALUES
-- Bảo trì đã hoàn thành
(1, 1, DATEADD(day, -30, GETDATE()), N'Bảo trì định kỳ - Cài đặt lại hệ thống', 3, 2, N'Hoàn thành đúng tiến độ'),
(2, 2, DATEADD(day, -28, GETDATE()), N'Thay thế 5 bộ nguồn', 3, 2, N'Thay thế nguồn bị hỏng'),
(3, 3, DATEADD(day, -25, GETDATE()), N'Nâng cấp RAM lên 16GB', 4, 2, N'Nâng cấp toàn bộ 40 máy'),
(4, 4, DATEADD(day, -20, GETDATE()), N'Cài đặt Visual Studio 2022', 3, 2, N'Cập nhật phần mềm mới'),
(5, 5, DATEADD(day, -15, GETDATE()), N'Cấu hình lại switch mạng', 4, 2, N'Tối ưu VLAN'),
(6, 6, DATEADD(day, -10, GETDATE()), N'Cài Adobe Creative Suite', 3, 2, N'Cài đặt bộ Adobe mới'),
(7, 7, DATEADD(day, -7, GETDATE()), N'Sửa chữa 3 máy bị hỏng ổ cứng', 5, 2, N'Thay SSD mới'),

-- Bảo trì đang thực hiện
(8, 8, GETDATE(), N'Bảo trì định kỳ tháng 2', 3, 1, N'Đang thực hiện'),
(9, 9, GETDATE(), N'Cập nhật Windows và Office', 4, 1, N'Cập nhật bản vá bảo mật'),
(10, 10, DATEADD(day, 1, GETDATE()), N'Kiểm tra headphone và microphone', 5, 0, N'Chờ thiết bị thay thế'),

-- Bảo trì sắp tới
(11, 11, DATEADD(day, 3, GETDATE()), N'Bảo trì định kỳ', 3, 0, N'Đã lên lịch'),
(12, 12, DATEADD(day, 5, GETDATE()), N'Cài đặt MATLAB mới', 4, 0, N'Đã lên lịch'),
(13, 13, DATEADD(day, 7, GETDATE()), N'Nâng cấp Proteus', 3, 0, N'Đã lên lịch'),
(14, 14, DATEADD(day, 10, GETDATE()), N'Cài AutoCAD 2025', 4, 0, N'Đã lên lịch'),
(15, 1, DATEADD(day, 14, GETDATE()), N'Bảo trì định kỳ quý 1', 3, 0, N'Đã lên lịch'),
(16, 2, DATEADD(day, 14, GETDATE()), N'Bảo trì định kỳ quý 1', 4, 0, N'Đã lên lịch'),
(17, 3, DATEADD(day, 15, GETDATE()), N'Bảo trì định kỳ quý 1', 5, 0, N'Đã lên lịch'),
(18, 4, DATEADD(day, 15, GETDATE()), N'Bảo trì định kỳ quý 1', 3, 0, N'Đã lên lịch'),
(19, 5, DATEADD(day, 16, GETDATE()), N'Bảo trì định kỳ quý 1', 4, 0, N'Đã lên lịch'),
(20, 6, DATEADD(day, 16, GETDATE()), N'Bảo trì định kỳ quý 1', 5, 0, N'Đã lên lịch');
SET IDENTITY_INSERT BaoTriPhongs OFF;
GO

-- =============================================
-- 11. ĐĂNG KÝ PHÒNG (100 đăng ký với nhiều trạng thái)
-- =============================================
SET IDENTITY_INSERT DangKyPhongs ON;

-- Các đăng ký đã hoàn thành (trong quá khứ) - TrangThai = 5 (TTDTDongY)
INSERT INTO DangKyPhongs (DangKyPhongId, HocPhanId, PhongMayId, TaiKhoanId, NgayDangKy, NgayBatDau, TietBatDau, TietKetThuc, SoLuongSinhVien, MucDoUuTien, TrangThai, GhiChu, ThuTrongTuan, PhanMemYeuCau, NguoiDuyetPDTId, NgayDuyetPDT, NguoiDuyetTTDTId, NgayDuyetTTDT) VALUES
-- Tuần trước
(1, 1, 3, 9, DATEADD(day, -14, GETDATE()), DATEADD(day, -7, GETDATE()), 1, 3, 35, 0, 5, N'Thực hành C++', 2, N'Visual Studio 2022', 6, DATEADD(day, -13, GETDATE()), 2, DATEADD(day, -12, GETDATE())),
(2, 2, 3, 10, DATEADD(day, -14, GETDATE()), DATEADD(day, -7, GETDATE()), 4, 6, 38, 0, 5, N'Thực hành CTDL', 2, N'Visual Studio 2022', 6, DATEADD(day, -13, GETDATE()), 2, DATEADD(day, -12, GETDATE())),
(3, 3, 4, 11, DATEADD(day, -13, GETDATE()), DATEADD(day, -6, GETDATE()), 1, 3, 40, 0, 5, N'Thực hành Java OOP', 3, N'IntelliJ IDEA', 7, DATEADD(day, -12, GETDATE()), 2, DATEADD(day, -11, GETDATE())),
(4, 4, 4, 12, DATEADD(day, -13, GETDATE()), DATEADD(day, -6, GETDATE()), 4, 6, 35, 0, 5, N'Thực hành SQL Server', 3, N'SQL Server Management Studio', 7, DATEADD(day, -12, GETDATE()), 2, DATEADD(day, -11, GETDATE())),
(5, 5, 5, 13, DATEADD(day, -12, GETDATE()), DATEADD(day, -5, GETDATE()), 1, 3, 30, 0, 5, N'Thực hành Cisco', 4, N'Cisco Packet Tracer', 6, DATEADD(day, -11, GETDATE()), 3, DATEADD(day, -10, GETDATE())),
(6, 13, 8, 19, DATEADD(day, -12, GETDATE()), DATEADD(day, -5, GETDATE()), 4, 6, 42, 0, 5, N'Thực hành Word, Excel', 4, N'Microsoft Office 365', 6, DATEADD(day, -11, GETDATE()), 3, DATEADD(day, -10, GETDATE())),
(7, 14, 8, 20, DATEADD(day, -11, GETDATE()), DATEADD(day, -4, GETDATE()), 1, 3, 40, 0, 5, N'Thực hành Excel nâng cao', 5, N'Microsoft Office 365', 7, DATEADD(day, -10, GETDATE()), 2, DATEADD(day, -9, GETDATE())),
(8, 19, 10, 27, DATEADD(day, -11, GETDATE()), DATEADD(day, -4, GETDATE()), 4, 6, 38, 0, 5, N'Luyện nghe nói', 5, NULL, 7, DATEADD(day, -10, GETDATE()), 2, DATEADD(day, -9, GETDATE())),
(9, 25, 12, 33, DATEADD(day, -10, GETDATE()), DATEADD(day, -3, GETDATE()), 1, 3, 32, 0, 5, N'Thực hành mạch', 6, N'Proteus', 6, DATEADD(day, -9, GETDATE()), 3, DATEADD(day, -8, GETDATE())),
(10, 31, 14, 39, DATEADD(day, -10, GETDATE()), DATEADD(day, -3, GETDATE()), 4, 6, 28, 0, 5, N'Vẽ kỹ thuật', 6, N'AutoCAD', 6, DATEADD(day, -9, GETDATE()), 3, DATEADD(day, -8, GETDATE())),

-- Đăng ký đang chờ PDT duyệt - TrangThai = 0 (ChoDuyetPDT)
(11, 1, 3, 9, GETDATE(), DATEADD(day, 3, GETDATE()), 1, 3, 35, 0, 0, N'Thực hành C++ - Nhóm 1', 2, N'Visual Studio 2022', NULL, NULL, NULL, NULL),
(12, 1, 3, 9, GETDATE(), DATEADD(day, 3, GETDATE()), 4, 6, 35, 0, 0, N'Thực hành C++ - Nhóm 2', 2, N'Visual Studio 2022', NULL, NULL, NULL, NULL),
(13, 2, 4, 10, GETDATE(), DATEADD(day, 4, GETDATE()), 1, 3, 38, 0, 0, N'Thực hành CTDL', 3, N'Visual Studio 2022', NULL, NULL, NULL, NULL),
(14, 3, 4, 11, GETDATE(), DATEADD(day, 4, GETDATE()), 4, 6, 40, 0, 0, N'Thực hành Java', 3, N'IntelliJ IDEA', NULL, NULL, NULL, NULL),
(15, 4, 3, 12, GETDATE(), DATEADD(day, 5, GETDATE()), 1, 3, 35, 0, 0, N'Lab SQL Server', 4, N'SQL Server Management Studio', NULL, NULL, NULL, NULL),
(16, 5, 5, 13, GETDATE(), DATEADD(day, 5, GETDATE()), 4, 6, 30, 0, 0, N'Lab mạng Cisco', 4, N'Cisco Packet Tracer', NULL, NULL, NULL, NULL),
(17, 6, 4, 14, GETDATE(), DATEADD(day, 6, GETDATE()), 1, 3, 38, 0, 0, N'Lab hệ điều hành', 5, N'VMware Workstation', NULL, NULL, NULL, NULL),
(18, 7, 3, 15, GETDATE(), DATEADD(day, 6, GETDATE()), 4, 6, 35, 1, 0, N'Lab Web ASP.NET - Khẩn cấp', 5, N'Visual Studio 2022, SQL Server', NULL, NULL, NULL, NULL),
(19, 8, 4, 16, GETDATE(), DATEADD(day, 7, GETDATE()), 1, 3, 40, 0, 0, N'Lab Android Studio', 6, N'Android Studio', NULL, NULL, NULL, NULL),
(20, 9, 5, 17, GETDATE(), DATEADD(day, 7, GETDATE()), 4, 6, 28, 2, 0, N'Lab bảo mật - Kiểm tra', 6, N'Wireshark, VMware', NULL, NULL, NULL, NULL),

-- Đăng ký chờ TTDT duyệt (PDT đã duyệt) - TrangThai = 3 (ChoDuyetTTDT)
(21, 10, 3, 18, DATEADD(day, -2, GETDATE()), DATEADD(day, 5, GETDATE()), 1, 3, 35, 0, 3, N'Lab Machine Learning', 4, N'Python, PyCharm', 6, DATEADD(day, -1, GETDATE()), NULL, NULL),
(22, 11, 4, 9, DATEADD(day, -2, GETDATE()), DATEADD(day, 5, GETDATE()), 4, 6, 38, 0, 3, N'Lab Cloud Computing', 4, N'Docker, Kubernetes', 6, DATEADD(day, -1, GETDATE()), NULL, NULL),
(23, 12, 3, 10, DATEADD(day, -2, GETDATE()), DATEADD(day, 6, GETDATE()), 1, 3, 40, 0, 3, N'Lab Big Data', 5, N'Python, Spark', 7, DATEADD(day, -1, GETDATE()), NULL, NULL),
(24, 13, 8, 21, DATEADD(day, -1, GETDATE()), DATEADD(day, 4, GETDATE()), 1, 3, 45, 0, 3, N'Tin học văn phòng K22', 2, N'Microsoft Office 365', 6, GETDATE(), NULL, NULL),
(25, 14, 9, 22, DATEADD(day, -1, GETDATE()), DATEADD(day, 4, GETDATE()), 4, 6, 42, 0, 3, N'Excel nâng cao K21', 2, N'Microsoft Office 365', 6, GETDATE(), NULL, NULL),
(26, 15, 8, 23, DATEADD(day, -1, GETDATE()), DATEADD(day, 5, GETDATE()), 1, 3, 40, 0, 3, N'Phần mềm kế toán', 3, N'MISA, SAP', 7, GETDATE(), NULL, NULL),
(27, 16, 9, 24, DATEADD(day, -1, GETDATE()), DATEADD(day, 5, GETDATE()), 4, 6, 38, 0, 3, N'Thương mại điện tử', 3, N'Shopee, Lazada tools', 7, GETDATE(), NULL, NULL),
(28, 19, 10, 28, DATEADD(day, -1, GETDATE()), DATEADD(day, 3, GETDATE()), 1, 3, 38, 0, 3, N'English Practice 1', 2, NULL, 6, GETDATE(), NULL, NULL),
(29, 20, 11, 29, DATEADD(day, -1, GETDATE()), DATEADD(day, 3, GETDATE()), 4, 6, 40, 0, 3, N'English Practice 2', 2, NULL, 6, GETDATE(), NULL, NULL),
(30, 21, 10, 30, DATEADD(day, -1, GETDATE()), DATEADD(day, 4, GETDATE()), 1, 3, 35, 0, 3, N'Business English', 3, N'Microsoft Office 365', 7, GETDATE(), NULL, NULL),

-- PDT đã từ chối - TrangThai = 1 (PDTTuChoi)
(31, 7, 1, 15, DATEADD(day, -5, GETDATE()), DATEADD(day, 2, GETDATE()), 1, 3, 50, 0, 1, N'Web Lab - Quá đông', 2, N'Visual Studio 2022', 6, DATEADD(day, -4, GETDATE()), NULL, NULL),
(32, 8, 2, 16, DATEADD(day, -4, GETDATE()), DATEADD(day, 1, GETDATE()), 4, 6, 45, 0, 1, N'Mobile Lab - Trùng lịch bảo trì', 3, N'Android Studio', 7, DATEADD(day, -3, GETDATE()), NULL, NULL),

-- TTDT đã từ chối - TrangThai = 4 (TTDTTuChoi)
(33, 9, 5, 17, DATEADD(day, -6, GETDATE()), DATEADD(day, 1, GETDATE()), 1, 3, 30, 0, 4, N'Security Lab - Thiếu phần mềm', 4, N'Kali Linux', 6, DATEADD(day, -5, GETDATE()), 2, DATEADD(day, -4, GETDATE())),
(34, 10, 3, 18, DATEADD(day, -5, GETDATE()), DATEADD(day, 2, GETDATE()), 4, 6, 35, 0, 4, N'AI Lab - Không đủ GPU', 5, N'TensorFlow, CUDA', 7, DATEADD(day, -4, GETDATE()), 3, DATEADD(day, -3, GETDATE())),

-- Đã hủy - TrangThai = 6 (DaHuy)
(35, 11, 4, 9, DATEADD(day, -7, GETDATE()), DATEADD(day, -1, GETDATE()), 1, 3, 38, 0, 6, N'Cloud Lab - GV nghỉ phép', 2, N'AWS, Azure', 6, DATEADD(day, -6, GETDATE()), 2, DATEADD(day, -5, GETDATE())),
(36, 12, 3, 10, DATEADD(day, -8, GETDATE()), DATEADD(day, -2, GETDATE()), 4, 6, 40, 0, 6, N'Big Data Lab - SV bận thi', 3, N'Hadoop', 7, DATEADD(day, -7, GETDATE()), 3, DATEADD(day, -6, GETDATE())),

-- Đã được TTDT duyệt (sắp diễn ra) - TrangThai = 5 (TTDTDongY)
(37, 1, 3, 9, DATEADD(day, -3, GETDATE()), DATEADD(day, 1, GETDATE()), 1, 3, 35, 0, 5, N'C++ Basics', 2, N'Visual Studio 2022', 6, DATEADD(day, -2, GETDATE()), 2, DATEADD(day, -1, GETDATE())),
(38, 2, 4, 10, DATEADD(day, -3, GETDATE()), DATEADD(day, 1, GETDATE()), 4, 6, 38, 0, 5, N'CTDL nâng cao', 2, N'Visual Studio 2022', 6, DATEADD(day, -2, GETDATE()), 2, DATEADD(day, -1, GETDATE())),
(39, 3, 3, 11, DATEADD(day, -3, GETDATE()), DATEADD(day, 2, GETDATE()), 1, 3, 40, 0, 5, N'Java Design Patterns', 3, N'IntelliJ IDEA', 7, DATEADD(day, -2, GETDATE()), 3, DATEADD(day, -1, GETDATE())),
(40, 4, 4, 12, DATEADD(day, -3, GETDATE()), DATEADD(day, 2, GETDATE()), 4, 6, 35, 0, 5, N'Database Design', 3, N'SQL Server, MySQL', 7, DATEADD(day, -2, GETDATE()), 3, DATEADD(day, -1, GETDATE())),
(41, 13, 8, 19, DATEADD(day, -2, GETDATE()), DATEADD(day, 1, GETDATE()), 1, 3, 45, 0, 5, N'MS Word cơ bản', 2, N'Microsoft Office 365', 6, DATEADD(day, -1, GETDATE()), 2, GETDATE()),
(42, 14, 9, 20, DATEADD(day, -2, GETDATE()), DATEADD(day, 1, GETDATE()), 4, 6, 42, 0, 5, N'Excel Pivot Table', 2, N'Microsoft Office 365', 6, DATEADD(day, -1, GETDATE()), 2, GETDATE()),
(43, 19, 10, 27, DATEADD(day, -2, GETDATE()), DATEADD(day, 2, GETDATE()), 1, 3, 38, 0, 5, N'TOEIC Listening', 3, NULL, 7, DATEADD(day, -1, GETDATE()), 3, GETDATE()),
(44, 20, 11, 28, DATEADD(day, -2, GETDATE()), DATEADD(day, 2, GETDATE()), 4, 6, 40, 0, 5, N'TOEIC Speaking', 3, NULL, 7, DATEADD(day, -1, GETDATE()), 3, GETDATE()),
(45, 25, 12, 33, DATEADD(day, -2, GETDATE()), DATEADD(day, 1, GETDATE()), 1, 3, 32, 0, 5, N'Analog circuits', 2, N'Proteus', 6, DATEADD(day, -1, GETDATE()), 2, GETDATE()),
(46, 26, 13, 34, DATEADD(day, -2, GETDATE()), DATEADD(day, 1, GETDATE()), 4, 6, 30, 0, 5, N'Digital circuits', 2, N'Proteus', 6, DATEADD(day, -1, GETDATE()), 2, GETDATE()),
(47, 31, 14, 39, DATEADD(day, -2, GETDATE()), DATEADD(day, 2, GETDATE()), 1, 3, 28, 0, 5, N'AutoCAD 2D', 3, N'AutoCAD', 7, DATEADD(day, -1, GETDATE()), 3, GETDATE()),
(48, 32, 14, 40, DATEADD(day, -2, GETDATE()), DATEADD(day, 2, GETDATE()), 4, 6, 25, 0, 5, N'AutoCAD 3D', 3, N'AutoCAD', 7, DATEADD(day, -1, GETDATE()), 3, GETDATE()),

-- PDT đã duyệt nhưng chưa đến TTDT - TrangThai = 2 (PDTDongY)
(49, 5, 5, 13, DATEADD(day, -1, GETDATE()), DATEADD(day, 6, GETDATE()), 1, 3, 30, 0, 2, N'Network Lab', 4, N'Packet Tracer', 6, GETDATE(), NULL, NULL),
(50, 6, 4, 14, DATEADD(day, -1, GETDATE()), DATEADD(day, 6, GETDATE()), 4, 6, 38, 0, 2, N'OS Lab - Linux', 4, N'VMware, Ubuntu', 6, GETDATE(), NULL, NULL),

-- Thêm nhiều đăng ký cho các tuần tới
(51, 7, 3, 15, GETDATE(), DATEADD(day, 8, GETDATE()), 1, 3, 35, 0, 0, N'ASP.NET Core MVC', 2, N'VS 2022, SQL Server', NULL, NULL, NULL, NULL),
(52, 7, 3, 15, GETDATE(), DATEADD(day, 8, GETDATE()), 4, 6, 35, 0, 0, N'ASP.NET Core API', 2, N'VS 2022, Postman', NULL, NULL, NULL, NULL),
(53, 8, 4, 16, GETDATE(), DATEADD(day, 9, GETDATE()), 1, 3, 40, 0, 0, N'Flutter Development', 3, N'Flutter SDK, VS Code', NULL, NULL, NULL, NULL),
(54, 8, 4, 16, GETDATE(), DATEADD(day, 9, GETDATE()), 4, 6, 40, 0, 0, N'React Native', 3, N'Node.js, VS Code', NULL, NULL, NULL, NULL),
(55, 9, 5, 17, GETDATE(), DATEADD(day, 10, GETDATE()), 1, 3, 28, 1, 0, N'Penetration Testing', 4, N'Kali Linux, Metasploit', NULL, NULL, NULL, NULL),
(56, 10, 3, 18, GETDATE(), DATEADD(day, 10, GETDATE()), 4, 6, 35, 0, 0, N'Deep Learning', 4, N'Python, TensorFlow', NULL, NULL, NULL, NULL),
(57, 11, 4, 9, GETDATE(), DATEADD(day, 11, GETDATE()), 1, 3, 38, 0, 0, N'AWS Fundamentals', 5, N'AWS CLI', NULL, NULL, NULL, NULL),
(58, 12, 3, 10, GETDATE(), DATEADD(day, 11, GETDATE()), 4, 6, 40, 0, 0, N'Spark Processing', 5, N'Spark, Hadoop', NULL, NULL, NULL, NULL),
(59, 15, 8, 23, GETDATE(), DATEADD(day, 8, GETDATE()), 1, 3, 40, 0, 0, N'SAP Training', 2, N'SAP', NULL, NULL, NULL, NULL),
(60, 16, 9, 24, GETDATE(), DATEADD(day, 8, GETDATE()), 4, 6, 38, 0, 0, N'E-commerce Analytics', 2, N'Google Analytics', NULL, NULL, NULL, NULL),

-- Đăng ký ưu tiên cao
(61, 17, 8, 25, GETDATE(), DATEADD(day, 3, GETDATE()), 1, 3, 42, 2, 0, N'MIS Exam - Kiểm tra', 2, N'MS Office, SQL Server', NULL, NULL, NULL, NULL),
(62, 18, 9, 26, GETDATE(), DATEADD(day, 3, GETDATE()), 4, 6, 40, 2, 0, N'Analytics Exam - Thi cuối kỳ', 2, N'Power BI, Excel', NULL, NULL, NULL, NULL),

-- Đăng ký cho các khoa khác
(63, 21, 10, 30, GETDATE(), DATEADD(day, 7, GETDATE()), 1, 3, 35, 0, 0, N'Business Communication', 5, NULL, NULL, NULL, NULL, NULL),
(64, 22, 11, 31, GETDATE(), DATEADD(day, 7, GETDATE()), 4, 6, 38, 0, 0, N'IT English', 5, N'VS Code', NULL, NULL, NULL, NULL),
(65, 23, 10, 32, GETDATE(), DATEADD(day, 8, GETDATE()), 1, 3, 30, 0, 0, N'CAT Tools Training', 6, N'SDL Trados', NULL, NULL, NULL, NULL),
(66, 24, 11, 27, GETDATE(), DATEADD(day, 8, GETDATE()), 4, 6, 35, 0, 0, N'Japanese N5', 6, NULL, NULL, NULL, NULL, NULL),

-- Khoa Điện - Điện tử
(67, 27, 12, 35, GETDATE(), DATEADD(day, 4, GETDATE()), 1, 3, 30, 0, 0, N'Arduino Programming', 3, N'Arduino IDE', NULL, NULL, NULL, NULL),
(68, 28, 13, 36, GETDATE(), DATEADD(day, 4, GETDATE()), 4, 6, 28, 0, 0, N'PCB Design Altium', 3, N'Altium Designer', NULL, NULL, NULL, NULL),
(69, 29, 12, 37, GETDATE(), DATEADD(day, 5, GETDATE()), 1, 3, 32, 1, 0, N'Embedded Linux', 4, N'Linux, GCC', NULL, NULL, NULL, NULL),
(70, 30, 13, 38, GETDATE(), DATEADD(day, 5, GETDATE()), 4, 6, 30, 0, 0, N'IoT with ESP32', 4, N'Arduino IDE, PlatformIO', NULL, NULL, NULL, NULL),

-- Khoa Cơ khí
(71, 33, 14, 41, GETDATE(), DATEADD(day, 6, GETDATE()), 1, 3, 25, 0, 0, N'AutoCAD 3D Advanced', 5, N'AutoCAD', NULL, NULL, NULL, NULL),
(72, 34, 14, 42, GETDATE(), DATEADD(day, 6, GETDATE()), 4, 6, 28, 0, 0, N'SolidWorks Assembly', 5, N'SolidWorks', NULL, NULL, NULL, NULL),
(73, 35, 14, 43, GETDATE(), DATEADD(day, 7, GETDATE()), 1, 3, 25, 0, 0, N'CNC Programming', 6, N'Mastercam', NULL, NULL, NULL, NULL),
(74, 36, 12, 39, GETDATE(), DATEADD(day, 7, GETDATE()), 4, 6, 30, 0, 0, N'FEA Simulation', 6, N'ANSYS', NULL, NULL, NULL, NULL),

-- Khoa Xây dựng
(75, 37, 14, 44, GETDATE(), DATEADD(day, 9, GETDATE()), 1, 3, 28, 0, 0, N'Construction Drawing', 2, N'AutoCAD', NULL, NULL, NULL, NULL),
(76, 38, 14, 45, GETDATE(), DATEADD(day, 9, GETDATE()), 4, 6, 25, 0, 0, N'Architecture CAD', 2, N'AutoCAD Architecture', NULL, NULL, NULL, NULL),
(77, 39, 14, 46, GETDATE(), DATEADD(day, 10, GETDATE()), 1, 3, 30, 0, 0, N'Revit Basics', 3, N'Revit', NULL, NULL, NULL, NULL),
(78, 40, 8, 47, GETDATE(), DATEADD(day, 10, GETDATE()), 4, 6, 35, 0, 0, N'Cost Estimation', 3, N'MS Excel, Dự toán G8', NULL, NULL, NULL, NULL),

-- Khoa Du lịch
(79, 13, 9, 48, GETDATE(), DATEADD(day, 4, GETDATE()), 1, 3, 40, 0, 0, N'Office cho Du lịch', 3, N'MS Office 365', NULL, NULL, NULL, NULL),
(80, 14, 8, 49, GETDATE(), DATEADD(day, 4, GETDATE()), 4, 6, 42, 0, 0, N'Excel Du lịch', 3, N'MS Office 365', NULL, NULL, NULL, NULL),

-- Thêm các đăng ký có conflict (cùng phòng, cùng thời gian)
(81, 1, 3, 11, GETDATE(), DATEADD(day, 3, GETDATE()), 1, 3, 35, 0, 0, N'Conflict test - C++ khác GV', 2, N'VS 2022', NULL, NULL, NULL, NULL),
(82, 2, 3, 12, GETDATE(), DATEADD(day, 3, GETDATE()), 1, 3, 38, 1, 0, N'Conflict test - CTDL ưu tiên', 2, N'VS 2022', NULL, NULL, NULL, NULL),

-- Đăng ký đã duyệt xong cho tháng sau
(83, 1, 3, 9, DATEADD(day, -5, GETDATE()), DATEADD(day, 14, GETDATE()), 1, 3, 35, 0, 5, N'C++ Advanced', 2, N'VS 2022', 6, DATEADD(day, -4, GETDATE()), 2, DATEADD(day, -3, GETDATE())),
(84, 2, 4, 10, DATEADD(day, -5, GETDATE()), DATEADD(day, 14, GETDATE()), 4, 6, 38, 0, 5, N'Algorithm Contest', 2, N'VS 2022', 6, DATEADD(day, -4, GETDATE()), 2, DATEADD(day, -3, GETDATE())),
(85, 3, 3, 11, DATEADD(day, -5, GETDATE()), DATEADD(day, 15, GETDATE()), 1, 3, 40, 0, 5, N'Spring Boot', 3, N'IntelliJ IDEA', 7, DATEADD(day, -4, GETDATE()), 3, DATEADD(day, -3, GETDATE())),
(86, 4, 4, 12, DATEADD(day, -5, GETDATE()), DATEADD(day, 15, GETDATE()), 4, 6, 35, 0, 5, N'MongoDB Lab', 3, N'MongoDB Compass', 7, DATEADD(day, -4, GETDATE()), 3, DATEADD(day, -3, GETDATE())),
(87, 5, 5, 13, DATEADD(day, -4, GETDATE()), DATEADD(day, 16, GETDATE()), 1, 3, 30, 0, 5, N'Network Security', 4, N'Wireshark', 6, DATEADD(day, -3, GETDATE()), 2, DATEADD(day, -2, GETDATE())),
(88, 6, 4, 14, DATEADD(day, -4, GETDATE()), DATEADD(day, 16, GETDATE()), 4, 6, 38, 0, 5, N'Container Lab', 4, N'Docker', 6, DATEADD(day, -3, GETDATE()), 2, DATEADD(day, -2, GETDATE())),
(89, 13, 8, 19, DATEADD(day, -4, GETDATE()), DATEADD(day, 17, GETDATE()), 1, 3, 45, 0, 5, N'PowerPoint K23', 2, N'MS Office 365', 7, DATEADD(day, -3, GETDATE()), 3, DATEADD(day, -2, GETDATE())),
(90, 14, 9, 20, DATEADD(day, -4, GETDATE()), DATEADD(day, 17, GETDATE()), 4, 6, 42, 0, 5, N'Data Analysis K22', 2, N'MS Office 365, Power BI', 7, DATEADD(day, -3, GETDATE()), 3, DATEADD(day, -2, GETDATE())),

-- Thêm đăng ký với mức độ ưu tiên khác nhau
(91, 7, 3, 15, GETDATE(), DATEADD(day, 12, GETDATE()), 1, 3, 35, 0, 0, N'Web Normal Priority', 2, N'VS 2022', NULL, NULL, NULL, NULL),
(92, 7, 4, 15, GETDATE(), DATEADD(day, 12, GETDATE()), 4, 6, 35, 1, 0, N'Web High Priority', 2, N'VS 2022', NULL, NULL, NULL, NULL),
(93, 8, 4, 16, GETDATE(), DATEADD(day, 13, GETDATE()), 1, 3, 40, 2, 0, N'Mobile Exam - Urgent', 3, N'Android Studio', NULL, NULL, NULL, NULL),
(94, 9, 5, 17, GETDATE(), DATEADD(day, 13, GETDATE()), 4, 6, 28, 0, 0, N'Security Workshop', 3, N'Kali Linux', NULL, NULL, NULL, NULL),
(95, 10, 3, 18, GETDATE(), DATEADD(day, 14, GETDATE()), 1, 3, 35, 1, 0, N'AI Project Demo', 4, N'Python, TensorFlow', NULL, NULL, NULL, NULL),

-- Đăng ký vào ngày hôm nay (để test hiển thị dashboard)
(96, 1, 1, 9, DATEADD(day, -1, GETDATE()), GETDATE(), 7, 9, 35, 0, 5, N'Lab C++ chiều nay', 2, N'VS 2022', 6, GETDATE(), 2, GETDATE()),
(97, 13, 2, 19, DATEADD(day, -1, GETDATE()), GETDATE(), 1, 3, 40, 0, 5, N'Lab Word sáng nay', 2, N'MS Office', 6, GETDATE(), 2, GETDATE()),
(98, 19, 10, 27, DATEADD(day, -1, GETDATE()), GETDATE(), 4, 6, 38, 0, 5, N'English Lab trưa nay', 3, NULL, 7, GETDATE(), 3, GETDATE()),
(99, 25, 12, 33, DATEADD(day, -1, GETDATE()), GETDATE(), 7, 9, 30, 0, 5, N'Lab mạch chiều nay', 4, N'Proteus', 6, GETDATE(), 2, GETDATE()),
(100, 31, 14, 39, DATEADD(day, -1, GETDATE()), GETDATE(), 10, 12, 25, 0, 5, N'Lab CAD tối nay', 5, N'AutoCAD', 7, GETDATE(), 3, GETDATE());

SET IDENTITY_INSERT DangKyPhongs OFF;
GO

-- =============================================
-- 12. MƯỢN BÙ (15 yêu cầu)
-- =============================================
SET IDENTITY_INSERT MuonBus ON;
INSERT INTO MuonBus (MuonBuId, DangKyPhongMuonId, DangKyPhongTraId, TaiKhoanId, LyDo, TrangThai, NgayTao, NguoiDuyetId, NgayDuyet, GhiChu) VALUES
-- Mượn bù đã duyệt
(1, 37, 41, 9, N'GV nghỉ ốm buổi trước', 1, DATEADD(day, -2, GETDATE()), 2, DATEADD(day, -1, GETDATE()), N'Đã duyệt'),
(2, 38, 42, 10, N'Thiếu tiết thực hành', 1, DATEADD(day, -2, GETDATE()), 2, DATEADD(day, -1, GETDATE()), N'Đã duyệt'),
(3, 39, 43, 11, N'Bù lại buổi nghỉ lễ', 1, DATEADD(day, -1, GETDATE()), 3, GETDATE(), N'Đã duyệt'),

-- Mượn bù chờ duyệt
(4, 40, 44, 12, N'GV đi công tác', 0, GETDATE(), NULL, NULL, N'Chờ duyệt'),
(5, 45, 46, 33, N'Thiếu thiết bị buổi trước', 0, GETDATE(), NULL, NULL, N'Chờ duyệt'),
(6, 47, 48, 39, N'Máy chiếu hỏng', 0, GETDATE(), NULL, NULL, N'Chờ duyệt'),

-- Mượn bù bị từ chối
(7, 1, 2, 9, N'Test từ chối', 2, DATEADD(day, -5, GETDATE()), 2, DATEADD(day, -4, GETDATE()), N'Lịch trùng, không thể bù'),
(8, 3, 4, 11, N'Bù không hợp lệ', 2, DATEADD(day, -4, GETDATE()), 3, DATEADD(day, -3, GETDATE()), N'Vượt quá thời hạn mượn bù'),

-- Thêm mượn bù
(9, 83, 84, 9, N'Bù tháng sau', 0, GETDATE(), NULL, NULL, N'Chờ duyệt'),
(10, 85, 86, 11, N'GV hội thảo', 0, GETDATE(), NULL, NULL, N'Chờ duyệt'),
(11, 87, 88, 13, N'Phòng bảo trì', 1, DATEADD(day, -1, GETDATE()), 2, GETDATE(), N'Đã duyệt'),
(12, 89, 90, 19, N'Thiếu tiết', 1, DATEADD(day, -1, GETDATE()), 3, GETDATE(), N'Đã duyệt'),
(13, 5, 6, 13, N'Network down', 0, GETDATE(), NULL, NULL, N'Chờ duyệt'),
(14, 7, 8, 20, N'GV nghỉ phép', 0, GETDATE(), NULL, NULL, N'Chờ duyệt'),
(15, 9, 10, 33, N'Mất điện', 1, DATEADD(day, -2, GETDATE()), 2, DATEADD(day, -1, GETDATE()), N'Đã duyệt');
SET IDENTITY_INSERT MuonBus OFF;
GO

-- =============================================
-- 13. THÔNG BÁO (50 thông báo)
-- =============================================
SET IDENTITY_INSERT ThongBaos ON;

-- Thông báo hệ thống
INSERT INTO ThongBaos (ThongBaoId, TieuDe, NoiDung, LoaiThongBao, TaiKhoanGuiId, TaiKhoanNhanId, DaDoc, NgayTao, NgayDoc, DuongDanLienQuan) VALUES
-- Thông báo cho Admin
(1, N'Hệ thống khởi động', N'Hệ thống quản lý phòng máy đã khởi động thành công', 0, NULL, 1, 1, DATEADD(day, -7, GETDATE()), DATEADD(day, -7, GETDATE()), NULL),
(2, N'Backup hoàn tất', N'Backup database ngày 27/01/2026 hoàn tất', 0, NULL, 1, 1, DATEADD(day, -6, GETDATE()), DATEADD(day, -6, GETDATE()), NULL),
(3, N'Cảnh báo dung lượng', N'Dung lượng ổ đĩa server còn 20%', 0, NULL, 1, 0, DATEADD(day, -1, GETDATE()), NULL, NULL),

-- Thông báo duyệt đăng ký cho PDT
(4, N'Có đăng ký mới cần duyệt', N'Giảng viên Nguyễn Văn An đã đăng ký phòng PM-A201 ngày 06/02/2026', 1, 9, 6, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/11'),
(5, N'Có đăng ký mới cần duyệt', N'Giảng viên Nguyễn Văn An đã đăng ký phòng PM-A201 ngày 06/02/2026', 1, 9, 6, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/12'),
(6, N'Có đăng ký mới cần duyệt', N'Giảng viên Trần Thị Bình đã đăng ký phòng PM-A202 ngày 07/02/2026', 1, 10, 6, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/13'),
(7, N'Có đăng ký mới cần duyệt', N'Giảng viên Lê Văn Cường đã đăng ký phòng PM-A202 ngày 07/02/2026', 1, 11, 7, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/14'),
(8, N'Có đăng ký mới cần duyệt', N'Giảng viên Phạm Thị Dung đã đăng ký phòng PM-A201 ngày 08/02/2026', 1, 12, 7, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/15'),
(9, N'Có đăng ký ưu tiên cao', N'Giảng viên Vũ Văn Giang đã đăng ký phòng PM-A201 (ưu tiên cao)', 1, 15, 6, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/18'),
(10, N'Có đăng ký kiểm tra', N'Giảng viên Bùi Văn Hùng đã đăng ký phòng PM-A203 cho kỳ thi', 1, 17, 6, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/20'),

-- Thông báo cho TTDT
(11, N'Có đăng ký chờ duyệt TTDT', N'Đăng ký Lab Machine Learning cần duyệt TTDT', 1, 6, 2, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/21'),
(12, N'Có đăng ký chờ duyệt TTDT', N'Đăng ký Lab Cloud Computing cần duyệt TTDT', 1, 6, 2, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/22'),
(13, N'Có đăng ký chờ duyệt TTDT', N'Đăng ký Lab Big Data cần duyệt TTDT', 1, 7, 2, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/23'),
(14, N'Có đăng ký chờ duyệt TTDT', N'Đăng ký Tin học văn phòng K22 cần duyệt TTDT', 1, 6, 3, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/24'),
(15, N'Có đăng ký chờ duyệt TTDT', N'Đăng ký Excel nâng cao K21 cần duyệt TTDT', 1, 6, 3, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/25'),

-- Thông báo phản hồi cho giảng viên (đã đọc)
(16, N'Đăng ký đã được PDT duyệt', N'Đăng ký phòng PM-A201 ngày 04/02/2026 đã được PDT duyệt', 2, 6, 9, 1, DATEADD(day, -2, GETDATE()), DATEADD(day, -1, GETDATE()), N'/DangKyPhong/ChiTiet/37'),
(17, N'Đăng ký đã được TTDT duyệt', N'Đăng ký phòng PM-A201 ngày 04/02/2026 đã được TTDT duyệt. Bạn có thể sử dụng phòng.', 2, 2, 9, 1, DATEADD(day, -1, GETDATE()), GETDATE(), N'/DangKyPhong/ChiTiet/37'),
(18, N'Đăng ký đã được PDT duyệt', N'Đăng ký phòng PM-A202 ngày 04/02/2026 đã được PDT duyệt', 2, 6, 10, 1, DATEADD(day, -2, GETDATE()), DATEADD(day, -1, GETDATE()), N'/DangKyPhong/ChiTiet/38'),
(19, N'Đăng ký đã được TTDT duyệt', N'Đăng ký phòng PM-A202 ngày 04/02/2026 đã được TTDT duyệt', 2, 2, 10, 1, DATEADD(day, -1, GETDATE()), GETDATE(), N'/DangKyPhong/ChiTiet/38'),
(20, N'Đăng ký đã được PDT duyệt', N'Đăng ký phòng PM-A201 ngày 05/02/2026 đã được PDT duyệt', 2, 7, 11, 1, DATEADD(day, -2, GETDATE()), DATEADD(day, -1, GETDATE()), N'/DangKyPhong/ChiTiet/39'),

-- Thông báo phản hồi cho giảng viên (chưa đọc)
(21, N'Đăng ký đã được TTDT duyệt', N'Đăng ký phòng PM-A201 ngày 05/02/2026 đã được TTDT duyệt', 2, 3, 11, 0, DATEADD(day, -1, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/39'),
(22, N'Đăng ký đã được PDT duyệt', N'Đăng ký phòng PM-A202 ngày 05/02/2026 đã được PDT duyệt', 2, 7, 12, 0, DATEADD(day, -2, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/40'),
(23, N'Đăng ký đã được TTDT duyệt', N'Đăng ký phòng PM-A202 ngày 05/02/2026 đã được TTDT duyệt', 2, 3, 12, 0, DATEADD(day, -1, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/40'),

-- Thông báo từ chối
(24, N'Đăng ký bị từ chối', N'Đăng ký phòng PM-A101 ngày 05/02/2026 bị PDT từ chối. Lý do: Số lượng sinh viên vượt quá sức chứa phòng', 3, 6, 15, 0, DATEADD(day, -4, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/31'),
(25, N'Đăng ký bị từ chối', N'Đăng ký phòng PM-A102 ngày 04/02/2026 bị PDT từ chối. Lý do: Trùng lịch bảo trì phòng máy', 3, 7, 16, 0, DATEADD(day, -3, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/32'),
(26, N'Đăng ký bị TTDT từ chối', N'Đăng ký phòng PM-A203 ngày 04/02/2026 bị TTDT từ chối. Lý do: Phần mềm Kali Linux chưa được cài đặt', 3, 2, 17, 0, DATEADD(day, -4, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/33'),
(27, N'Đăng ký bị TTDT từ chối', N'Đăng ký phòng PM-A201 ngày 05/02/2026 bị TTDT từ chối. Lý do: Phòng không đủ GPU cho TensorFlow', 3, 3, 18, 0, DATEADD(day, -3, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/34'),

-- Thông báo bảo trì
(28, N'Lịch bảo trì phòng máy', N'Phòng PM-A101 sẽ bảo trì định kỳ vào ngày 17/02/2026. Vui lòng không đăng ký vào ngày này.', 4, 2, NULL, 0, GETDATE(), NULL, NULL),
(29, N'Bảo trì hoàn tất', N'Phòng PM-A301 đã hoàn tất bảo trì và sẵn sàng sử dụng', 4, 3, NULL, 0, DATEADD(day, -7, GETDATE()), NULL, NULL),
(30, N'Cảnh báo thiết bị', N'5 máy tại PM-A102 cần thay thế nguồn', 4, 5, 2, 0, DATEADD(day, -2, GETDATE()), NULL, NULL),

-- Thông báo nhắc nhở buổi học
(31, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành C++ tại PM-A201 vào ngày 04/02/2026, tiết 1-3', 5, NULL, 9, 0, DATEADD(day, -1, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/37'),
(32, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành CTDL tại PM-A202 vào ngày 04/02/2026, tiết 4-6', 5, NULL, 10, 0, DATEADD(day, -1, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/38'),
(33, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành Java tại PM-A201 vào ngày 05/02/2026, tiết 1-3', 5, NULL, 11, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/39'),
(34, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành Database tại PM-A202 vào ngày 05/02/2026, tiết 4-6', 5, NULL, 12, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/40'),
(35, N'Nhắc nhở buổi thực hành ngày mai', N'Bạn có buổi thực hành Word tại PM-B101 vào ngày 04/02/2026, tiết 1-3', 5, NULL, 19, 0, DATEADD(day, -1, GETDATE()), NULL, N'/DangKyPhong/ChiTiet/41'),

-- Thông báo mượn bù
(36, N'Có yêu cầu mượn bù mới', N'Giảng viên Nguyễn Văn An yêu cầu mượn bù buổi thực hành C++', 6, 9, 2, 0, DATEADD(day, -2, GETDATE()), NULL, N'/MuonBu/ChiTiet/1'),
(37, N'Yêu cầu mượn bù đã duyệt', N'Yêu cầu mượn bù của bạn đã được duyệt', 6, 2, 9, 1, DATEADD(day, -1, GETDATE()), GETDATE(), N'/MuonBu/ChiTiet/1'),
(38, N'Có yêu cầu mượn bù mới', N'Giảng viên Trần Thị Bình yêu cầu mượn bù buổi CTDL', 6, 10, 2, 0, DATEADD(day, -2, GETDATE()), NULL, N'/MuonBu/ChiTiet/2'),
(39, N'Yêu cầu mượn bù đã duyệt', N'Yêu cầu mượn bù của bạn đã được duyệt', 6, 2, 10, 1, DATEADD(day, -1, GETDATE()), GETDATE(), N'/MuonBu/ChiTiet/2'),
(40, N'Có yêu cầu mượn bù mới', N'Giảng viên Phạm Thị Dung yêu cầu mượn bù buổi Database', 6, 12, 2, 0, GETDATE(), NULL, N'/MuonBu/ChiTiet/4'),

-- Thông báo conflict lịch
(41, N'Cảnh báo trùng lịch', N'Đăng ký của bạn tại PM-A201 ngày 06/02/2026 tiết 1-3 có thể bị trùng với đăng ký khác', 7, NULL, 9, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/11'),
(42, N'Cảnh báo trùng lịch', N'Đăng ký của bạn tại PM-A201 ngày 06/02/2026 tiết 1-3 có thể bị trùng', 7, NULL, 11, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/81'),
(43, N'Cảnh báo trùng lịch', N'Đăng ký của bạn tại PM-A201 ngày 06/02/2026 tiết 1-3 có thể bị trùng', 7, NULL, 12, 0, GETDATE(), NULL, N'/DangKyPhong/ChiTiet/82'),

-- Thông báo SLA
(44, N'Cảnh báo SLA', N'Có 3 đăng ký chờ PDT duyệt quá 24h', 8, NULL, 6, 0, GETDATE(), NULL, N'/SLA/Dashboard'),
(45, N'Cảnh báo SLA', N'Có 2 đăng ký chờ TTDT duyệt quá 48h', 8, NULL, 2, 0, GETDATE(), NULL, N'/SLA/Dashboard'),

-- Thông báo chung cho tất cả GV
(46, N'Thông báo nghỉ Tết', N'Thông báo lịch nghỉ Tết Nguyên Đán 2026: Từ 26/01 đến 02/02/2026', 0, 1, NULL, 0, DATEADD(day, -10, GETDATE()), NULL, NULL),
(47, N'Hướng dẫn sử dụng hệ thống', N'Đã cập nhật hướng dẫn sử dụng hệ thống mới. Vui lòng đọc kỹ trước khi sử dụng.', 0, 1, NULL, 0, DATEADD(day, -5, GETDATE()), NULL, N'/Home/Guide'),
(48, N'Cập nhật phần mềm mới', N'Đã cài đặt Visual Studio 2022 v17.9 cho các phòng CNTT', 0, 2, NULL, 0, DATEADD(day, -3, GETDATE()), NULL, NULL),
(49, N'Quy định mới', N'Quy định mới về đăng ký phòng máy: Phải đăng ký trước ít nhất 3 ngày', 0, 1, NULL, 0, DATEADD(day, -2, GETDATE()), NULL, NULL),
(50, N'Bảo trì hệ thống', N'Hệ thống sẽ bảo trì vào 22h ngày 10/02/2026. Thời gian dự kiến: 2 tiếng.', 0, 1, NULL, 0, GETDATE(), NULL, NULL);

SET IDENTITY_INSERT ThongBaos OFF;
GO

-- =============================================
-- 14. TEMPLATE ĐĂNG KÝ (10 templates)
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
PRINT N''
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
