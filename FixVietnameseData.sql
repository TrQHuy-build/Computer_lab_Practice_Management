-- Fix Vietnamese Data với NVARCHAR encoding đúng
-- Chạy script này trong SQL Server Management Studio hoặc Azure Data Studio

USE QL_PHONG_TH;
GO

-- Xóa dữ liệu cũ theo thứ tự FK
DELETE FROM LichSuDangKys;
DELETE FROM ThongBaos;
DELETE FROM TemplateDangKys;
DELETE FROM YeuCauCaiDatPhanMems;
DELETE FROM MuonBus;
DELETE FROM DangKyPhongs;
DELETE FROM PhongMayPhanMems;
DELETE FROM BaoTriPhongs;
DELETE FROM TaiKhoans;
DELETE FROM NhanViens;
DELETE FROM HocPhans;
DELETE FROM PhanMems;
DELETE FROM PhongMays;
DELETE FROM PhongBans;
DELETE FROM VaiTros;
DELETE FROM Quyens;
GO

-- Reset Identity
DBCC CHECKIDENT ('LichSuDangKys', RESEED, 0);
DBCC CHECKIDENT ('ThongBaos', RESEED, 0);
DBCC CHECKIDENT ('TemplateDangKys', RESEED, 0);
DBCC CHECKIDENT ('YeuCauCaiDatPhanMems', RESEED, 0);
DBCC CHECKIDENT ('MuonBus', RESEED, 0);
DBCC CHECKIDENT ('DangKyPhongs', RESEED, 0);
DBCC CHECKIDENT ('BaoTriPhongs', RESEED, 0);
DBCC CHECKIDENT ('TaiKhoans', RESEED, 0);
DBCC CHECKIDENT ('NhanViens', RESEED, 0);
DBCC CHECKIDENT ('HocPhans', RESEED, 0);
DBCC CHECKIDENT ('PhanMems', RESEED, 0);
DBCC CHECKIDENT ('PhongMays', RESEED, 0);
DBCC CHECKIDENT ('PhongBans', RESEED, 0);
DBCC CHECKIDENT ('VaiTros', RESEED, 0);
DBCC CHECKIDENT ('Quyens', RESEED, 0);
GO

-- =============================================
-- 1. QUYỀN
-- =============================================
SET IDENTITY_INSERT Quyens ON;
INSERT INTO Quyens (QuyenId, TenQuyen, MoTa) VALUES
(1, N'QuanLyNguoiDung', N'Quản lý người dùng hệ thống'),
(2, N'QuanLyPhongMay', N'Quản lý phòng máy'),
(3, N'QuanLyPhanMem', N'Quản lý phần mềm'),
(4, N'DuyetDangKy', N'Duyệt đăng ký phòng'),
(5, N'DangKyPhong', N'Đăng ký sử dụng phòng'),
(6, N'XemBaoCao', N'Xem báo cáo thống kê'),
(7, N'QuanLyBaoTri', N'Quản lý bảo trì phòng máy'),
(8, N'QuanLyHocPhan', N'Quản lý học phần'),
(9, N'DuyetMuonBu', N'Duyệt yêu cầu mượn bù'),
(10, N'QuanLyHeThong', N'Quản lý cấu hình hệ thống');
SET IDENTITY_INSERT Quyens OFF;
GO

-- =============================================
-- 2. VAI TRÒ
-- =============================================
SET IDENTITY_INSERT VaiTros ON;
INSERT INTO VaiTros (VaiTroId, TenVaiTro, MoTa) VALUES
(1, N'Admin', N'Quản trị viên hệ thống'),
(2, N'QuanLyTrungTam', N'Quản lý trung tâm đào tạo'),
(3, N'KyThuatVien', N'Kỹ thuật viên phòng máy'),
(4, N'PhongDaoTao', N'Cán bộ phòng đào tạo'),
(5, N'GiaoVien', N'Giảng viên');
SET IDENTITY_INSERT VaiTros OFF;
GO

-- =============================================
-- 3. PHÒNG BAN
-- =============================================
SET IDENTITY_INSERT PhongBans ON;
INSERT INTO PhongBans (PhongBanId, TenPhongBan, MoTa) VALUES
(1, N'Ban Giám đốc', N'Ban lãnh đạo trung tâm'),
(2, N'Trung tâm Đào tạo', N'Trung tâm quản lý đào tạo'),
(3, N'Phòng Kỹ thuật', N'Phòng kỹ thuật và bảo trì'),
(4, N'Phòng Đào tạo', N'Phòng quản lý đào tạo'),
(5, N'Khoa CNTT', N'Khoa Công nghệ Thông tin'),
(6, N'Khoa Điện tử', N'Khoa Điện tử Viễn thông'),
(7, N'Khoa Kinh tế', N'Khoa Kinh tế'),
(8, N'Khoa Cơ khí', N'Khoa Cơ khí'),
(9, N'Phòng Hành chính', N'Phòng Hành chính Tổng hợp'),
(10, N'Phòng Tài chính', N'Phòng Tài chính Kế toán');
SET IDENTITY_INSERT PhongBans OFF;
GO

