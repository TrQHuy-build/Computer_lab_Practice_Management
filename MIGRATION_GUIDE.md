# 🔄 HƯỚNG DẪN MIGRATION - CẢI TIẾN KIẾN TRÚC DỰ ÁN

## 📁 CÁC FILE MỚI ĐƯỢC TẠO

### 1. Repository Pattern & Unit of Work
```
QL_TH_MT/
├── Core/
│   ├── Entities/
│   │   └── BaseEntity.cs                 # Base classes với Audit Trail
│   └── Interfaces/
│       ├── IRepository.cs                # Generic Repository Interface
│       ├── IUnitOfWork.cs                # Unit of Work Interface
│       ├── IDangKyPhongRepository.cs     # Repository đặc thù cho DangKyPhong
│       ├── IPhongMayRepository.cs        
│       ├── IHocPhanRepository.cs         
│       ├── IPhanMemRepository.cs         
│       ├── INhanVienRepository.cs        
│       ├── ITaiKhoanRepository.cs        
│       ├── IThongBaoRepository.cs        
│       ├── ILichSuDangKyRepository.cs    
│       ├── IDangKyPhanMemRepository.cs   
│       ├── IBaoTriPhongRepository.cs     
│       ├── IMuonBuRepository.cs          
│       ├── IDangKyPhongService.cs        # Business Service Interface
│       └── ICacheService.cs              # Cache Service Interface
└── Infrastructure/
    ├── UnitOfWork.cs                     # Unit of Work Implementation
    ├── Data/
    │   └── AuditableEntityInterceptor.cs # Auto Audit Trail
    ├── Repositories/
    │   ├── Repository.cs                 # Generic Repository Implementation
    │   ├── DangKyPhongRepository.cs      
    │   ├── PhongMayRepository.cs         
    │   ├── HocPhanRepository.cs          
    │   ├── PhanMemRepository.cs          
    │   ├── NhanVienRepository.cs         
    │   ├── TaiKhoanRepository.cs         
    │   ├── ThongBaoRepository.cs         
    │   ├── LichSuDangKyRepository.cs     
    │   ├── DangKyPhanMemRepository.cs    
    │   ├── BaoTriPhongRepository.cs      
    │   └── MuonBuRepository.cs           
    ├── Services/
    │   ├── DangKyPhongService.cs         # Business Logic Service
    │   └── MemoryCacheService.cs         # Caching Implementation
    └── Middleware/
        ├── GlobalExceptionHandlerMiddleware.cs
        └── RequestLoggingMiddleware.cs
```

### 2. ViewModels Cải Tiến
```
ViewModels/
├── DangKyPhongViewModelNew.cs    # Với đầy đủ Data Annotations
├── LoginViewModelNew.cs          # Với validation
└── ApprovalViewModel.cs          # Cho duyệt/từ chối
```

### 3. Controller Refactored
```
Controllers/
└── DangKyPhongRefactoredController.cs  # Slim controller sử dụng Service
```

### 4. Unit Tests
```
QL_TH_MT.Tests/
├── QL_TH_MT.Tests.csproj
├── Services/
│   └── DangKyPhongServiceTests.cs
└── ViewModels/
    └── DangKyPhongViewModelValidationTests.cs
```

### 5. Configuration Files
```
├── Program.New.cs          # Updated Program.cs với DI setup
├── appsettings.New.json    # Enhanced configuration
```

---

## 🚀 HƯỚNG DẪN ÁP DỤNG

### Bước 1: Backup dự án hiện tại
```powershell
# Copy toàn bộ dự án ra folder backup
Copy-Item -Path ".\QL_TH_MT" -Destination ".\QL_TH_MT_Backup" -Recurse
```

### Bước 2: Cài đặt NuGet packages mới
```powershell
cd QL_TH_MT\QL_TH_MT
dotnet add package Serilog.AspNetCore
dotnet add package Serilog.Enrichers.Environment
dotnet add package Serilog.Settings.Configuration
```

