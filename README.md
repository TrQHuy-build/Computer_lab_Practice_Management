# Hệ thống quản lý đăng ký phòng thực hành

## Cấu trúc dự án

### Models (16 files)
- NhanVien.cs
- PhongBan.cs
- TaiKhoan.cs
- VaiTro.cs
- Quyen.cs
- VaiTroQuyen.cs
- PhongMay.cs
- HocPhan.cs
- PhanMem.cs
- PhongMayPhanMem.cs
- DangKyPhong.cs
- DangKyPhanMem.cs
- LichSuDangKy.cs
- BaoTriPhong.cs
- YeuCauCaiDatPhanMem.cs
- ThongBao.cs
- ErrorViewModel.cs

### ViewModels (4 files)
- LoginViewModel.cs
- DangKyPhongViewModel.cs
- DashboardViewModel.cs
- BaoCaoViewModel.cs

### Controllers (7 files)
- AccountController.cs
- HomeController.cs
- DangKyPhongController.cs
- PhongMayController.cs
- PhanMemController.cs
- BaoTriPhongController.cs
- YeuCauCaiDatController.cs
- BaoCaoController.cs

### Data
- ApplicationDbContext.cs
- SeedData.sql

### Configuration
- Program.cs
- appsettings.json
- QL_TH_MT.csproj

## Tài khoản mặc định

- **Admin**: admin / admin123
- **Quản lý TT**: qltt / qltt123
- **NV Trung tâm**: nvtt / nvtt123
- **NV Phòng ĐT**: nvpdt / nvpdt123
- **Giáo viên**: gv / gv123

## Cách chạy dự án

1. Đảm bảo SQL Server đang chạy
2. Cập nhật ConnectionString trong appsettings.json (nếu cần)
3. Chạy lệnh: `dotnet run`
4. Truy cập: https://localhost:5001

## Tính năng chính

### Tất cả người dùng
- Đăng nhập
- Xem dashboard
- Xem lịch sử đăng ký
- Xem thông báo

### Giáo viên (GV)
- Tạo đăng ký phòng TH
- Sửa đăng ký của mình
- Hủy đăng ký
- Xem lịch

### Nhân viên Phòng Đào Tạo (PDT)
- Duyệt/từ chối đăng ký từ GV
- Xem báo cáo

### Nhân viên Trung Tâm (TTDT)
- Tạo đăng ký phòng
- Duyệt/từ chối sau khi PDT duyệt
- Quản lý phần mềm
- Báo cáo bảo trì phòng
- Xử lý yêu cầu cài đặt phần mềm
- Xem báo cáo

### Quản lý Trung Tâm & Admin
- Tất cả quyền của TTDT
- Quản lý phòng máy
- Ghi đè lịch
- Duyệt yêu cầu cài đặt phần mềm mới

## Chức năng đặc biệt

1. **Kiểm tra xung đột tự động**: Hệ thống tự động cảnh báo khi đăng ký trùng giờ
2. **Quản lý thiết bị hỏng**: Cập nhật số máy hỏng, tính sức chứa thực tế
3. **Tự động duyệt**: Đăng ký đầu năm có văn bản được tự động duyệt
4. **Mức độ ưu tiên**: Phân loại đăng ký theo độ ưu tiên
5. **Lịch sử đầy đủ**: Theo dõi tất cả thay đổi của đăng ký
6. **Báo cáo thống kê**: 
   - Tần suất sử dụng phòng
   - Phần mềm được yêu cầu nhiều
   - Danh sách xung đột
7. **Workflow rõ ràng**: GV → PDT → TTDT
8. **Yêu cầu cài đặt PM mới**: GV có thể yêu cầu cài phần mềm chưa có

## Ma trận quyền

| Chức năng | Admin | QL TT | TTDT | PDT | GV |
|-----------|-------|-------|------|-----|-----|
| Đăng nhập | ✔ | ✔ | ✔ | ✔ | ✔ |
| Tạo booking | ✔ | ✔ | ✔ | ✖ | ✔ |
| Sửa booking | ✔ | ✔ | ✔ | ✖ | ✔ |
| Duyệt PDT | ✖ | ✖ | ✖ | ✔ | ✖ |
| Duyệt TTDT | ✔ | ✔ | ✔ | ✖ | ✖ |
| Từ chối booking | ✔ | ✔ | ✔ | ✔ | ✖ |
| Quản lý phòng | ✔ | ✔ | ✖ | ✖ | ✖ |
| Quản lý PM | ✔ | ✔ | ✔ | ✖ | ✖ |
| Xem báo cáo | ✔ | ✔ | ✔ | ✔ | ✖ |
| Ghi đè lịch | ✔ | ✔ | ✖ | ✖ | ✖ |

## Công nghệ sử dụng

- ASP.NET Core 8.0 MVC
- Entity Framework Core
- SQL Server
- Bootstrap 5
- Bootstrap Icons
- Cookie Authentication