-- =============================================
-- 4. NHÂN VIÊN
-- =============================================
SET IDENTITY_INSERT NhanViens ON;
INSERT INTO NhanViens (MaNhanVien, HoTen, SoDienThoai, Email, PhongBanId) VALUES
(1, N'Nguyễn Văn Admin', N'0901234567', N'admin@edu.vn', 1),
(2, N'Trần Thị Quản Lý', N'0901234568', N'quanly@edu.vn', 2),
(3, N'Lê Văn Kỹ Thuật', N'0901234569', N'kythuat@edu.vn', 3),
(4, N'Phạm Thị Hỗ Trợ', N'0901234570', N'hotro@edu.vn', 3),
(5, N'Hoàng Văn Bảo Trì', N'0901234571', N'baotri@edu.vn', 3),
(6, N'Ngô Thị PDT 1', N'0901234572', N'pdt1@edu.vn', 4),
(7, N'Đặng Văn PDT 2', N'0901234573', N'pdt2@edu.vn', 4),
(8, N'Vũ Thị PDT 3', N'0901234574', N'pdt3@edu.vn', 4),
(9, N'Nguyễn Văn An', N'0912345001', N'nva@edu.vn', 5),
(10, N'Trần Thị Bình', N'0912345002', N'ttb@edu.vn', 5),
(11, N'Lê Văn Cường', N'0912345003', N'lvc@edu.vn', 5),
(12, N'Phạm Thị Dung', N'0912345004', N'ptd@edu.vn', 5),
(13, N'Hoàng Văn Em', N'0912345005', N'hve@edu.vn', 5),
(14, N'Ngô Thị Phương', N'0912345006', N'ntp@edu.vn', 5),
(15, N'Đặng Văn Giang', N'0912345007', N'dvg@edu.vn', 5),
(16, N'Vũ Thị Hạnh', N'0912345008', N'vth@edu.vn', 5),
(17, N'Bùi Văn Ích', N'0912345009', N'bvi@edu.vn', 6),
(18, N'Đinh Thị Kim', N'0912345010', N'dtk@edu.vn', 6),
(19, N'Trịnh Văn Long', N'0912345011', N'tvl@edu.vn', 6),
(20, N'Mai Thị Mỹ', N'0912345012', N'mtm@edu.vn', 6),
(21, N'Dương Văn Nam', N'0912345013', N'dvn@edu.vn', 6),
(22, N'Lý Thị Oanh', N'0912345014', N'lto@edu.vn', 6),
(23, N'Châu Văn Phúc', N'0912345015', N'cvp@edu.vn', 6),
(24, N'Hồ Thị Quỳnh', N'0912345016', N'htq@edu.vn', 6),
(25, N'Tạ Văn Rạng', N'0912345017', N'tvr@edu.vn', 7),
(26, N'Đỗ Thị Sen', N'0912345018', N'dts@edu.vn', 7),
(27, N'Bạch Văn Tùng', N'0912345019', N'bvt@edu.vn', 7),
(28, N'Đoàn Thị Uyên', N'0912345020', N'dtu@edu.vn', 7),
(29, N'Nguyễn Văn Vinh', N'0912345021', N'nvv@edu.vn', 7),
(30, N'Trần Thị Xuân', N'0912345022', N'ttx@edu.vn', 7),
(31, N'Lê Văn Yên', N'0912345023', N'lvy@edu.vn', 7),
(32, N'Phạm Thị Ánh', N'0912345024', N'pta@edu.vn', 7),
(33, N'Hoàng Văn Bách', N'0912345025', N'hvb@edu.vn', 8),
(34, N'Ngô Thị Châu', N'0912345026', N'ntc@edu.vn', 8),
(35, N'Đặng Văn Điền', N'0912345027', N'dvd@edu.vn', 8),
(36, N'Vũ Thị Én', N'0912345028', N'vte@edu.vn', 8),
(37, N'Bùi Văn Phong', N'0912345029', N'bvp@edu.vn', 8),
(38, N'Đinh Thị Gấm', N'0912345030', N'dtg@edu.vn', 8),
(39, N'Trịnh Văn Hải', N'0912345031', N'tvh@edu.vn', 8),
(40, N'Mai Thị Ích', N'0912345032', N'mti@edu.vn', 8),
(41, N'Dương Văn Kiên', N'0912345033', N'dvk@edu.vn', 5),
(42, N'Lý Thị Lan', N'0912345034', N'ltl@edu.vn', 5),
(43, N'Châu Văn Minh', N'0912345035', N'cvm@edu.vn', 5),
(44, N'Hồ Thị Ngọc', N'0912345036', N'htn@edu.vn', 5),
(45, N'Tạ Văn Ơn', N'0912345037', N'tvo@edu.vn', 6),
(46, N'Đỗ Thị Phượng', N'0912345038', N'dtp@edu.vn', 6),
(47, N'Bạch Văn Quân', N'0912345039', N'bvq@edu.vn', 6),
(48, N'Đoàn Thị Rồng', N'0912345040', N'dtr@edu.vn', 7),
(49, N'Cao Văn Sơn', N'0912345041', N'cvs@edu.vn', 7),
(50, N'Tôn Thị Thảo', N'0912345042', N'ttt@edu.vn', 8);
SET IDENTITY_INSERT NhanViens OFF;
GO

-- =============================================
-- 5. TÀI KHOẢN
-- =============================================
SET IDENTITY_INSERT TaiKhoans ON;
INSERT INTO TaiKhoans (TaiKhoanId, TenDangNhap, MatKhau, MaNhanVien, VaiTroId, IsActive, NgayTao) VALUES
(1, N'admin', N'123456', 1, 1, 1, GETDATE()),
(2, N'quanly.tt', N'123456', 2, 2, 1, GETDATE()),
(3, N'kythuat.tt', N'123456', 3, 3, 1, GETDATE()),
(4, N'hotro.tt', N'123456', 4, 3, 1, GETDATE()),
(5, N'baotri.tt', N'123456', 5, 3, 1, GETDATE()),
(6, N'pdt1', N'123456', 6, 4, 1, GETDATE()),
(7, N'pdt2', N'123456', 7, 4, 1, GETDATE()),
(8, N'pdt3', N'123456', 8, 4, 1, GETDATE()),
(9, N'gv.nva', N'123456', 9, 5, 1, GETDATE()),
(10, N'gv.ttb', N'123456', 10, 5, 1, GETDATE()),
(11, N'gv.lvc', N'123456', 11, 5, 1, GETDATE()),
(12, N'gv.ptd', N'123456', 12, 5, 1, GETDATE()),
(13, N'gv.hve', N'123456', 13, 5, 1, GETDATE()),
(14, N'gv.ntp', N'123456', 14, 5, 1, GETDATE()),
(15, N'gv.dvg', N'123456', 15, 5, 1, GETDATE()),
(16, N'gv.vth', N'123456', 16, 5, 1, GETDATE()),
(17, N'gv.bvi', N'123456', 17, 5, 1, GETDATE()),
(18, N'gv.dtk', N'123456', 18, 5, 1, GETDATE()),
(19, N'gv.tvl', N'123456', 19, 5, 1, GETDATE()),
(20, N'gv.mtm', N'123456', 20, 5, 1, GETDATE()),
(21, N'gv.dvn', N'123456', 21, 5, 1, GETDATE()),
(22, N'gv.lto', N'123456', 22, 5, 1, GETDATE()),
(23, N'gv.cvp', N'123456', 23, 5, 1, GETDATE()),
(24, N'gv.htq', N'123456', 24, 5, 1, GETDATE()),
(25, N'gv.tvr', N'123456', 25, 5, 1, GETDATE()),
(26, N'gv.dts', N'123456', 26, 5, 1, GETDATE()),
(27, N'gv.bvt', N'123456', 27, 5, 1, GETDATE()),
(28, N'gv.dtu', N'123456', 28, 5, 1, GETDATE()),
(29, N'gv.nvv', N'123456', 29, 5, 1, GETDATE()),
(30, N'gv.ttx', N'123456', 30, 5, 1, GETDATE()),
(31, N'gv.lvy', N'123456', 31, 5, 1, GETDATE()),
(32, N'gv.pta', N'123456', 32, 5, 1, GETDATE()),
(33, N'gv.hvb', N'123456', 33, 5, 1, GETDATE()),
(34, N'gv.ntc', N'123456', 34, 5, 1, GETDATE()),
(35, N'gv.dvd', N'123456', 35, 5, 1, GETDATE()),
(36, N'gv.vte', N'123456', 36, 5, 1, GETDATE()),
(37, N'gv.bvp', N'123456', 37, 5, 1, GETDATE()),
(38, N'gv.dtg', N'123456', 38, 5, 1, GETDATE()),
(39, N'gv.tvh', N'123456', 39, 5, 1, GETDATE()),
(40, N'gv.mti', N'123456', 40, 5, 1, GETDATE()),
(41, N'gv.dvk', N'123456', 41, 5, 1, GETDATE()),
(42, N'gv.ltl', N'123456', 42, 5, 1, GETDATE()),
(43, N'gv.cvm', N'123456', 43, 5, 1, GETDATE()),
(44, N'gv.htn', N'123456', 44, 5, 1, GETDATE()),
(45, N'gv.tvo', N'123456', 45, 5, 1, GETDATE()),
(46, N'gv.dtp', N'123456', 46, 5, 1, GETDATE()),
(47, N'gv.bvq', N'123456', 47, 5, 1, GETDATE()),
(48, N'gv.dtr', N'123456', 48, 5, 1, GETDATE()),
(49, N'gv.cvs', N'123456', 49, 5, 1, GETDATE()),
(50, N'gv.ttt', N'123456', 50, 5, 1, GETDATE());
SET IDENTITY_INSERT TaiKhoans OFF;
GO

