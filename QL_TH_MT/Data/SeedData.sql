-- Script tạo database và seed data
-- Database đã được tạo tự động bởi Entity Framework

-- Thêm dữ liệu mẫu cho Phòng máy
INSERT INTO PhongMays (MaPhong, TenPhong, SoLuongMay, SoMayHong, ViTri, TrangThai)
VALUES 
('PM01', N'Phòng máy 101', 40, 0, N'Tầng 1', 1),
('PM02', N'Phòng máy 102', 50, 5, N'Tầng 1', 1),
('PM03', N'Phòng máy 201', 45, 0, N'Tầng 2', 1),
('PM04', N'Phòng máy 202', 35, 3, N'Tầng 2', 1);

-- Thêm dữ liệu mẫu cho Phần mềm
INSERT INTO PhanMems (TenPhanMem, PhienBan, NhaSanXuat, TrangThai)
VALUES 
('Visual Studio', '2022', 'Microsoft', 1),
('SQL Server', '2019', 'Microsoft', 1),
('Eclipse', '2023', 'Eclipse Foundation', 1),
('IntelliJ IDEA', '2023', 'JetBrains', 1),
('PyCharm', '2023', 'JetBrains', 1);

-- Thêm dữ liệu mẫu cho Học phần
INSERT INTO HocPhans (MaHocPhan, TenHocPhan, SoTinChi)
VALUES 
('CSDL01', N'Cơ sở dữ liệu', 3),
('LTW01', N'Lập trình Web', 3),
('LTDD01', N'Lập trình di động', 3),
('CTDL01', N'Cấu trúc dữ liệu và giải thuật', 3),
('KTMT01', N'Kiến trúc máy tính', 3);
