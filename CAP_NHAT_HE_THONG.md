# TÓM TẮT CẬP NHẬT HỆ THỐNG QL LỊCH THỰC HÀNH

## 📋 Tổng quan

Đã cập nhật hệ thống theo luồng mới với các thay đổi chính:

## 🔑 5 Vai trò (Actors)

| ID | Vai trò | Mô tả |
|----|---------|-------|
| 1 | Admin | Quản trị hệ thống |
| 2 | QL_TrungTam | Quản lý Trung tâm đào tạo TH (TTDT) |
| 3 | NV_TrungTam | Nhân viên Trung tâm đào tạo TH |
| 4 | PDT | Phòng đào tạo |
| 5 | GV_CoHuu | Giảng viên cố hữu |
| 6 | GV_ThinhGiang | Giảng viên thỉnh giảng |

## ⏰ 3 Mốc thời gian chính (trong HocKy model)

```
NgayTienHocKy → NgayBatDauHocKy → NgayKetThucHocKy
     ↓              ↓                   ↓
 Tiền HK       Bắt đầu HK         Kết thúc HK
```

## 📅 4 Giai đoạn trong Tiền học kỳ (mỗi giai đoạn 1 tuần)

| Giai đoạn | Thời gian | Mô tả |
|-----------|-----------|-------|
| GĐ1 | Tuần 1 | PDT nhập hợp đồng, TTDT kiểm kê phòng |
| GĐ2 | Tuần 2 | GV Thỉnh giảng đăng ký ngày có thể dạy |
| GĐ3 | Tuần 3 | PDT sắp xếp lịch thực hành (ưu tiên GV TG > GV CH) |
| GĐ4 | Tuần 4 | Thông báo và điều chỉnh |

## 🆕 Controllers mới tạo

### 1. DangKyLichController
- **Mục đích**: GV Thỉnh giảng đăng ký ngày có thể dạy (Giai đoạn 2)
- **Actions**:
  - `Index`: Danh sách đăng ký của GV
  - `DangKy (GET/POST)`: Form đăng ký lịch
  - `Details`: Chi tiết đăng ký
  - `Edit`: Sửa đăng ký (chỉ khi chưa duyệt)
  - `Huy`: Hủy đăng ký
  - `DanhSachChoDuyet`: Danh sách chờ PDT duyệt
  - `DuyetPDT/TuChoiPDT`: PDT duyệt/từ chối
  - `DuyetTTDT/TuChoiTTDT`: TTDT duyệt/từ chối

### 2. XepLichController
- **Mục đích**: PDT sắp xếp lịch thực hành tự động (Giai đoạn 3)
- **Actions**:
  - `Index`: Danh sách lịch TH đã xếp
  - `TuDongXepLich`: Chạy thuật toán xếp lịch tự động
  - `XepLichChoHopDong`: Xếp lịch cho từng hợp đồng
  - `KiemTraXungDot`: Kiểm tra xung đột lịch

**Thuật toán ưu tiên**:
1. GV Thỉnh giảng (có đăng ký ngày) > GV Cố hữu
2. 3 buổi TH liên tiếp cùng thứ, cùng ca
3. Không xếp vào 3 tuần cuối (ôn thi)

### 3. YeuCauDoiLichController
- **Mục đích**: Xử lý yêu cầu đổi lịch (trong học kỳ diễn ra)
- **Luồng duyệt**: GV tạo → PDT duyệt → TTDT duyệt
- **Ràng buộc**: Ngày đổi trong phạm vi 1 tuần so với ngày gốc

### 4. MuonBuController
- **Mục đích**: Mượn bù lịch giữa các GV
- **Luồng duyệt**: GV mượn tạo → GV cho mượn đồng ý → PDT duyệt → TTDT duyệt
- **Ràng buộc**: Lịch mượn và lịch bù trong phạm vi 1 tuần

## 📁 Views mới tạo

```
Views/
├── DangKyLich/
│   ├── Index.cshtml           # Danh sách đăng ký của GV
│   └── DangKy.cshtml          # Form đăng ký lịch
├── XepLich/
│   └── Index.cshtml           # Dashboard xếp lịch PDT
├── YeuCauDoiLich/
│   ├── Index.cshtml           # Danh sách yêu cầu
│   ├── ChoDuyetPDT.cshtml     # Danh sách chờ PDT duyệt
│   └── ChoDuyetTTDT.cshtml    # Danh sách chờ TTDT duyệt
└── MuonBu/
    ├── Index.cshtml           # Danh sách yêu cầu mượn bù
    ├── Create.cshtml          # Form tạo yêu cầu mượn
    └── ChoToi.cshtml          # Yêu cầu chờ GV đồng ý
```

## 📊 Model Updates

### MuonBu Model - Cập nhật enum TrangThaiMuonBu
```csharp
public enum TrangThaiMuonBu
{
    ChoGVDongY = 0,      // Chờ GV cho mượn đồng ý
    GVTuChoi = 1,        // GV cho mượn từ chối
    ChoDuyetPDT = 2,     // Chờ PDT duyệt
    PDTDaDuyet = 3,      // PDT đã duyệt, chờ TTDT
    PDTTuChoi = 4,       // PDT từ chối
    TTDTDaDuyet = 5,     // TTDT đã duyệt - Hoàn thành
    TTDTTuChoi = 6,      // TTDT từ chối
    DaHuy = 8            // Đã hủy
}
```

### Thêm các trường mới vào MuonBu:
- `LichMuonId`, `LichBuId` - Liên kết với LichThucHanh
- `NgayGVDongY` - Timestamp GV đồng ý
- `NguoiDuyetPDTId`, `NgayDuyetPDT`, `GhiChuPDT`
- `NguoiDuyetTTDTId`, `NgayDuyetTTDT`, `GhiChuTTDT`

## 🧭 Menu Navigation Updates

Cập nhật `_Layout.cshtml` để thêm các menu:
- **Lịch TH** dropdown:
  - GV Thỉnh giảng: Đăng ký lịch dạy
  - GV: Yêu cầu đổi lịch, Mượn bù
  - PDT: Quản lý HK, Môn học, Hợp đồng, Duyệt đăng ký, Xếp lịch
  - TTDT: Duyệt đổi lịch, Duyệt mượn bù

## 🗄️ Database Migration

- Migration: `UpdateMuonBuModel`
- Đã apply thành công vào database

## 🚀 Trạng thái hiện tại

- ✅ Build thành công (0 errors, 13 warnings)
- ✅ Migration áp dụng thành công
- ✅ Ứng dụng chạy tại http://localhost:5199

## 📝 Việc cần làm tiếp theo

1. Tạo Views còn thiếu (Details, Edit cho các controller)
2. Test các luồng nghiệp vụ
3. Thêm validation business rules
4. Tạo thông báo email/SMS
5. Thêm báo cáo thống kê