-- =============================================
-- 6. PHÒNG MÁY
-- =============================================
SET IDENTITY_INSERT PhongMays ON;
INSERT INTO PhongMays (MaPhong, TenPhong, SoLuongMay, SoMayHong, TrangThai, MoTa) VALUES
(1, N'PM01 - Phòng thực hành 1', 50, 2, 1, N'Phòng máy dành cho lập trình cơ bản'),
(2, N'PM02 - Phòng thực hành 2', 45, 0, 1, N'Phòng máy dành cho cơ sở dữ liệu'),
(3, N'PM03 - Phòng thực hành 3', 40, 3, 1, N'Phòng máy dành cho mạng máy tính'),
(4, N'PM04 - Phòng thực hành 4', 50, 1, 1, N'Phòng máy dành cho phát triển web'),
(5, N'PM05 - Phòng thực hành 5', 35, 5, 2, N'Đang bảo trì - thay thế máy hỏng'),
(6, N'PM06 - Phòng thực hành 6', 48, 0, 1, N'Phòng máy dành cho đồ họa'),
(7, N'PM07 - Phòng thực hành 7', 42, 4, 2, N'Đang nâng cấp RAM'),
(8, N'PM08 - Phòng thực hành 8', 50, 0, 1, N'Phòng máy dành cho AI/ML'),
(9, N'PM09 - Phòng thực hành 9', 38, 2, 1, N'Phòng máy dành cho mobile'),
(10, N'PM10 - Phòng thực hành 10', 45, 1, 1, N'Phòng máy đa năng'),
(11, N'PM11 - Phòng thực hành 11', 40, 0, 1, N'Phòng máy dành cho IoT'),
(12, N'PM12 - Phòng thực hành 12', 50, 2, 1, N'Phòng máy dành cho game dev'),
(13, N'PM13 - Phòng thực hành 13', 35, 0, 1, N'Phòng máy dành cho bảo mật'),
(14, N'PM14 - Phòng thực hành 14', 48, 3, 1, N'Phòng máy dành cho DevOps'),
(15, N'PM15 - Phòng thực hành 15', 42, 1, 1, N'Phòng máy dành cho cloud');
SET IDENTITY_INSERT PhongMays OFF;
GO

-- =============================================
-- 7. PHẦN MỀM
-- =============================================
SET IDENTITY_INSERT PhanMems ON;
INSERT INTO PhanMems (PhanMemId, TenPhanMem, PhienBan, MoTa, NhaSanXuat, LoaiPhanMem) VALUES
(1, N'Visual Studio 2022', N'17.8', N'IDE phát triển .NET', N'Microsoft', N'IDE'),
(2, N'Visual Studio Code', N'1.85', N'Code editor đa năng', N'Microsoft', N'Editor'),
(3, N'SQL Server 2022', N'16.0', N'Hệ quản trị CSDL', N'Microsoft', N'Database'),
(4, N'MySQL Workbench', N'8.0', N'Công cụ quản lý MySQL', N'Oracle', N'Database'),
(5, N'IntelliJ IDEA', N'2023.3', N'IDE phát triển Java', N'JetBrains', N'IDE'),
(6, N'PyCharm', N'2023.3', N'IDE phát triển Python', N'JetBrains', N'IDE'),
(7, N'Node.js', N'20.10', N'Runtime JavaScript', N'OpenJS Foundation', N'Runtime'),
(8, N'Python', N'3.12', N'Ngôn ngữ lập trình Python', N'Python Software Foundation', N'Language'),
(9, N'Java JDK', N'21', N'Java Development Kit', N'Oracle', N'SDK'),
(10, N'.NET SDK', N'8.0', N'.NET Development Kit', N'Microsoft', N'SDK'),
(11, N'Git', N'2.43', N'Version Control System', N'Git', N'VCS'),
(12, N'Docker Desktop', N'4.26', N'Container platform', N'Docker', N'DevOps'),
(13, N'Postman', N'10.21', N'API testing tool', N'Postman', N'Testing'),
(14, N'Adobe Photoshop', N'2024', N'Phần mềm chỉnh sửa ảnh', N'Adobe', N'Design'),
(15, N'Adobe Illustrator', N'2024', N'Phần mềm thiết kế vector', N'Adobe', N'Design'),
(16, N'Figma', N'Latest', N'UI/UX Design Tool', N'Figma', N'Design'),
(17, N'Android Studio', N'2023.1', N'IDE phát triển Android', N'Google', N'IDE'),
(18, N'Xcode', N'15.1', N'IDE phát triển iOS', N'Apple', N'IDE'),
(19, N'Unity', N'2022.3', N'Game Engine', N'Unity Technologies', N'Game'),
(20, N'Unreal Engine', N'5.3', N'Game Engine', N'Epic Games', N'Game'),
(21, N'MATLAB', N'R2023b', N'Phần mềm tính toán', N'MathWorks', N'Math'),
(22, N'Wireshark', N'4.2', N'Network analyzer', N'Wireshark Foundation', N'Network'),
(23, N'Cisco Packet Tracer', N'8.2', N'Network simulator', N'Cisco', N'Network'),
(24, N'VMware Workstation', N'17', N'Virtualization', N'VMware', N'Virtualization'),
(25, N'VirtualBox', N'7.0', N'Virtualization', N'Oracle', N'Virtualization'),
(26, N'Microsoft Office', N'365', N'Bộ công cụ văn phòng', N'Microsoft', N'Office'),
(27, N'AutoCAD', N'2024', N'Phần mềm thiết kế kỹ thuật', N'Autodesk', N'CAD'),
(28, N'SolidWorks', N'2024', N'Phần mềm thiết kế 3D', N'Dassault', N'CAD'),
(29, N'Blender', N'4.0', N'Phần mềm 3D miễn phí', N'Blender Foundation', N'3D'),
(30, N'Tableau', N'2023.3', N'Data visualization', N'Salesforce', N'Analytics');
SET IDENTITY_INSERT PhanMems OFF;
GO

