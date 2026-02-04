# Hướng dẫn Cài đặt Database - Quản lý Thực hành Máy tính

## Yêu cầu hệ thống

- **SQL Server 2019** trở lên hoặc **SQL Server Express**
- **.NET 8.0 SDK**
- **Visual Studio 2022** hoặc **VS Code**

---

## Cách 1: Sử dụng SQL Script (Khuyến nghị)

### Bước 1: Cài đặt SQL Server

1. Tải và cài đặt [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
2. Cài đặt [SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)

### Bước 2: Chạy Script tạo Database

1. Mở **SQL Server Management Studio (SSMS)**
2. Kết nối tới SQL Server của bạn
3. Mở file `Database_Setup_Full.sql`
4. Nhấn **F5** hoặc click **Execute** để chạy script

### Bước 3: Cấu hình Connection String

Chỉnh sửa file `QL_TH_MT/appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=TEN_MAY_TINH;Database=QL_PHONG_TH;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true"
  }
}
```

**Các tùy chọn kết nối:**

| Loại kết nối | Connection String |
|-------------|------------------|
| **LocalDB** | `Server=(localdb)\MSSQLLocalDB;Database=QL_PHONG_TH;Trusted_Connection=True;TrustServerCertificate=True` |
| **SQL Server Express** | `Server=.\SQLEXPRESS;Database=QL_PHONG_TH;Trusted_Connection=True;TrustServerCertificate=True` |
| **SQL Server** | `Server=localhost;Database=QL_PHONG_TH;Trusted_Connection=True;TrustServerCertificate=True` |
| **Với Username/Password** | `Server=localhost;Database=QL_PHONG_TH;User Id=sa;Password=YOUR_PASSWORD;TrustServerCertificate=True` |

---

## Cách 2: Sử dụng EF Core Migrations

### Bước 1: Mở Terminal tại thư mục dự án

```bash
cd QL_TH_MT/QL_TH_MT
```

### Bước 2: Cập nhật Database

```bash
dotnet ef database update --context NewAppDbContext
```

---

## Chạy ứng dụng

```bash
cd QL_TH_MT/QL_TH_MT
dotnet run
```

Truy cập: **http://localhost:5199**

---

## Tài khoản đăng nhập mẫu

| Vai trò | Tên đăng nhập | Mật khẩu |
|---------|--------------|----------|
| **Administrator** | admin | 123456 |
| **Phòng Đào Tạo** | pdt | 123456 |
| **Trung tâm ĐTTH** | ttdtth | 123456 |
| **Giảng viên** | tranthidung | 123456 |

---

## Cấu trúc Database

### Các bảng chính

| Bảng | Mô tả |
|------|-------|
| `TaiKhoans` | Quản lý tài khoản người dùng |
| `HocKys` | Quản lý học kỳ |
| `MonHocs` | Quản lý môn học |
| `HocPhans` | Quản lý học phần |
| `PhongThucHanhs` | Quản lý phòng thực hành |
| `HopDongs` | Quản lý hợp đồng thỉnh giảng |
| `LichThucHanhs` | Quản lý lịch thực hành |
| `DangKyLichThinhGiangs` | Đăng ký lịch của giảng viên thỉnh giảng |
| `ThongBaos` | Thông báo hệ thống |
| `YeuCauDoiPhongs` | Yêu cầu đổi phòng |
| `YeuCauMuonBus` | Yêu cầu mượn/bù |

### Vai trò người dùng

| VaiTro | Mô tả |
|--------|-------|
| 1 | Administrator (Quản trị viên) |
| 2 | PDT (Phòng Đào Tạo) |
| 3 | TTDTTH (Trung tâm Đào tạo Thực hành) |
| 4 | GiangVien (Giảng viên) |

### Loại giảng viên

| LoaiGiangVien | Mô tả |
|---------------|-------|
| 1 | Cơ hữu |
| 2 | Thỉnh giảng |

---

## Troubleshooting

### Lỗi: Cannot connect to database

1. Kiểm tra SQL Server đang chạy
2. Kiểm tra tên server trong connection string
3. Thử dùng `localhost` hoặc `.\SQLEXPRESS` hoặc `(localdb)\MSSQLLocalDB`

### Lỗi: Login failed

1. Đảm bảo SQL Server cho phép Windows Authentication
2. Hoặc sử dụng SQL Server Authentication với username/password

### Lỗi: Database does not exist

1. Chạy script `Database_Setup_Full.sql` trước
2. Hoặc dùng lệnh `dotnet ef database update`

---

## Liên hệ hỗ trợ

- **Email**: support@utc2.edu.vn
- **Repository**: https://github.com/TrQHuy-build/Computer_lab_Practice_Management
