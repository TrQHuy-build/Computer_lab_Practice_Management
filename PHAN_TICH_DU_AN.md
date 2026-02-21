# PHÂN TÍCH DỰ ÁN: HỆ THỐNG QUẢN LÝ ĐĂNG KÝ PHÒNG THỰC HÀNH

**Tên dự án:** QL_TH_MT - Hệ thống quản lý đăng ký phòng thực hành máy tính  
**Ngày phân tích:** 03/02/2026  
**Phiên bản:** 1.0

---

## MỤC LỤC
1. [Tổng quan dự án](#1-tổng-quan-dự-án)
2. [Đánh giá từ góc độ Business Analyst (BA)](#2-đánh-giá-từ-góc-độ-business-analyst-ba)
3. [Đánh giá từ góc độ Developer (DEV)](#3-đánh-giá-từ-góc-độ-developer-dev)
4. [Tài liệu Phân tích Thiết kế](#4-tài-liệu-phân-tích-thiết-kế)
5. [Kết luận và Đề xuất](#5-kết-luận-và-đề-xuất)

---

## 1. TỔNG QUAN DỰ ÁN

### 1.1. Mô tả hệ thống
Hệ thống quản lý đăng ký phòng thực hành máy tính là một ứng dụng web cho phép:
- Giáo viên đăng ký sử dụng phòng thực hành
- Phòng Đào Tạo (PDT) và Trung tâm (TTDT) duyệt yêu cầu đăng ký
- Quản lý thiết bị, phần mềm và bảo trì phòng máy
- Theo dõi lịch sử và báo cáo thống kê

### 1.2. Công nghệ sử dụng
| Thành phần | Công nghệ |
|------------|-----------|
| Backend | ASP.NET Core 8.0 MVC |
| ORM | Entity Framework Core |
| Database | SQL Server |
| Frontend | Bootstrap 5, Bootstrap Icons |
| Authentication | Cookie Authentication |
| Testing | xUnit, Moq, FluentAssertions |

### 1.3. Kiến trúc dự án
```
QL_TH_MT/
├── Core/                    # Business Layer
│   ├── Entities/           # Base entities
│   └── Interfaces/         # Service & Repository interfaces
├── Infrastructure/          # Data Access Layer
│   ├── Data/               # DbContext
│   ├── Repositories/       # Repository implementations
│   ├── Services/           # Service implementations
│   └── Middleware/         # Custom middlewares
├── Controllers/            # Presentation Layer
├── Models/                 # Domain Models
├── ViewModels/             # Data Transfer Objects
├── Views/                  # Razor Views
└── wwwroot/               # Static files
```

---

## 2. ĐÁNH GIÁ TỪ GÓC ĐỘ BUSINESS ANALYST (BA)

### 2.1. ĐIỂM TỐT ✅

#### 2.1.1. Quy trình nghiệp vụ rõ ràng
- **Workflow duyệt đa cấp:** GV → PDT → TTDT phản ánh đúng quy trình thực tế
- **Phân quyền chi tiết:** Ma trận quyền rõ ràng với 5 vai trò (Admin, QL_TrungTam, NV_TrungTam, PDT, GiaoVien)
- **Trạng thái đăng ký đầy đủ:** 7 trạng thái bao phủ toàn bộ lifecycle

```
Các trạng thái: ChoDuyetPDT → PDTDongY/PDTTuChoi → ChoDuyetTTDT → TTDTDongY/TTDTTuChoi → DaHuy
```

#### 2.1.2. Tính năng nghiệp vụ phong phú
- ✅ Kiểm tra xung đột lịch tự động
- ✅ Quản lý thiết bị hỏng và sức chứa thực tế
- ✅ Hệ thống mượn-bù giữa giáo viên
- ✅ Yêu cầu cài đặt phần mềm mới
- ✅ Tự động duyệt đăng ký đầu năm có văn bản
- ✅ Mức độ ưu tiên đăng ký (5 mức)
- ✅ Lịch sử đầy đủ mọi thay đổi
- ✅ Hệ thống thông báo

#### 2.1.3. Cấu trúc dữ liệu logic
- Mô hình dữ liệu phản ánh đúng nghiệp vụ thực tế
- Quan hệ giữa các entity được thiết kế hợp lý
- Audit trail với bảng LichSuDangKy

### 2.2. ĐIỂM CHƯA TỐT ❌

#### 2.2.1. Thiếu tài liệu yêu cầu
- ❌ File `SRS_Document.md` trống - chưa có tài liệu đặc tả yêu cầu
- ❌ Chưa có Use Case Diagram, Activity Diagram
- ❌ Thiếu mô tả chi tiết các business rule

#### 2.2.2. Thiếu Validation Rules rõ ràng
- ❌ Chưa có tài liệu validation rules cho từng field
- ❌ Thiếu định nghĩa các ràng buộc nghiệp vụ
- ❌ Chưa mô tả các trường hợp ngoại lệ

#### 2.2.3. User Story chưa đầy đủ
- ❌ Chưa có danh sách User Stories
- ❌ Thiếu Acceptance Criteria
- ❌ Chưa có trường hợp kiểm thử nghiệp vụ

---

## 3. ĐÁNH GIÁ TỪ GÓC ĐỘ DEVELOPER (DEV)

### 3.1. ĐIỂM TỐT ✅

#### 3.1.1. Kiến trúc tốt
- ✅ **Clean Architecture:** Tách biệt Core, Infrastructure, Presentation
- ✅ **Repository Pattern:** Generic IRepository<T> và specific repositories
- ✅ **Unit of Work Pattern:** Quản lý transaction nhất quán
- ✅ **Dependency Injection:** Sử dụng DI đúng cách

```csharp
// Unit of Work với lazy loading repositories
public class UnitOfWork : IUnitOfWork
{
    private IDangKyPhongRepository? _dangKyPhongs;
    public IDangKyPhongRepository DangKyPhongs => 
        _dangKyPhongs ??= new DangKyPhongRepository(_context);
    // ...
}
```

#### 3.1.2. Code organization tốt
- ✅ **Interface segregation:** Mỗi repository có interface riêng
- ✅ **Single Responsibility:** Controllers mỏng, logic trong Services
- ✅ **ViewModel tách biệt:** Không expose trực tiếp domain models

#### 3.1.3. Database migration chuẩn
- ✅ Sử dụng EF Core Migrations
- ✅ Seed data trong OnModelCreating
- ✅ Có file backup schema và data

#### 3.1.4. Testing Infrastructure
- ✅ Có project test riêng (QL_TH_MT.Tests)
- ✅ Sử dụng xUnit, Moq, FluentAssertions
- ✅ Có test cho Services và ViewModels

### 3.2. ĐIỂM CHƯA TỐT ❌

#### 3.2.1. Không nhất quán trong Service Registration
```csharp
// Program.cs hiện tại - thiếu nhiều services
builder.Services.AddScoped<IThongBaoService, ThongBaoService>();
builder.Services.AddScoped<ILichHocService, LichHocService>();
builder.Services.AddScoped<IMuonBuService, MuonBuService>();
// ❌ Thiếu: IDangKyPhongService, IUnitOfWork, ICacheService...
```

#### 3.2.2. Controller quá dày (Fat Controller)
```csharp
// DangKyPhongController.cs - 675 dòng!
// ❌ Business logic trong Controller thay vì Service
public async Task<IActionResult> Create(DangKyPhongViewModel model)
{
    // Kiểm tra thời hạn đăng ký
    // Kiểm tra sức chứa
    // Kiểm tra xung đột
    // Tạo entity
    // ...
}
```

#### 3.2.3. Duplicate Code
- ❌ Có 2 file DangKyPhongController: gốc và Refactored
- ❌ Có 2 ViewModel: LoginViewModel và LoginViewModelNew
- ❌ Có 2 Program.cs: gốc và Program.New.cs.bak

#### 3.2.4. Thiếu Error Handling nhất quán
- ❌ Chưa có Global Exception Handler
- ❌ TempData["Error"] không nhất quán
- ❌ Thiếu logging ở nhiều nơi

#### 3.2.5. Hardcoded Values
```csharp
// ❌ Magic numbers
if (vaiTroId == 5) // GiaoVien
if (vaiTroId == 4) // PDT
if (vaiTroId == 3) // TTDT
```

#### 3.2.6. Thiếu Data Annotations/FluentValidation
```csharp
// DangKyPhongViewModel.cs thiếu validation
public class DangKyPhongViewModel
{
    public int HocPhanId { get; set; } // ❌ Thiếu [Required]
    public int SoLuongSinhVien { get; set; } // ❌ Thiếu [Range]
    // ...
}
```

---

## 4. TÀI LIỆU PHÂN TÍCH THIẾT KẾ

### 4.1. BẢNG DANH SÁCH TÁC NHÂN (ACTORS)

| STT | Actor | Mô tả | Vai trò hệ thống |
|-----|-------|-------|------------------|
| 1 | Admin | Quản trị viên hệ thống | Toàn quyền quản lý |
| 2 | Quản lý Trung tâm | Quản lý trung tâm TTDT | Duyệt cuối cùng, ghi đè lịch |
| 3 | NV Trung tâm | Nhân viên TTDT | Duyệt TTDT, quản lý PM |
| 4 | NV Phòng ĐT | Nhân viên phòng đào tạo | Duyệt PDT |
| 5 | Giáo viên | Giảng viên | Đăng ký phòng |

### 4.2. DANH SÁCH USE CASES

| ID | Use Case | Actor | Mô tả |
|----|----------|-------|-------|
| UC01 | Đăng nhập | Tất cả | Xác thực người dùng |
| UC02 | Xem Dashboard | Tất cả | Xem tổng quan hệ thống |
| UC03 | Tạo đăng ký phòng | GV, NV_TT, QL_TT, Admin | Tạo yêu cầu sử dụng phòng |
| UC04 | Sửa đăng ký | GV, NV_TT, QL_TT, Admin | Chỉnh sửa đăng ký đã tạo |
| UC05 | Hủy đăng ký | GV, NV_TT, QL_TT, Admin | Hủy bỏ đăng ký |
| UC06 | Duyệt PDT | PDT | Duyệt/từ chối cấp PDT |
| UC07 | Duyệt TTDT | NV_TT, QL_TT, Admin | Duyệt/từ chối cấp TTDT |
| UC08 | Ghi đè lịch | QL_TT, Admin | Ghi đè đăng ký đã có |
| UC09 | Quản lý phòng máy | QL_TT, Admin | CRUD phòng máy |
| UC10 | Quản lý học phần | QL_TT, Admin | CRUD học phần |
| UC11 | Quản lý phần mềm | NV_TT, QL_TT, Admin | CRUD phần mềm |
| UC12 | Báo cáo bảo trì | NV_TT, QL_TT, Admin | Tạo báo cáo bảo trì phòng |
| UC13 | Yêu cầu cài PM | GV | Yêu cầu cài phần mềm mới |
| UC14 | Duyệt yêu cầu PM | QL_TT, Admin | Duyệt yêu cầu cài PM |
| UC15 | Mượn-Bù lịch | GV | Mượn lịch GV khác và trả bù |
| UC16 | Xem báo cáo | PDT, NV_TT, QL_TT, Admin | Xem thống kê, báo cáo |
| UC17 | Xem thông báo | Tất cả | Xem thông báo hệ thống |
| UC18 | Xem lịch | Tất cả | Xem lịch đăng ký phòng |

### 4.3. USE CASE DIAGRAM

```
                              ┌────────────────────────────────────────┐
                              │   HỆ THỐNG QUẢN LÝ PHÒNG THỰC HÀNH    │
                              └────────────────────────────────────────┘
                                              │
    ┌──────────────────────────────────────────┼──────────────────────────────────────────┐
    │                                          │                                          │
    ▼                                          ▼                                          ▼
┌───────────┐                           ┌───────────┐                              ┌───────────┐
│  Giáo     │                           │    NV     │                              │   Admin   │
│  Viên     │                           │   TTDT    │                              │           │
└─────┬─────┘                           └─────┬─────┘                              └─────┬─────┘
      │                                       │                                          │
      │ ┌─────────────────┐                   │ ┌─────────────────┐                      │
      ├─► Đăng ký phòng   │                   ├─► Duyệt TTDT      │                      │
      │ └─────────────────┘                   │ └─────────────────┘                      │
      │ ┌─────────────────┐                   │ ┌─────────────────┐                      │
      ├─► Sửa/Hủy đăng ký │                   ├─► QL Phần mềm     │                      │
      │ └─────────────────┘                   │ └─────────────────┘                      │
      │ ┌─────────────────┐                   │ ┌─────────────────┐                      ▼
      ├─► Mượn-Bù lịch    │                   ├─► Báo cáo bảo trì │            ┌─────────────────┐
      │ └─────────────────┘                   │ └─────────────────┘            │   TẤT CẢ        │
      │ ┌─────────────────┐                   │                                │   CHỨC NĂNG     │
      └─► YC cài PM       │                   │                                └─────────────────┘
        └─────────────────┘                   │
                                              │
    ┌──────────────────────────────────────────┼──────────────────────────────────────────┐
    │                                          │                                          │
    ▼                                          ▼                                          │
┌───────────┐                           ┌───────────┐                                     │
│   PDT     │                           │  QL TT    │                                     │
└─────┬─────┘                           └─────┬─────┘                                     │
      │                                       │                                           │
      │ ┌─────────────────┐                   │ ┌─────────────────┐                       │
      ├─► Duyệt PDT       │                   ├─► Ghi đè lịch     │                       │
      │ └─────────────────┘                   │ └─────────────────┘                       │
      │ ┌─────────────────┐                   │ ┌─────────────────┐                       │
      └─► Xem báo cáo     │                   ├─► QL Phòng máy    │                       │
        └─────────────────┘                   │ └─────────────────┘                       │
                                              │ ┌─────────────────┐                       │
                                              ├─► QL Học phần     │                       │
                                              │ └─────────────────┘                       │
                                              │ ┌─────────────────┐                       │
                                              └─► Duyệt YC PM     │                       │
                                                └─────────────────┘                       │
                                                                                          │
                        ┌─────────────────────────────────────────────────────────────────┘
                        │
                        ▼
              ┌─────────────────────────────────────────────────────────────┐
              │   CHỨC NĂNG CHUNG (TẤT CẢ ACTORS)                          │
              │   ├── UC01: Đăng nhập                                       │
              │   ├── UC02: Xem Dashboard                                   │
              │   ├── UC17: Xem thông báo                                   │
              │   └── UC18: Xem lịch phòng                                  │
              └─────────────────────────────────────────────────────────────┘
```

### 4.4. CLASS DIAGRAM (DOMAIN MODEL)

```
┌────────────────────┐       ┌────────────────────┐       ┌────────────────────┐
│     PhongBan       │       │      VaiTro        │       │      Quyen         │
├────────────────────┤       ├────────────────────┤       ├────────────────────┤
│ - PhongBanId: int  │       │ - VaiTroId: int    │       │ - QuyenId: int     │
│ - TenPhongBan      │       │ - TenVaiTro        │       │ - TenQuyen         │
│ - MoTa             │       │ - MoTa             │       │ - MaQuyen          │
└────────┬───────────┘       └─────────┬──────────┘       └─────────┬──────────┘
         │                             │                            │
         │ 1                           │ 1                          │ *
         │                             │                            │
         ▼ *                           │                            │
┌────────────────────┐                 │                    ┌───────▼──────────┐
│     NhanVien       │◄────────────────┘                    │   VaiTroQuyen    │
├────────────────────┤       ┌────────────────────┐         ├──────────────────┤
│ - MaNhanVien: int  │       │     TaiKhoan       │         │ - VaiTroQuyenId  │
│ - HoTen            │       ├────────────────────┤         │ - VaiTroId       │
│ - SoDienThoai      │◄──────│ - TaiKhoanId: int  │         │ - QuyenId        │
│ - Email            │   1  1│ - TenDangNhap      │         └──────────────────┘
│ - PhongBanId       │       │ - MatKhauHash      │
└────────┬───────────┘       │ - MaNhanVien       │
         │                   │ - VaiTroId         │
         │ 1                 └────────────────────┘
         │
         ▼ *
┌────────────────────────────────────────────────────────────────────────────────┐
│                              DangKyPhong                                        │
├────────────────────────────────────────────────────────────────────────────────┤
│ - DangKyPhongId: int                    - TrangThai: TrangThaiDangKy           │
│ - HocPhanId: int                        - MucDoUuTien: MucDoUuTien             │
│ - PhongMayId: int                       - CanVanBanXacNhan: bool               │
│ - GiaoVienId: int                       - DaDongDau: bool                      │
│ - NgayBatDau: DateTime                  - NgayDangKy: DateTime                 │
│ - NgayKetThuc: DateTime                 - NguoiDuyetPDTId: int?                │
│ - ThuTrongTuan: string                  - NgayDuyetPDT: DateTime?              │
│ - GioBatDau: TimeSpan                   - LyDoTuChoiPDT: string                │
│ - GioKetThuc: TimeSpan                  - NguoiDuyetTTDTId: int?               │
│ - SoLuongSinhVien: int                  - NgayDuyetTTDT: DateTime?             │
│ - GhiChu: string                        - LyDoTuChoiTTDT: string               │
└────────────────────────────────────────────────────────────────────────────────┘
         │                    │                    │
         │ 1                  │ *                  │ *
         │                    │                    │
         ▼ *                  ▼ 1                  ▼ 1
┌────────────────────┐ ┌────────────────────┐ ┌────────────────────┐
│   LichSuDangKy     │ │     HocPhan        │ │     PhongMay       │
├────────────────────┤ ├────────────────────┤ ├────────────────────┤
│ - LichSuDangKyId   │ │ - HocPhanId        │ │ - PhongMayId       │
│ - DangKyPhongId    │ │ - MaHocPhan        │ │ - MaPhong          │
│ - NguoiThucHienId  │ │ - TenHocPhan       │ │ - TenPhong         │
│ - HanhDong         │ │ - SoTinChi         │ │ - SoLuongMay       │
│ - NoiDung          │ │ - MoTa             │ │ - SoMayHong        │
│ - TrangThaiCu      │ │ - TrangThaiHoatDong│ │ - ViTri            │
│ - TrangThaiMoi     │ └────────────────────┘ │ - TrangThai        │
│ - ThoiGian         │                        │ - GhiChu           │
└────────────────────┘                        │ + SucChuaThucTe()  │
                                              └─────────┬──────────┘
                                                        │ 1
                                                        │
         ┌──────────────────────────────────────────────┼──────────────────┐
         │                                              │                  │
         ▼ *                                            ▼ *                ▼ *
┌────────────────────┐                        ┌────────────────────┐ ┌────────────────┐
│  PhongMayPhanMem   │                        │    BaoTriPhong     │ │   PhanMem      │
├────────────────────┤                        ├────────────────────┤ ├────────────────┤
│ - PhongMayPhanMemId│                        │ - BaoTriPhongId    │ │ - PhanMemId    │
│ - PhongMayId       │                        │ - PhongMayId       │ │ - TenPhanMem   │
│ - PhanMemId        │                        │ - NguoiBaoCaoId    │ │ - PhienBan     │
│ - NgayCaiDat       │                        │ - NgayBaoCao       │ │ - NhaSanXuat   │
│ - GhiChu           │                        │ - MoTa             │ │ - MoTa         │
└────────────────────┘                        │ - TrangThai        │ │ - TrangThai    │
                                              │ - NguoiXuLyId      │ └────────────────┘
                                              │ - NgayHoanThanh    │
                                              └────────────────────┘
```

### 4.5. SEQUENCE DIAGRAM - Đăng ký phòng

```
┌─────┐          ┌────────────────┐    ┌────────────────┐    ┌─────────────┐    ┌──────────┐
│ GV  │          │ DangKyPhong    │    │ DangKyPhong    │    │ UnitOfWork  │    │   DB     │
│     │          │ Controller     │    │ Service        │    │             │    │          │
└──┬──┘          └───────┬────────┘    └───────┬────────┘    └──────┬──────┘    └────┬─────┘
   │                     │                     │                    │                │
   │  1. Create(model)   │                     │                    │                │
   │────────────────────►│                     │                    │                │
   │                     │                     │                    │                │
   │                     │  2. TaoDangKyAsync()│                    │                │
   │                     │────────────────────►│                    │                │
   │                     │                     │                    │                │
   │                     │                     │ 3. CheckCapacity() │                │
   │                     │                     │───────────────────►│                │
   │                     │                     │                    │  4. Query      │
   │                     │                     │                    │───────────────►│
   │                     │                     │                    │◄───────────────│
   │                     │                     │◄───────────────────│                │
   │                     │                     │                    │                │
   │                     │                     │ 5. CheckConflict() │                │
   │                     │                     │───────────────────►│                │
   │                     │                     │                    │  6. Query      │
   │                     │                     │                    │───────────────►│
   │                     │                     │                    │◄───────────────│
   │                     │                     │◄───────────────────│                │
   │                     │                     │                    │                │
   │                     │                     │ 7. BeginTransaction│                │
   │                     │                     │───────────────────►│                │
   │                     │                     │                    │                │
   │                     │                     │ 8. AddAsync()      │                │
   │                     │                     │───────────────────►│                │
   │                     │                     │                    │  9. Insert     │
   │                     │                     │                    │───────────────►│
   │                     │                     │                    │◄───────────────│
   │                     │                     │                    │                │
   │                     │                     │ 10.SaveChanges()   │                │
   │                     │                     │───────────────────►│                │
   │                     │                     │                    │ 11. Commit     │
   │                     │                     │                    │───────────────►│
   │                     │                     │                    │◄───────────────│
   │                     │                     │                    │                │
   │                     │                     │ 12.GuiThongBao()   │                │
   │                     │                     │────────────┐       │                │
   │                     │                     │◄───────────┘       │                │
   │                     │                     │                    │                │
   │                     │◄────────────────────│                    │                │
   │                     │   ServiceResult     │                    │                │
   │                     │                     │                    │                │
   │◄────────────────────│                     │                    │                │
   │   Redirect/View     │                     │                    │                │
```

### 4.6. ACTIVITY DIAGRAM - Quy trình duyệt đăng ký

```
                        ┌─────────────────┐
                        │   Bắt đầu       │
                        └────────┬────────┘
                                 │
                                 ▼
                        ┌─────────────────┐
                        │  GV tạo đăng ký │
                        │      phòng      │
                        └────────┬────────┘
                                 │
                                 ▼
                        ┌─────────────────┐
                        │  Trạng thái:    │
                        │  ChoDuyetPDT    │
                        └────────┬────────┘
                                 │
                                 ▼
                   ┌──────────────────────────┐
                   │    PDT xem xét đăng ký   │
                   └─────────────┬────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
                    ▼                         ▼
           ┌────────────────┐        ┌────────────────┐
           │  PDT Từ chối   │        │   PDT Đồng ý   │
           └───────┬────────┘        └───────┬────────┘
                   │                         │
                   ▼                         ▼
           ┌────────────────┐        ┌────────────────┐
           │  Trạng thái:   │        │  Trạng thái:   │
           │  PDTTuChoi     │        │  ChoDuyetTTDT  │
           └───────┬────────┘        └───────┬────────┘
                   │                         │
                   │                         ▼
                   │            ┌──────────────────────────┐
                   │            │   TTDT xem xét đăng ký   │
                   │            └─────────────┬────────────┘
                   │                          │
                   │             ┌────────────┴────────────┐
                   │             │                         │
                   │             ▼                         ▼
                   │    ┌────────────────┐        ┌────────────────┐
                   │    │  TTDT Từ chối  │        │  TTDT Đồng ý   │
                   │    └───────┬────────┘        └───────┬────────┘
                   │            │                         │
                   │            ▼                         ▼
                   │    ┌────────────────┐        ┌────────────────┐
                   │    │  Trạng thái:   │        │  Trạng thái:   │
                   │    │  TTDTTuChoi    │        │  TTDTDongY     │
                   │    └───────┬────────┘        └───────┬────────┘
                   │            │                         │
                   │            │                         ▼
                   │            │                ┌────────────────┐
                   │            │                │  Đăng ký được  │
                   │            │                │    phê duyệt   │
                   │            │                └───────┬────────┘
                   │            │                        │
                   └────────────┴───────────┬───────────┘
                                            │
                                            ▼
                               ┌─────────────────────────┐
                               │  Gửi thông báo cho GV   │
                               └────────────┬────────────┘
                                            │
                                            ▼
                                   ┌────────────────┐
                                   │   Kết thúc     │
                                   └────────────────┘
```

### 4.7. STATE DIAGRAM - Trạng thái đăng ký phòng

```
                                    ┌────────────────────┐
                                    │    ChoDuyetPDT     │◄─────────────────┐
                                    │    (Khởi tạo)      │                  │
                                    └─────────┬──────────┘                  │
                                              │                             │
                           ┌──────────────────┼──────────────────┐          │
                           │                  │                  │          │
                           ▼                  │                  ▼          │
                  ┌────────────────┐          │         ┌────────────────┐  │
                  │  PDTTuChoi     │          │         │   PDTDongY     │  │
                  │  (Kết thúc)    │          │         └───────┬────────┘  │
                  └────────────────┘          │                 │           │
                                              │                 ▼           │
                                              │        ┌────────────────┐   │
                                              │        │ ChoDuyetTTDT   │   │
                                              │        └───────┬────────┘   │
                                              │                │            │
                                   ┌──────────┴────────────────┼──────────┐ │
                                   │                           │          │ │
                                   ▼                           ▼          │ │
                          ┌────────────────┐          ┌────────────────┐  │ │
                          │  TTDTTuChoi    │          │   TTDTDongY    │  │ │
                          │  (Kết thúc)    │          │  (Kết thúc)    │  │ │
                          └────────────────┘          └───────┬────────┘  │ │
                                                              │           │ │
                                                              │           │ │
                  ┌───────────────────────────────────────────┴───────────┘ │
                  │                                                         │
                  │                        ┌────────────────┐                │
                  │                        │     DaHuy      │                │
                  │                        │   (Kết thúc)   │                │
                  │                        └────────────────┘                │
                  │                               ▲                          │
                  │                               │                          │
                  └───────────────────────────────┴──────────────────────────┘
                        (Có thể hủy từ bất kỳ trạng thái nào trước Đồng ý)
```

### 4.8. ER DIAGRAM

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                                    ER DIAGRAM                                             │
└──────────────────────────────────────────────────────────────────────────────────────────┘

    ┌──────────────┐         ┌──────────────┐         ┌──────────────┐
    │   PhongBan   │         │   VaiTro     │         │    Quyen     │
    ├──────────────┤         ├──────────────┤         ├──────────────┤
    │ *PhongBanId  │         │ *VaiTroId    │         │ *QuyenId     │
    │  TenPhongBan │         │  TenVaiTro   │         │  TenQuyen    │
    │  MoTa        │         │  MoTa        │         │  MaQuyen     │
    └──────┬───────┘         └──────┬───────┘         └──────┬───────┘
           │ 1                      │ 1                      │ 1
           │                        │                        │
           │                        │                        │
           │ N                      │ N                      │ N
    ┌──────▼───────┐         ┌──────▼───────┐         ┌──────▼───────┐
    │   NhanVien   │         │   TaiKhoan   │◄────────│ VaiTroQuyen  │
    ├──────────────┤         ├──────────────┤   N     ├──────────────┤
    │ *MaNhanVien  │◄───────►│ *TaiKhoanId  │         │*VaiTroQuyenId│
    │  HoTen       │    1  1 │  TenDangNhap │         │ @VaiTroId    │
    │  SoDienThoai │         │  MatKhauHash │         │ @QuyenId     │
    │  Email       │         │  @MaNhanVien │         └──────────────┘
    │  @PhongBanId │         │  @VaiTroId   │
    └──────┬───────┘         └──────────────┘
           │ 1
           │
           │ N
    ┌──────▼───────────────────────────────────────────────────────┐
    │                        DangKyPhong                            │
    ├───────────────────────────────────────────────────────────────┤
    │ *DangKyPhongId       │  TrangThai        │  @NguoiDuyetPDTId  │
    │  @HocPhanId          │  MucDoUuTien      │  NgayDuyetPDT      │
    │  @PhongMayId         │  CanVanBanXacNhan │  LyDoTuChoiPDT     │
    │  @GiaoVienId         │  DaDongDau        │  @NguoiDuyetTTDTId │
    │  NgayBatDau          │  NgayDangKy       │  NgayDuyetTTDT     │
    │  NgayKetThuc         │  LaDangKyDauNam   │  LyDoTuChoiTTDT    │
    │  ThuTrongTuan        │  SoVanBan         │  @NguoiDuyetGhiDeId│
    │  GioBatDau           │  TuDongDuyet      │  NgayGhiDe         │
    │  GioKetThuc          │  DaGhiDeLich      │  LyDoGhiDe         │
    │  SoLuongSinhVien     │                   │                    │
    │  GhiChu              │                   │                    │
    └───────┬──────────────┴─────────┬─────────┴────────────────────┘
            │ 1                      │ 1
            │                        │
            │ N                      │ N
    ┌───────▼──────────┐     ┌───────▼──────────┐
    │  LichSuDangKy    │     │  DangKyPhanMem   │
    ├──────────────────┤     ├──────────────────┤
    │ *LichSuDangKyId  │     │*DangKyPhanMemId  │
    │  @DangKyPhongId  │     │  @DangKyPhongId  │
    │  @NguoiThucHienId│     │  @PhanMemId      │
    │  HanhDong        │     └─────────┬────────┘
    │  NoiDung         │               │ N
    │  TrangThaiCu     │               │
    │  TrangThaiMoi    │               │ 1
    │  ThoiGian        │     ┌─────────▼────────┐
    └──────────────────┘     │    PhanMem       │
                             ├──────────────────┤
                             │ *PhanMemId       │
    ┌──────────────┐         │  TenPhanMem      │
    │   HocPhan    │         │  PhienBan        │
    ├──────────────┤         │  NhaSanXuat      │
    │ *HocPhanId   │         │  MoTa            │
    │  MaHocPhan   │         │  TrangThai       │
    │  TenHocPhan  │         └─────────┬────────┘
    │  SoTinChi    │                   │ 1
    │  MoTa        │                   │
    │  TrangThaiHoatDong               │ N
    └──────────────┘         ┌─────────▼────────┐
                             │ PhongMayPhanMem  │
                             ├──────────────────┤
    ┌──────────────┐         │*PhongMayPhanMemId│
    │   PhongMay   │◄────────│  @PhongMayId     │
    ├──────────────┤    1  N │  @PhanMemId      │
    │ *PhongMayId  │         │  NgayCaiDat      │
    │  MaPhong     │         │  GhiChu          │
    │  TenPhong    │         └──────────────────┘
    │  SoLuongMay  │
    │  SoMayHong   │
    │  ViTri       │         ┌──────────────────┐
    │  TrangThai   │◄────────│   BaoTriPhong    │
    │  GhiChu      │    1  N ├──────────────────┤
    └──────────────┘         │ *BaoTriPhongId   │
                             │  @PhongMayId     │
                             │  @NguoiBaoCaoId  │
    ┌──────────────┐         │  NgayBaoCao      │
    │    MuonBu    │         │  MoTa            │
    ├──────────────┤         │  TrangThai       │
    │ *MuonBuId    │         │  @NguoiXuLyId    │
    │  @GiaoVienMuonId       │  NgayHoanThanh   │
    │  @GiaoVienChoMuonId    └──────────────────┘
    │  @DangKyPhongMuonId
    │  @DangKyPhongTraBuId
    │  NgayMuon
    │  LyDo
    │  TrangThai
    │  @NguoiDuyetId
    │  NgayDuyet
    └──────────────┘

Chú thích:
* = Primary Key (Khóa chính)
@ = Foreign Key (Khóa ngoại)
1:N = Quan hệ một-nhiều
N:N = Quan hệ nhiều-nhiều (thông qua bảng trung gian)
```

### 4.9. DATA DICTIONARY

#### Bảng DangKyPhong (Đăng ký phòng)

| Tên trường | Kiểu dữ liệu | Ràng buộc | Mô tả |
|------------|--------------|-----------|-------|
| DangKyPhongId | int | PK, Identity | Mã đăng ký phòng |
| HocPhanId | int | FK, NOT NULL | Mã học phần |
| PhongMayId | int | FK, NOT NULL | Mã phòng máy |
| GiaoVienId | int | FK, NOT NULL | Mã giáo viên đăng ký |
| NgayBatDau | datetime | NOT NULL | Ngày bắt đầu sử dụng |
| NgayKetThuc | datetime | NOT NULL | Ngày kết thúc sử dụng |
| ThuTrongTuan | nvarchar(20) | NULL | Các thứ trong tuần (VD: "2,4,6") |
| GioBatDau | time | NOT NULL | Giờ bắt đầu |
| GioKetThuc | time | NOT NULL | Giờ kết thúc |
| SoLuongSinhVien | int | NOT NULL | Số sinh viên dự kiến |
| GhiChu | nvarchar(1000) | NULL | Ghi chú thêm |
| TrangThai | int | NOT NULL, DEFAULT 0 | Enum: 0-ChoDuyetPDT, 1-PDTTuChoi, 2-PDTDongY, 3-ChoDuyetTTDT, 4-TTDTTuChoi, 5-TTDTDongY, 6-DaHuy |
| MucDoUuTien | int | NOT NULL, DEFAULT 3 | Enum: 1-5 (ThapNhat đến CaoNhat) |
| CanVanBanXacNhan | bit | NOT NULL, DEFAULT 1 | Cần văn bản xác nhận không |
| DaDongDau | bit | NOT NULL, DEFAULT 0 | Đã đóng dấu chưa |
| NgayDangKy | datetime | NOT NULL, DEFAULT GETDATE() | Ngày tạo đăng ký |
| NguoiDuyetPDTId | int | FK, NULL | Người duyệt PDT |
| NgayDuyetPDT | datetime | NULL | Ngày duyệt PDT |
| LyDoTuChoiPDT | nvarchar(500) | NULL | Lý do từ chối (nếu có) |
| NguoiDuyetTTDTId | int | FK, NULL | Người duyệt TTDT |
| NgayDuyetTTDT | datetime | NULL | Ngày duyệt TTDT |
| LyDoTuChoiTTDT | nvarchar(500) | NULL | Lý do từ chối TTDT |

#### Bảng PhongMay (Phòng máy)

| Tên trường | Kiểu dữ liệu | Ràng buộc | Mô tả |
|------------|--------------|-----------|-------|
| PhongMayId | int | PK, Identity | Mã phòng máy |
| MaPhong | nvarchar(50) | NOT NULL, UNIQUE | Mã phòng (VD: A101) |
| TenPhong | nvarchar(100) | NOT NULL | Tên phòng máy |
| SoLuongMay | int | NOT NULL | Tổng số máy |
| SoMayHong | int | NOT NULL, DEFAULT 0 | Số máy hỏng |
| ViTri | nvarchar(200) | NULL | Vị trí phòng |
| TrangThai | bit | NOT NULL, DEFAULT 1 | Trạng thái hoạt động |
| GhiChu | nvarchar(500) | NULL | Ghi chú |
| **SucChuaThucTe** | *Computed* | | = SoLuongMay - SoMayHong |

### 4.10. BUSINESS RULES

| ID | Quy tắc | Mô tả | Áp dụng |
|----|---------|-------|---------|
| BR01 | Đăng ký trước tối thiểu | Giáo viên phải đăng ký trước ít nhất X ngày (cấu hình) | Create |
| BR02 | Kiểm tra xung đột | Không cho phép 2 đăng ký cùng phòng, cùng thời gian | Create, Edit |
| BR03 | Kiểm tra sức chứa | Số SV không được vượt sức chứa thực tế của phòng | Create, Edit |
| BR04 | Workflow duyệt | Phải duyệt PDT trước, sau đó mới đến TTDT | Approve |
| BR05 | Tự động duyệt | Đăng ký đầu năm có văn bản xác nhận được tự động duyệt | Create |
| BR06 | Ghi đè lịch | Chỉ QL_TT và Admin mới được ghi đè lịch đã duyệt | Override |
| BR07 | Hủy đăng ký | Chỉ có thể hủy đăng ký chưa được TTDT duyệt | Cancel |
| BR08 | Sửa đăng ký | Chỉ sửa được đăng ký ở trạng thái ChoDuyetPDT | Edit |

---

## 5. KẾT LUẬN VÀ ĐỀ XUẤT

### 5.1. Tóm tắt đánh giá

| Khía cạnh | Điểm | Đánh giá |
|-----------|------|----------|
| Kiến trúc | 8/10 | Clean Architecture, patterns tốt |
| Code Quality | 6/10 | Fat controllers, duplicate code |
| Documentation | 4/10 | Thiếu SRS, User Stories |
| Testing | 6/10 | Có test nhưng chưa đầy đủ |
| Business Logic | 8/10 | Quy trình rõ ràng, đầy đủ |
| Security | 7/10 | Cookie Auth, nhưng thiếu audit log API |

### 5.2. Đề xuất cải thiện

#### Cho BA:
1. Hoàn thiện tài liệu SRS_Document.md
2. Viết User Stories với Acceptance Criteria
3. Tạo Glossary (từ điển thuật ngữ)
4. Định nghĩa Test Cases cho UAT

#### Cho DEV:
1. Refactor DangKyPhongController sử dụng IDangKyPhongService
2. Xóa các file duplicate (.bak, *New.cs)
3. Thêm Data Annotations cho ViewModels
4. Implement Global Exception Handler
5. Thay magic numbers bằng constants/enums
6. Hoàn thiện Unit Tests

### 5.3. Checklist cho môn Phân tích Thiết kế

- [x] Mô tả bài toán
- [x] Danh sách Actors
- [x] Danh sách Use Cases
- [x] Use Case Diagram
- [x] Class Diagram
- [x] Sequence Diagram
- [x] Activity Diagram
- [x] State Diagram
- [x] ER Diagram
- [x] Data Dictionary
- [x] Business Rules
- [ ] User Stories (cần bổ sung)
- [ ] Test Cases (cần bổ sung)

---

## 6. BẢNG KIỂM TRA CHỨC NĂNG YÊU CẦU

### 6.1. Luồng xử lý nghiệp vụ

| STT | Luồng xử lý | Trạng thái | Ghi chú |
|-----|------------|------------|---------|
| **Vai trò Giảng viên đổi lịch thực hành** |
| 1 | B1: GV điền thông tin đổi lịch TH | ⚠️ **CHƯA HOÀN THIỆN** | Hiện chỉ có chức năng Mượn-Bù, chưa có form "đổi lịch" riêng |
| 2 | B2: PDT từ chối/xác nhận yêu cầu đổi lịch | ⚠️ **CHƯA HOÀN THIỆN** | Workflow hiện tại: PDT duyệt đăng ký mới, không có "yêu cầu đổi" |
| 3 | B3: TTDT thay đổi lịch nếu đủ điều kiện | ✅ **ĐÃ CÓ** | Có chức năng duyệt TTDT và ghi đè lịch |
| 4 | B4: TTDT gửi thông tin đến PDT và GV | ✅ **ĐÃ CÓ** | Hệ thống thông báo đã triển khai |
| **Vai trò NV đăng ký lịch TH cho môn học** |
| 5 | B1: PDT gửi yêu cầu đăng ký lịch TH | ⚠️ **CHƯA HOÀN THIỆN** | PDT chỉ có quyền duyệt, không có quyền tạo đăng ký |
| 6 | B2: TTDT nhận yêu cầu và tạo lịch | ✅ **ĐÃ CÓ** | TTDT có thể tạo và duyệt đăng ký |

### 6.2. Chức năng hệ thống

| STT | Chức năng | Trạng thái | File/Component | Ghi chú |
|-----|-----------|------------|----------------|---------|
| 1 | Đăng ký phòng TH | ✅ **ĐÃ CÓ** | `DangKyPhongController.cs`, `Views/DangKyPhong/` | Hoàn thiện đầy đủ |
| 2 | Lịch sử đăng ký | ✅ **ĐÃ CÓ** | `LichSuDangKy.cs`, `LichSuDangKyRepository.cs` | Lưu trữ mọi thay đổi |
| 3 | Thông báo kết quả | ✅ **ĐÃ CÓ** | `ThongBaoService.cs`, `ThongBaoController.cs` | Thông báo đến GV, PDT, TTDT |
| 4 | Báo cáo thống kê | ✅ **ĐÃ CÓ** | `BaoCaoController.cs`, `Views/BaoCao/` | - Tần suất sử dụng phòng ✅<br>- Danh sách xung đột ✅<br>- Top phần mềm yêu cầu ✅ |
| 5 | Dashboard workflow | ✅ **ĐÃ CÓ** | `DashboardController.cs`, `Views/Dashboard/` | Hiển thị tổng quan |
| 6 | Hủy ĐK phòng | ✅ **ĐÃ CÓ** | `DangKyPhongController.Cancel()` | Có kiểm tra quyền |
| 7 | Kiểm tra xung đột tự động | ✅ **ĐÃ CÓ** | `CheckConflict()`, `KiemTraXungDotAsync()` | Cảnh báo ngay khi đăng ký |
| 8 | Thời hạn đăng ký (Deadline) | ✅ **ĐÃ CÓ** | `MinDaysBeforeBooking` trong `appsettings.json` | Cấu hình được (default: 3 ngày) |
| 9 | Quản lý thiết bị hỏng | ✅ **ĐÃ CÓ** | `PhongMay.SoMayHong`, `PhongMay.SucChuaThucTe` | Tự động tính sức chứa |
| 10 | Tích hợp lịch biểu (Calendar View) | ✅ **ĐÃ CÓ** | `Views/DangKyPhong/Calendar.cshtml` | Sử dụng FullCalendar.js |

### 6.3. Nghiệp vụ nâng cao

| STT | Nghiệp vụ | Trạng thái | File/Component | Ghi chú |
|-----|-----------|------------|----------------|---------|
| 1 | Cấp độ ưu tiên (Priority Level) | ✅ **ĐÃ CÓ** | `MucDoUuTien` enum (5 mức) | ThapNhat → CaoNhat |
| 2 | Tự động duyệt (Auto-Approval) | ✅ **ĐÃ CÓ** | `TuDongDuyet`, `LaDangKyDauNam` | Đăng ký đầu năm có văn bản |
| 3 | Quy trình Mượn bù - Trả bù | ✅ **ĐÃ CÓ** | `MuonBu.cs`, `MuonBuController.cs`, `MuonBuService.cs` | Có đầy đủ workflow |
| 4 | Check-list bàn giao phòng | ⚠️ **CÓ MỘT PHẦN** | `BaoTriPhong.cs`, `BaoTriPhongController.cs` | Có báo cáo bảo trì, nhưng CHƯA có checklist trước/sau sử dụng |
| 5 | Yêu cầu cài đặt PM mới | ✅ **ĐÃ CÓ** | `YeuCauCaiDatPhanMem.cs`, `YeuCauCaiDatController.cs` | Có luồng duyệt từ QL TT |
| 6 | Ghi đè lịch | ✅ **ĐÃ CÓ** | `GhiDeLich` actions, `DaGhiDeLich` flag | Chỉ QL_TT và Admin |

### 6.4. Tóm tắt trạng thái

```
┌─────────────────────────────────────────────────────────────────────┐
│                    TỔNG KẾT TÌNH TRẠNG                              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ✅ ĐÃ HOÀN THIỆN:  14/18 chức năng (78%)                         │
│   ⚠️ CẦN BỔ SUNG:     4/18 chức năng (22%)                         │
│   ❌ CHƯA CÓ:         0/18 chức năng (0%)                          │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 6.5. Danh sách cần bổ sung

| # | Tính năng cần bổ sung | Độ ưu tiên | Mô tả chi tiết |
|---|----------------------|------------|----------------|
| 1 | **Form đổi lịch riêng** | CAO | Tạo UC riêng cho GV đổi lịch TH (khác với đăng ký mới). Luồng: GV → PDT → TTDT |
| 2 | **PDT tạo yêu cầu đăng ký** | TRUNG BÌNH | Cho phép PDT tạo yêu cầu đăng ký lịch TH hàng loạt cho các môn học |
| 3 | **Checklist bàn giao phòng** | TRUNG BÌNH | Form checklist trước/sau khi GV sử dụng phòng (kiểm tra chuột, bàn phím, màn hình...) |
| 4 | **Workflow đổi lịch hoàn chỉnh** | CAO | Tách biệt workflow "đổi lịch" với "đăng ký mới" và "mượn-bù" |

---

## 7. ĐỀ XUẤT CẢI TIẾN

### 7.1. Cải tiến luồng đổi lịch

```csharp
// Đề xuất thêm Model: DoiLich.cs
public class DoiLich
{
    public int DoiLichId { get; set; }
    public int DangKyPhongCuId { get; set; }  // Lịch cần đổi
    public int? DangKyPhongMoiId { get; set; } // Lịch mới (sau khi tạo)
    
    // Thông tin lịch mới muốn đổi sang
    public int PhongMayMoiId { get; set; }
    public DateTime NgayMoi { get; set; }
    public TimeSpan GioBatDauMoi { get; set; }
    public TimeSpan GioKetThucMoi { get; set; }
    
    public string LyDoDoiLich { get; set; }
    public TrangThaiDoiLich TrangThai { get; set; }
    
    // Duyệt
    public int? NguoiDuyetPDTId { get; set; }
    public int? NguoiDuyetTTDTId { get; set; }
}

public enum TrangThaiDoiLich
{
    ChoDuyetPDT,
    PDTDongY,
    PDTTuChoi,
    ChoDuyetTTDT,
    TTDTDongY,
    TTDTTuChoi,
    DaHoanThanh
}
```

### 7.2. Cải tiến Checklist bàn giao

```csharp
// Đề xuất thêm Model: BanGiaoPhong.cs
public class BanGiaoPhong
{
    public int BanGiaoId { get; set; }
    public int DangKyPhongId { get; set; }
    
    // Checklist trước khi sử dụng
    public bool TruocSuDung_MayTinhHoatDong { get; set; }
    public bool TruocSuDung_ChuotHoatDong { get; set; }
    public bool TruocSuDung_BanPhimHoatDong { get; set; }
    public bool TruocSuDung_ManHinhHoatDong { get; set; }
    public bool TruocSuDung_DieuHoaHoatDong { get; set; }
    public string? TruocSuDung_GhiChu { get; set; }
    public DateTime? TruocSuDung_ThoiGian { get; set; }
    public int? TruocSuDung_NguoiKiemTraId { get; set; }
    
    // Checklist sau khi sử dụng
    public bool SauSuDung_MayTinhHoatDong { get; set; }
    public bool SauSuDung_ChuotHoatDong { get; set; }
    public bool SauSuDung_BanPhimHoatDong { get; set; }
    public bool SauSuDung_ManHinhHoatDong { get; set; }
    public bool SauSuDung_DieuHoaHoatDong { get; set; }
    public string? SauSuDung_GhiChu { get; set; }
    public DateTime? SauSuDung_ThoiGian { get; set; }
    public int? SauSuDung_NguoiKiemTraId { get; set; }
}
```

---

*Tài liệu được tạo tự động từ phân tích mã nguồn dự án QL_TH_MT*