-- =============================================
-- 8. HỌC PHẦN
-- =============================================
SET IDENTITY_INSERT HocPhans ON;
INSERT INTO HocPhans (HocPhanId, MaHocPhan, TenHocPhan, SoTinChi, PhongBanId, TrangThaiHoatDong) VALUES
(1, N'CS101', N'Lập trình C cơ bản', 3, 5, 1),
(2, N'CS102', N'Lập trình Python', 3, 5, 1),
(3, N'CS103', N'Lập trình hướng đối tượng', 4, 5, 1),
(4, N'CS104', N'Cấu trúc dữ liệu và giải thuật', 4, 5, 1),
(5, N'CS105', N'Cơ sở dữ liệu', 3, 5, 1),
(6, N'CS106', N'Mạng máy tính', 3, 5, 1),
(7, N'CS107', N'Hệ điều hành', 3, 5, 1),
(8, N'CS108', N'An toàn thông tin', 3, 5, 1),
(9, N'CS109', N'Phát triển ứng dụng Web', 4, 5, 1),
(10, N'CS110', N'Phát triển ứng dụng Mobile', 4, 5, 1),
(11, N'CS111', N'Trí tuệ nhân tạo', 3, 5, 1),
(12, N'CS112', N'Machine Learning', 3, 5, 1),
(13, N'CS113', N'Deep Learning', 3, 5, 1),
(14, N'CS114', N'Xử lý ảnh số', 3, 5, 1),
(15, N'CS115', N'Phát triển game', 4, 5, 1),
(16, N'EE201', N'Điện tử cơ bản', 3, 6, 1),
(17, N'EE202', N'Vi xử lý', 4, 6, 1),
(18, N'EE203', N'Hệ thống nhúng', 4, 6, 1),
(19, N'EE204', N'IoT và ứng dụng', 3, 6, 1),
(20, N'EE205', N'Xử lý tín hiệu số', 3, 6, 1),
(21, N'BA301', N'Tin học văn phòng', 2, 7, 1),
(22, N'BA302', N'Phân tích dữ liệu', 3, 7, 1),
(23, N'BA303', N'Hệ thống thông tin quản lý', 3, 7, 1),
(24, N'BA304', N'Thương mại điện tử', 3, 7, 1),
(25, N'ME401', N'AutoCAD cơ bản', 2, 8, 1),
(26, N'ME402', N'SolidWorks', 3, 8, 1),
(27, N'ME403', N'Thiết kế 3D với Blender', 3, 8, 1),
(28, N'CS116', N'DevOps và CI/CD', 3, 5, 1),
(29, N'CS117', N'Cloud Computing', 3, 5, 1),
(30, N'CS118', N'Blockchain cơ bản', 3, 5, 1),
(31, N'CS119', N'Kiểm thử phần mềm', 3, 5, 1),
(32, N'CS120', N'Quản lý dự án phần mềm', 3, 5, 1),
(33, N'CS121', N'UI/UX Design', 3, 5, 1),
(34, N'CS122', N'Đồ họa máy tính', 3, 5, 1),
(35, N'EE206', N'Robotics cơ bản', 3, 6, 1),
(36, N'EE207', N'PLC và tự động hóa', 4, 6, 1),
(37, N'BA305', N'Business Intelligence', 3, 7, 1),
(38, N'BA306', N'Data Mining', 3, 7, 1),
(39, N'ME404', N'CAD/CAM', 4, 8, 1),
(40, N'CS123', N'Thực tập doanh nghiệp', 6, 5, 1);
SET IDENTITY_INSERT HocPhans OFF;
GO

-- =============================================
-- 9. PHÒNG MÁY - PHẦN MỀM
-- =============================================
INSERT INTO PhongMayPhanMems (PhongMayId, PhanMemId, NgayCaiDat, GhiChu) VALUES
(1, 1, GETDATE(), N'Cài đặt mới'), (1, 2, GETDATE(), NULL), (1, 8, GETDATE(), NULL), (1, 10, GETDATE(), NULL), (1, 11, GETDATE(), NULL),
(2, 3, GETDATE(), N'Cài đặt mới'), (2, 4, GETDATE(), NULL), (2, 2, GETDATE(), NULL), (2, 11, GETDATE(), NULL),
(3, 22, GETDATE(), N'Cài đặt mới'), (3, 23, GETDATE(), NULL), (3, 2, GETDATE(), NULL), (3, 11, GETDATE(), NULL),
(4, 2, GETDATE(), N'Cài đặt mới'), (4, 7, GETDATE(), NULL), (4, 11, GETDATE(), NULL), (4, 13, GETDATE(), NULL),
(5, 2, GETDATE(), N'Cài đặt mới'), (5, 11, GETDATE(), NULL),
(6, 14, GETDATE(), N'Cài đặt mới'), (6, 15, GETDATE(), NULL), (6, 16, GETDATE(), NULL), (6, 29, GETDATE(), NULL),
(7, 24, GETDATE(), N'Cài đặt mới'), (7, 25, GETDATE(), NULL), (7, 12, GETDATE(), NULL),
(8, 6, GETDATE(), N'Cài đặt mới'), (8, 8, GETDATE(), NULL), (8, 21, GETDATE(), NULL), (8, 11, GETDATE(), NULL),
(9, 17, GETDATE(), N'Cài đặt mới'), (9, 9, GETDATE(), NULL), (9, 11, GETDATE(), NULL),
(10, 1, GETDATE(), N'Cài đặt mới'), (10, 2, GETDATE(), NULL), (10, 3, GETDATE(), NULL), (10, 8, GETDATE(), NULL), (10, 11, GETDATE(), NULL),
(11, 2, GETDATE(), N'Cài đặt mới'), (11, 8, GETDATE(), NULL), (11, 11, GETDATE(), NULL),
(12, 19, GETDATE(), N'Cài đặt mới'), (12, 20, GETDATE(), NULL), (12, 29, GETDATE(), NULL), (12, 11, GETDATE(), NULL),
(13, 2, GETDATE(), N'Cài đặt mới'), (13, 22, GETDATE(), NULL), (13, 24, GETDATE(), NULL), (13, 11, GETDATE(), NULL),
(14, 12, GETDATE(), N'Cài đặt mới'), (14, 2, GETDATE(), NULL), (14, 11, GETDATE(), NULL), (14, 7, GETDATE(), NULL),
(15, 2, GETDATE(), N'Cài đặt mới'), (15, 12, GETDATE(), NULL), (15, 11, GETDATE(), NULL);
GO