### Bước 3: Thay thế Program.cs
```powershell
# Rename file cũ
Rename-Item -Path "Program.cs" -NewName "Program.Old.cs"
# Rename file mới
Rename-Item -Path "Program.New.cs" -NewName "Program.cs"
```

### Bước 4: Thay thế appsettings.json
```powershell
Rename-Item -Path "appsettings.json" -NewName "appsettings.Old.json"
Rename-Item -Path "appsettings.New.json" -NewName "appsettings.json"
```

### Bước 5: Thay thế ViewModels
```powershell
# Rename hoặc merge với file cũ
Rename-Item -Path "ViewModels\DangKyPhongViewModel.cs" -NewName "DangKyPhongViewModel.Old.cs"
Rename-Item -Path "ViewModels\DangKyPhongViewModelNew.cs" -NewName "DangKyPhongViewModel.cs"
```

### Bước 6: Thay thế Controller (Tuỳ chọn)
```powershell
# Có thể giữ cả hai controller hoặc thay thế
# Nếu thay thế:
Rename-Item -Path "Controllers\DangKyPhongController.cs" -NewName "DangKyPhongController.Old.cs"
Rename-Item -Path "Controllers\DangKyPhongRefactoredController.cs" -NewName "DangKyPhongController.cs"
# Đổi tên class trong file từ DangKyPhongRefactoredController thành DangKyPhongController
```

### Bước 7: Build và Test
```powershell
# Build main project
dotnet build

# Run tests
cd ..\QL_TH_MT.Tests
dotnet test

# Run application
cd ..\QL_TH_MT
dotnet run
```

---

## ✅ CHECKLIST SAU KHI MIGRATION

- [ ] Build thành công không có lỗi
- [ ] Tất cả Unit Tests pass
- [ ] Đăng nhập hoạt động bình thường
- [ ] Tạo đăng ký phòng hoạt động
- [ ] Duyệt PDT hoạt động
- [ ] Duyệt TTDT hoạt động
- [ ] Hủy đăng ký hoạt động
- [ ] Logs được ghi vào thư mục logs/
- [ ] Exception được xử lý và log đầy đủ

---

## 📊 SO SÁNH TRƯỚC/SAU

| Tiêu chí | Trước | Sau |
|----------|-------|-----|
| Lines trong DangKyPhongController | 675 | ~200 |
| Business Logic Location | Controller | Service Layer |
| Input Validation | Cơ bản | Đầy đủ + Custom |
| Exception Handling | Basic | Global + Logging |
| Logging | Console only | Serilog (File + Console) |
| Unit Tests | 0 | 10+ tests |
| Repository Pattern | Không | Có |
| Unit of Work | Không | Có |
| Caching | Không | Memory Cache |
| Audit Trail | Không | Có (interceptor) |

---

## 🔧 CẤU HÌNH BỔ SUNG

### Thêm Audit columns vào Database (Migration)
```csharp
// Tạo migration mới nếu cần thêm Audit columns
dotnet ef migrations add AddAuditColumns
dotnet ef database update
```

### Cấu hình Logging Level trong appsettings.json
```json
{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft.EntityFrameworkCore": "Warning"  // Giảm noise từ EF
      }
    }
  }
}
```

---

## ⚠️ LƯU Ý QUAN TRỌNG

1. **Giữ nguyên Views**: Các file Views không cần thay đổi
2. **Tương thích ngược**: Controller cũ vẫn hoạt động song song
3. **Test kỹ trước deploy**: Chạy tất cả tests trước khi deploy production
4. **Backup database**: Luôn backup DB trước khi migration

---

## 📞 HỖ TRỢ

Nếu gặp vấn đề trong quá trình migration, kiểm tra:
1. Logs trong thư mục `logs/`
2. Output console khi chạy `dotnet run`
3. Exception details trong Development mode