-- =============================================
-- 10. BẢO TRÌ PHÒNG
-- =============================================
INSERT INTO BaoTriPhongs (PhongMayId, MoTaSuCo, SoMayHong, NgayBaoCao, NguoiBaoCaoId, TrangThai, NguoiXuLyId, NgayXuLy, KetQuaXuLy) VALUES
(1, N'Màn hình máy 15 bị nhòe', 1, GETDATE(), 9, 2, 3, GETDATE(), N'Đã thay màn hình mới'),
(1, N'Máy 20 không khởi động được', 1, GETDATE(), 10, 2, 3, GETDATE(), N'Thay nguồn mới'),
(3, N'Máy 5, 10, 15 bị lỗi RAM', 3, GETDATE(), 11, 1, NULL, NULL, NULL),
(4, N'Bàn phím máy 8 hỏng', 1, GETDATE(), 12, 2, 4, GETDATE(), N'Thay bàn phím mới'),
(5, N'Nhiều máy cần nâng cấp', 5, GETDATE(), 13, 0, NULL, NULL, NULL),
(6, N'Máy 30 màn hình không lên', 1, GETDATE(), 14, 2, 4, GETDATE(), N'Sửa cáp màn hình'),
(7, N'Cần nâng cấp RAM toàn phòng', 4, GETDATE(), 15, 0, NULL, NULL, NULL),
(8, N'Máy 1-5 cần cài lại Windows', 5, GETDATE(), 16, 2, 5, GETDATE(), N'Đã cài lại HĐH'),
(9, N'Máy 12, 18 hỏng ổ cứng', 2, GETDATE(), 17, 1, 3, NULL, NULL),
(10, N'Quạt máy 25 kêu to', 1, GETDATE(), 18, 2, 4, GETDATE(), N'Đã vệ sinh và tra dầu'),
(11, N'Máy 3 bị virus', 1, GETDATE(), 19, 2, 5, GETDATE(), N'Diệt virus, cài lại'),
(12, N'Card màn hình máy 7, 14 yếu', 2, GETDATE(), 20, 0, NULL, NULL, NULL),
(13, N'Máy 10 bàn phím liệt phím', 1, GETDATE(), 21, 2, 3, GETDATE(), N'Thay bàn phím'),
(14, N'Máy 5, 20, 35 chạy chậm', 3, GETDATE(), 22, 1, 4, NULL, NULL),
(15, N'Máy 28 chuột không hoạt động', 1, GETDATE(), 23, 2, 5, GETDATE(), N'Thay chuột mới');
GO

-- =============================================
-- 11. ĐĂNG KÝ PHÒNG
-- =============================================
INSERT INTO DangKyPhongs (HocPhanId, PhongMayId, GiaoVienId, NgayBatDau, NgayKetThuc, GioBatDau, GioKetThuc, SoLuongSinhVien, TrangThai, MucDoUuTien, CanVanBanXacNhan, DaDongDau, NgayDangKy, LaDangKyDauNam, TuDongDuyet, GhiDeLich, ThuTrongTuan) VALUES
-- Chờ duyệt (TrangThai = 0)
(1, 1, 9, '2026-02-10', '2026-05-30', '07:00', '09:00', 45, 0, 1, 0, 0, GETDATE(), 0, 0, 0, N'2,4'),
(2, 2, 10, '2026-02-10', '2026-05-30', '09:00', '11:00', 40, 0, 1, 0, 0, GETDATE(), 0, 0, 0, N'3,5'),
(3, 3, 11, '2026-02-10', '2026-05-30', '13:00', '15:00', 50, 0, 1, 1, 0, GETDATE(), 0, 0, 0, N'2,4'),
(4, 4, 12, '2026-02-10', '2026-05-30', '15:00', '17:00', 35, 0, 2, 0, 0, GETDATE(), 0, 0, 0, N'6'),
(5, 6, 13, '2026-02-10', '2026-05-30', '07:00', '09:00', 48, 0, 1, 0, 0, GETDATE(), 0, 0, 0, N'3'),

-- Đang xử lý (TrangThai = 1)
(6, 8, 14, '2026-02-15', '2026-06-15', '09:00', '11:00', 42, 1, 1, 0, 0, GETDATE(), 0, 0, 0, N'2,4'),
(7, 9, 15, '2026-02-15', '2026-06-15', '13:00', '15:00', 38, 1, 1, 1, 0, GETDATE(), 0, 0, 0, N'5'),
(8, 10, 16, '2026-02-15', '2026-06-15', '15:00', '17:00', 44, 1, 2, 0, 0, GETDATE(), 0, 0, 0, N'3,6'),

-- Đã duyệt PDT (TrangThai = 2)
(9, 1, 17, '2026-03-01', '2026-06-30', '07:00', '09:00', 46, 2, 1, 0, 0, GETDATE(), 0, 0, 0, N'2'),
(10, 3, 18, '2026-03-01', '2026-06-30', '09:00', '11:00', 50, 2, 1, 0, 0, GETDATE(), 0, 0, 0, N'4'),
(11, 4, 19, '2026-03-01', '2026-06-30', '13:00', '15:00', 35, 2, 1, 1, 0, GETDATE(), 0, 0, 0, N'6'),

-- Đã duyệt TTDT (TrangThai = 3)
(12, 6, 20, '2026-03-15', '2026-07-15', '15:00', '17:00', 40, 3, 1, 0, 1, GETDATE(), 0, 0, 0, N'2,5'),
(13, 8, 21, '2026-03-15', '2026-07-15', '07:00', '09:00', 48, 3, 1, 0, 1, GETDATE(), 0, 0, 0, N'3'),
(14, 9, 22, '2026-03-15', '2026-07-15', '09:00', '11:00', 42, 3, 2, 1, 1, GETDATE(), 0, 0, 0, N'4,6'),

-- Hoàn tất (TrangThai = 4)
(15, 1, 23, '2026-02-01', '2026-05-30', '13:00', '15:00', 45, 4, 1, 0, 1, GETDATE(), 1, 0, 0, N'2,4'),
(16, 2, 24, '2026-02-01', '2026-05-30', '15:00', '17:00', 40, 4, 1, 0, 1, GETDATE(), 1, 0, 0, N'3,5'),
(17, 3, 25, '2026-02-01', '2026-05-30', '07:00', '09:00', 50, 4, 1, 1, 1, GETDATE(), 1, 0, 0, N'6'),
(18, 5, 26, '2026-02-01', '2026-05-30', '09:00', '11:00', 38, 4, 2, 0, 1, GETDATE(), 1, 0, 0, N'2'),
(19, 6, 27, '2026-02-01', '2026-05-30', '13:00', '15:00', 44, 4, 1, 0, 1, GETDATE(), 1, 0, 0, N'4'),
(20, 8, 28, '2026-02-01', '2026-05-30', '15:00', '17:00', 46, 4, 1, 0, 1, GETDATE(), 1, 0, 0, N'5'),

-- Từ chối (TrangThai = 5)
(21, 10, 29, '2026-04-01', '2026-07-30', '07:00', '09:00', 42, 5, 1, 0, 0, GETDATE(), 0, 0, 0, N'2,4'),
(22, 11, 30, '2026-04-01', '2026-07-30', '09:00', '11:00', 38, 5, 1, 1, 0, GETDATE(), 0, 0, 0, N'3'),
(23, 12, 31, '2026-04-01', '2026-07-30', '13:00', '15:00', 44, 5, 2, 0, 0, GETDATE(), 0, 0, 0, N'5');
GO

-- Thêm thông tin duyệt cho các đăng ký đã duyệt
UPDATE DangKyPhongs SET NguoiDuyetPDTId = 6, NgayDuyetPDT = GETDATE() WHERE TrangThai >= 2;
UPDATE DangKyPhongs SET NguoiDuyetTTDTId = 2, NgayDuyetTTDT = GETDATE() WHERE TrangThai >= 3;
UPDATE DangKyPhongs SET LyDoTuChoiPDT = N'Trùng lịch với lớp khác' WHERE TrangThai = 5 AND DangKyPhongId = 21;
UPDATE DangKyPhongs SET LyDoTuChoiPDT = N'Thiếu văn bản xác nhận' WHERE TrangThai = 5 AND DangKyPhongId = 22;
UPDATE DangKyPhongs SET LyDoTuChoiPDT = N'Phòng máy đang bảo trì' WHERE TrangThai = 5 AND DangKyPhongId = 23;
GO

-- =============================================
-- 12. MƯỢN BÙ
-- =============================================
INSERT INTO MuonBus (DangKyPhongMuonId, GiaoVienChoMuonId, NgayMuon, GioMuonBatDau, GioMuonKetThuc, LyDoMuon, GiaoVienMuonId, HanTraBu, TrangThai, NgayTao, QuaHan) VALUES
-- Chờ duyệt (TrangThai = 0)
(15, 23, '2026-02-15', '13:00', '15:00', N'Đi công tác đột xuất', 24, '2026-03-15', 0, GETDATE(), 0),
(16, 24, '2026-02-16', '15:00', '17:00', N'Nghỉ ốm', 25, '2026-03-16', 0, GETDATE(), 0),

-- Đang xử lý (TrangThai = 1)
(17, 25, '2026-02-17', '07:00', '09:00', N'Họp hội đồng khoa học', 26, '2026-03-17', 1, GETDATE(), 0),
(18, 26, '2026-02-18', '09:00', '11:00', N'Tham gia hội thảo quốc tế', 27, '2026-03-18', 1, GETDATE(), 0),

-- Đã duyệt (TrangThai = 2)
(19, 27, '2026-02-10', '13:00', '15:00', N'Lý do gia đình', 28, '2026-03-10', 2, GETDATE(), 0),
(20, 28, '2026-02-11', '15:00', '17:00', N'Kiểm tra sức khỏe', 29, '2026-03-11', 2, GETDATE(), 0),

-- Chờ trả bù (TrangThai = 3)
(15, 23, '2026-01-20', '13:00', '15:00', N'Công việc đột xuất', 30, '2026-02-20', 3, GETDATE(), 0),
(16, 24, '2026-01-21', '15:00', '17:00', N'Tham gia đào tạo', 31, '2026-02-21', 3, GETDATE(), 0),

-- Đã hoàn thành (TrangThai = 4)
(17, 25, '2026-01-10', '07:00', '09:00', N'Đi họp cơ quan', 32, '2026-02-10', 4, GETDATE(), 0),
(18, 26, '2026-01-11', '09:00', '11:00', N'Lý do cá nhân', 33, '2026-02-11', 4, GETDATE(), 0),

-- Từ chối (TrangThai = 5)
(19, 27, '2026-02-20', '13:00', '15:00', N'Không có lý do chính đáng', 34, '2026-03-20', 5, GETDATE(), 0),

-- Quá hạn
(20, 28, '2026-01-05', '15:00', '17:00', N'Đi công tác dài ngày', 35, '2026-01-20', 3, GETDATE(), 1);
GO

-- Cập nhật thông tin bổ sung cho MuonBus
UPDATE MuonBus SET NguoiDuyetId = 2, NgayDuyet = GETDATE() WHERE TrangThai >= 2;
UPDATE MuonBus SET LyDoTuChoi = N'Không đủ điều kiện mượn bù' WHERE TrangThai = 5;
UPDATE MuonBus SET GhiChuQuaHan = N'Đã quá hạn trả bù 14 ngày' WHERE QuaHan = 1;
UPDATE MuonBus SET NgayTraBu = '2026-02-05', GioTraBuBatDau = '07:00', GioTraBuKetThuc = '09:00', NgayTraBuThucTe = '2026-02-05' WHERE TrangThai = 4 AND MuonBuId = 9;
UPDATE MuonBus SET NgayTraBu = '2026-02-06', GioTraBuBatDau = '09:00', GioTraBuKetThuc = '11:00', NgayTraBuThucTe = '2026-02-06' WHERE TrangThai = 4 AND MuonBuId = 10;
GO

-- =============================================
-- 13. THÔNG BÁO
-- =============================================
INSERT INTO ThongBaos (NguoiNhanId, TieuDe, NoiDung, ThoiGian, DaDoc, LoaiThongBao) VALUES
-- Thông báo đăng ký mới
(9, N'Đăng ký phòng thành công', N'Bạn đã đăng ký thành công phòng PM01 cho học phần Lập trình C cơ bản', GETDATE(), 0, 1),
(10, N'Đăng ký phòng thành công', N'Bạn đã đăng ký thành công phòng PM02 cho học phần Lập trình Python', GETDATE(), 1, 1),
(11, N'Đăng ký phòng thành công', N'Bạn đã đăng ký thành công phòng PM03 cho học phần Lập trình hướng đối tượng', GETDATE(), 0, 1),

-- Thông báo yêu cầu duyệt
(6, N'Yêu cầu duyệt đăng ký mới', N'Có đăng ký phòng mới từ giáo viên Nguyễn Văn An cần được duyệt', GETDATE(), 0, 2),
(6, N'Yêu cầu duyệt đăng ký mới', N'Có đăng ký phòng mới từ giáo viên Trần Thị Bình cần được duyệt', GETDATE(), 1, 2),
(7, N'Yêu cầu duyệt đăng ký mới', N'Có đăng ký phòng mới từ giáo viên Lê Văn Cường cần được duyệt', GETDATE(), 0, 2),

-- Thông báo duyệt TTDT
(2, N'Yêu cầu duyệt từ PDT', N'Đăng ký phòng đã được PDT duyệt, cần TTDT xác nhận', GETDATE(), 0, 3),
(2, N'Yêu cầu duyệt từ PDT', N'Đăng ký phòng đã được PDT duyệt, cần TTDT xác nhận', GETDATE(), 1, 3),

-- Thông báo được duyệt
(23, N'Đăng ký được phê duyệt', N'Đăng ký phòng PM01 của bạn đã được phê duyệt hoàn tất', GETDATE(), 0, 4),
(24, N'Đăng ký được phê duyệt', N'Đăng ký phòng PM02 của bạn đã được phê duyệt hoàn tất', GETDATE(), 1, 4),
(25, N'Đăng ký được phê duyệt', N'Đăng ký phòng PM03 của bạn đã được phê duyệt hoàn tất', GETDATE(), 0, 4),

-- Thông báo từ chối
(29, N'Đăng ký bị từ chối', N'Đăng ký phòng của bạn bị từ chối. Lý do: Trùng lịch với lớp khác', GETDATE(), 0, 5),
(30, N'Đăng ký bị từ chối', N'Đăng ký phòng của bạn bị từ chối. Lý do: Thiếu văn bản xác nhận', GETDATE(), 1, 5),
(31, N'Đăng ký bị từ chối', N'Đăng ký phòng của bạn bị từ chối. Lý do: Phòng máy đang bảo trì', GETDATE(), 0, 5),

-- Thông báo bảo trì
(3, N'Yêu cầu bảo trì phòng máy', N'Phòng PM01 có 2 máy hỏng cần được bảo trì', GETDATE(), 0, 6),
(3, N'Yêu cầu bảo trì phòng máy', N'Phòng PM03 có 3 máy lỗi RAM cần được kiểm tra', GETDATE(), 1, 6),
(4, N'Yêu cầu bảo trì phòng máy', N'Phòng PM05 cần nâng cấp toàn bộ', GETDATE(), 0, 6),

-- Thông báo hệ thống
(1, N'Thống kê hàng ngày', N'Hôm nay có 5 đăng ký mới cần xử lý', GETDATE(), 0, 0),
(2, N'Nhắc nhở duyệt', N'Có 3 đăng ký đã quá 24h chưa được duyệt', GETDATE(), 0, 0),
(6, N'Nhắc nhở SLA', N'Có 2 đăng ký sắp hết hạn SLA xử lý', GETDATE(), 1, 0),

-- Thông báo mượn bù
(23, N'Yêu cầu mượn bù được duyệt', N'Yêu cầu mượn bù của bạn đã được phê duyệt', GETDATE(), 0, 0),
(24, N'Nhắc nhở trả bù', N'Bạn có yêu cầu mượn bù cần trả trước ngày 15/03', GETDATE(), 0, 0),
(28, N'Cảnh báo quá hạn', N'Yêu cầu mượn bù của bạn đã quá hạn trả', GETDATE(), 0, 0),

-- Thông báo phần mềm
(14, N'Yêu cầu cài đặt hoàn thành', N'Phần mềm Node.js đã được cài đặt trên phòng PM04', GETDATE(), 0, 0),
(15, N'Yêu cầu cài đặt đang xử lý', N'Yêu cầu cài đặt Python 3.12 của bạn đang được xử lý', GETDATE(), 1, 0);
GO

-- =============================================
-- 14. LỊCH SỬ ĐĂNG KÝ
-- =============================================
INSERT INTO LichSuDangKys (DangKyPhongId, NguoiThucHienId, HanhDong, NoiDung, ThoiGian, TrangThaiCu, TrangThaiMoi) VALUES
-- Lịch sử đăng ký hoàn tất
(15, 23, N'TaoDangKy', N'Giáo viên tạo đăng ký phòng mới cho học phần Lập trình C', GETDATE(), 0, 0),
(15, 6, N'DuyetPDT', N'Phòng Đào tạo đã duyệt đăng ký', GETDATE(), 0, 2),
(15, 2, N'DuyetTTDT', N'Trung tâm Đào tạo đã duyệt và hoàn tất đăng ký', GETDATE(), 2, 4),

(16, 24, N'TaoDangKy', N'Giáo viên tạo đăng ký phòng cho học phần Python', GETDATE(), 0, 0),
(16, 6, N'DuyetPDT', N'Phòng Đào tạo đã duyệt', GETDATE(), 0, 2),
(16, 2, N'DuyetTTDT', N'Hoàn tất quy trình duyệt', GETDATE(), 2, 4),

-- Lịch sử từ chối
(21, 29, N'TaoDangKy', N'Tạo đăng ký phòng cho học phần Mobile', GETDATE(), 0, 0),
(21, 6, N'TuChoiPDT', N'Từ chối: Trùng lịch với lớp học phần khác', GETDATE(), 0, 5),

(22, 30, N'TaoDangKy', N'Tạo đăng ký phòng cho học phần AI', GETDATE(), 0, 0),
(22, 7, N'TuChoiPDT', N'Từ chối: Thiếu văn bản xác nhận theo quy định', GETDATE(), 0, 5),

-- Lịch sử đang xử lý
(1, 9, N'TaoDangKy', N'Tạo đăng ký mới', GETDATE(), 0, 0),
(2, 10, N'TaoDangKy', N'Tạo đăng ký mới', GETDATE(), 0, 0),
(6, 14, N'TaoDangKy', N'Tạo đăng ký mới', GETDATE(), 0, 0),
(6, 6, N'XuLy', N'Đang xử lý yêu cầu', GETDATE(), 0, 1),

-- Lịch sử duyệt PDT
(9, 17, N'TaoDangKy', N'Tạo đăng ký mới', GETDATE(), 0, 0),
(9, 7, N'DuyetPDT', N'PDT đã duyệt, chờ TTDT', GETDATE(), 0, 2);
GO

-- =============================================
-- 15. YÊU CẦU CÀI ĐẶT PHẦN MỀM
-- =============================================
INSERT INTO YeuCauCaiDatPhanMems (PhanMemId, TenPhanMemMoi, PhienBan, MoTa, NguoiYeuCauId, NgayYeuCau, TrangThai) VALUES
-- Chờ duyệt
(NULL, N'Unity 2022.3', N'2022.3 LTS', N'Cần cài đặt cho môn Phát triển game', 15, GETDATE(), 0),
(NULL, N'Kubernetes', N'Latest', N'Cài đặt cho môn DevOps', 16, GETDATE(), 0),

-- Đang xử lý
(7, NULL, N'20.11', N'Cập nhật Node.js lên phiên bản mới', 14, GETDATE(), 1),
(8, NULL, N'3.12', N'Cập nhật Python cho phòng PM08', 17, GETDATE(), 1),

-- Đã duyệt
(NULL, N'Postman', N'10.22', N'Cài Postman cho môn Kiểm thử', 18, GETDATE(), 2),
(12, NULL, N'4.27', N'Cập nhật Docker Desktop', 19, GETDATE(), 2),

-- Đã hoàn thành
(2, NULL, N'1.86', N'Cập nhật VS Code', 20, GETDATE(), 4),
(11, NULL, N'2.44', N'Cập nhật Git', 21, GETDATE(), 4),
(22, NULL, N'4.3', N'Cập nhật Wireshark', 22, GETDATE(), 4),

-- Từ chối
(NULL, N'Cracked Software', NULL, N'Phần mềm không có bản quyền', 23, GETDATE(), 3);
GO

-- Cập nhật thông tin duyệt
UPDATE YeuCauCaiDatPhanMems SET NguoiDuyetId = 3, NgayDuyet = GETDATE() WHERE TrangThai >= 2;
UPDATE YeuCauCaiDatPhanMems SET NgayHoanThanh = GETDATE() WHERE TrangThai = 4;
UPDATE YeuCauCaiDatPhanMems SET LyDoTuChoi = N'Phần mềm không có bản quyền, không được phép cài đặt' WHERE TrangThai = 3;
GO

-- =============================================
-- 16. TEMPLATE ĐĂNG KÝ
-- =============================================
INSERT INTO TemplateDangKys (TenTemplate, MoTa, HocPhanId, PhongMayId, ThuTrongTuan, TietBatDau, TietKetThuc, SoLuongSinhVien, PhanMemYeuCau, GhiChuMacDinh, IsActive, IsPublic, NguoiTaoId, NgayTao, SoLanSuDung) VALUES
(N'Template Lập trình C', N'Template chuẩn cho học phần Lập trình C cơ bản', 1, 1, 2, 1, 3, 45, N'Visual Studio Code, GCC', N'Yêu cầu sinh viên cài sẵn môi trường C', 1, 1, 9, GETDATE(), 15),
(N'Template Python cơ bản', N'Template cho các lớp học Python', 2, 2, 3, 4, 6, 40, N'Python 3.x, VS Code, Jupyter', N'Cài đặt pip và các thư viện cơ bản', 1, 1, 10, GETDATE(), 12),
(N'Template OOP Java', N'Template cho môn lập trình hướng đối tượng', 3, 3, 4, 1, 3, 50, N'JDK 17, IntelliJ IDEA', N'Sinh viên cần có tài khoản JetBrains', 1, 0, 11, GETDATE(), 8),
(N'Template Web Development', N'Template cho các lớp phát triển web', 9, 4, 5, 4, 6, 35, N'VS Code, Node.js, Chrome Dev', N'Cần kết nối Internet ổn định', 1, 1, 14, GETDATE(), 20),
(N'Template Database', N'Template cho môn Cơ sở dữ liệu', 5, 2, 6, 1, 3, 42, N'SQL Server, MySQL Workbench', N'Sử dụng database localhost', 1, 1, 17, GETDATE(), 18),
(N'Template Mạng máy tính', N'Template cho môn Network', 6, 3, 2, 7, 9, 38, N'Wireshark, Cisco Packet Tracer', N'Mang theo laptop nếu có', 1, 0, 18, GETDATE(), 6),
(N'Template AI/ML', N'Template cho môn Machine Learning', 12, 8, 3, 7, 9, 44, N'Python, Jupyter, TensorFlow, PyTorch', N'Cần GPU cho deep learning', 1, 1, 19, GETDATE(), 10),
(N'Template An ninh mạng', N'Template cho môn An toàn thông tin', 8, 13, 4, 7, 9, 48, N'Kali Linux, Metasploit, Wireshark', N'Chỉ sử dụng trong môi trường lab', 1, 0, 20, GETDATE(), 5),
(N'Template Android Dev', N'Template cho lập trình Android', 10, 9, 5, 4, 6, 33, N'Android Studio, JDK, Emulator', N'RAM tối thiểu 8GB cho emulator', 0, 1, 21, GETDATE(), 3),
(N'Template Game Development', N'Template cho môn Phát triển game', 15, 12, 6, 7, 9, 41, N'Unity, Visual Studio, Blender', N'Cần card đồ họa tốt', 1, 1, 22, GETDATE(), 7);
GO

PRINT N'Hoàn thành tạo dữ liệu mẫu tiếng Việt!';
GO
