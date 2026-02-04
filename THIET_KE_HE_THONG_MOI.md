# THIẾT KẾ HỆ THỐNG QUẢN LÝ LỊCH THỰC HÀNH UTC2

## 1. TÁC NHÂN (ACTORS)

### 1.1 Giảng viên
- **GV Thỉnh giảng**: Đăng ký lịch có thể dạy, nhận lịch giảng dạy
- **GV Cố hữu**: Chỉ nhận lịch giảng dạy (không cần đăng ký)

### 1.2 Phòng Đào Tạo (PDT)
- Quản lý môn học
- Quản lý học phần  
- Quản lý hợp đồng giảng dạy
- Thiết lập mốc thời gian học kỳ
- Sắp xếp lịch thực hành
- Duyệt yêu cầu đổi lịch/mượn bù

### 1.3 Trung Tâm Đào Tạo Thực Hành (TTDT)
- Quản lý phòng máy
- Quản lý phần mềm
- Xác nhận lịch thực hành
- Duyệt yêu cầu đổi lịch/mượn bù

### 1.4 Admin
- Quản lý tài khoản người dùng

---

## 2. MỐC THỜI GIAN & GIAI ĐOẠN

### 2.1 Ba mốc thời gian chính
```
|--- Tiền HK ---|--- Bắt đầu HK ---|--- Kết thúc HK ---|
    (4 tuần)         (n+3+3 tuần)
```

### 2.2 Giai đoạn "Trước học kỳ" (4 tuần)

| Tuần | Tên giai đoạn | Người thực hiện | Công việc |
|------|---------------|-----------------|-----------|
| 1 | GD1_NhapLieu | PDT + TTDT | PDT: Nhập hợp đồng (liên kết GV-Môn học)<br>TTDT: Kiểm kê, thêm mới phòng TH |
| 2 | GD2_DangKyLich | GV Thỉnh giảng | Đăng ký ngày có thể dạy TH (≥3 tuần liên tiếp cùng thứ, cùng ca) |
| 3 | GD3_SapXepLich | PDT | Sắp xếp lịch TH (ưu tiên GV thỉnh giảng > GV cố hữu)<br>TTDT xác nhận |
| 4 | GD4_ThongBao | Tất cả | Thông báo lịch cho GV<br>GV có thể yêu cầu đổi lịch/mượn bù |

### 2.3 Giai đoạn "Học kỳ diễn ra"

| Giai đoạn | Số tuần | Mô tả |
|-----------|---------|-------|
| Lý thuyết | n tuần | n = f(số tín chỉ): 1TC→0, 2TC→4, 3TC→6, 4TC→8 |
| Thực hành | 3 tuần | Mỗi học phần có 3 buổi TH liên tiếp |
| Ôn tập + Thi | 3 tuần | Không được xếp lịch TH |

---

## 3. MODELS CẦN THIẾT

### 3.1 Entities chính

```csharp
// HocKy - Quản lý mốc thời gian
HocKy {
    HocKyId, TenHocKy, NamHoc, SoHocKy
    NgayTienHocKy      // Bắt đầu 4 tuần trước HK
    NgayBatDauHocKy    // Ngày HK bắt đầu
    NgayKetThucHocKy   // Ngày HK kết thúc
    DangHoatDong
}

// MonHoc - Môn học
MonHoc {
    MonHocId, MaMonHoc, TenMonHoc
    SoTinChi           // 1-4
    SoBuoiThucHanh     // Luôn = 3
}

// HopDongGiangDay - Liên kết GV với Môn học trong HK
HopDongGiangDay {
    HopDongId, MaHopDong
    HocKyId, GiangVienId, MonHocId
    SoNhomThucHanh     // Số nhóm TH
    TrangThai          // ChoXacNhan, DaDuyet, TuChoi
}

// DangKyLichDay - GV thỉnh giảng đăng ký lịch có thể dạy
DangKyLichDay {
    DangKyId
    HopDongId          // Hợp đồng nào
    ThuTrongTuan       // Thứ 2-CN
    CaHoc              // Ca 1-6
    TuanBatDau         // Tuần bắt đầu trong HK
    SoTuanLienTiep     // ≥ 3
    TrangThai          // ChoDuyet, DaDuyet, TuChoi
}

// LichThucHanh - Lịch TH chính thức
LichThucHanh {
    LichTHId, MaLich
    HopDongId, PhongMayId, HocKyId
    NhomTH             // Nhóm TH 1, 2, 3...
    BuoiThu            // Buổi 1/3, 2/3, 3/3
    TuanHoc            // Tuần trong HK
    ThuTrongTuan, CaHoc
    NgayHoc            // Ngày cụ thể
    TrangThai          // ChoDuyet, PDTDuyet, TTDTDuyet, HoanThanh
}

// YeuCauDoiLich - Đổi lịch hoặc mượn bù
YeuCauDoiLich {
    YeuCauId
    LoaiYeuCau         // DoiLich, MuonBu
    LichTHGocId        // Lịch gốc cần đổi
    
    // Thông tin đổi mới
    NgayMoi, CaMoi, PhongMoi
    
    // Duyệt 2 cấp
    TrangThaiPDT, TrangThaiTTDT
    NgayDuyetPDT, NgayDuyetTTDT
}

// PhongMay - Phòng máy
PhongMay {
    PhongMayId, MaPhong, TenPhong
    SoMay, ViTri
    TrangThai          // HoatDong, BaoTri, KhongHoatDong
}
```

---

## 4. LUỒNG XỬ LÝ CHÍNH

### 4.1 Luồng Giai đoạn 1: Nhập liệu (Tuần 1)

```
PDT đăng nhập
    └── Vào menu "Quản lý Hợp đồng"
        └── Tạo mới Hợp đồng
            ├── Chọn Học kỳ
            ├── Chọn Giảng viên (từ danh sách)
            ├── Chọn Môn học (từ danh sách)
            ├── Nhập số nhóm TH
            └── Lưu

TTDT đăng nhập
    └── Vào menu "Quản lý Phòng máy"
        ├── Kiểm kê phòng hiện có
        ├── Cập nhật trạng thái
        └── Thêm phòng mới nếu cần
```

### 4.2 Luồng Giai đoạn 2: GV Thỉnh giảng đăng ký (Tuần 2)

```
GV Thỉnh giảng đăng nhập
    └── Xem danh sách Hợp đồng của mình
        └── Với mỗi hợp đồng, đăng ký lịch:
            ├── Hiển thị form lịch tuần (T2-CN, Ca 1-6)
            ├── GV tích chọn (Thứ, Ca)
            ├── Chọn tuần bắt đầu
            ├── Nhập số tuần liên tiếp (≥3)
            └── Gửi đăng ký

PDT duyệt đăng ký
    └── Xem danh sách đăng ký
        └── Duyệt hoặc Từ chối từng đăng ký
```

### 4.3 Luồng Giai đoạn 3: Sắp xếp lịch TH (Tuần 3)

```
PDT đăng nhập
    └── Vào menu "Sắp xếp lịch"
        └── Hệ thống tự động sắp xếp:
            
            Bước 1: Ưu tiên GV Thỉnh giảng
            ├── Lấy tất cả DangKyLichDay đã duyệt
            ├── Sắp theo độ ưu tiên, ngày đăng ký
            └── Với mỗi đăng ký:
                ├── Tìm phòng trống theo (Thứ, Ca)
                ├── Kiểm tra không xung đột
                └── Tạo 3 buổi LichThucHanh liên tiếp

            Bước 2: GV Cố hữu
            ├── Lấy hợp đồng GV cố hữu chưa có lịch
            └── Tự động xếp vào slot trống

        └── PDT xem kết quả và điều chỉnh thủ công nếu cần
        └── TTDT xác nhận lịch
```

### 4.4 Luồng Giai đoạn 4: Thông báo & Điều chỉnh (Tuần 4)

```
Hệ thống gửi thông báo lịch đến GV

GV muốn đổi lịch
    └── Tạo yêu cầu đổi lịch:
        ├── Chọn buổi TH cần đổi
        ├── Chọn ngày mới (trong phạm vi 1 tuần)
        ├── Chọn ca mới, phòng mới (nếu đổi phòng)
        └── Gửi yêu cầu

    └── Luồng duyệt 2 cấp:
        PDT duyệt trước
            └── Nếu đồng ý → Chuyển TTDT
            └── Nếu từ chối → Thông báo GV
        
        TTDT duyệt sau
            └── Kiểm tra phòng trống
            └── Nếu đồng ý → Cập nhật lịch
            └── Nếu từ chối → Thông báo GV
```

---

## 5. CONTROLLERS CẦN XÂY DỰNG

| Controller | Role | Chức năng |
|------------|------|-----------|
| `AccountController` | All | Đăng nhập, đăng xuất, đổi mật khẩu |
| `DashboardController` | All | Trang tổng quan theo role |
| `HocKyController` | PDT | CRUD học kỳ, thiết lập mốc thời gian |
| `MonHocController` | PDT | CRUD môn học |
| `HopDongController` | PDT | CRUD hợp đồng, liên kết GV-Môn |
| `PhongMayController` | TTDT | CRUD phòng máy |
| `PhanMemController` | TTDT | CRUD phần mềm |
| `DangKyLichController` | GV TG + PDT | GV đăng ký, PDT duyệt |
| `XepLichController` | PDT + TTDT | Sắp xếp lịch TH, TTDT xác nhận |
| `LichGiangDayController` | GV | Xem lịch giảng dạy |
| `DoiLichController` | GV + PDT + TTDT | Yêu cầu đổi lịch, duyệt 2 cấp |
| `TaiKhoanController` | Admin | CRUD tài khoản |

---

## 6. QUY TẮC NGHIỆP VỤ

### 6.1 Đăng ký lịch GV Thỉnh giảng
- Tối thiểu 3 tuần liên tiếp cùng thứ, cùng ca
- Phải đăng ký trong Giai đoạn 2
- Cần PDT duyệt

### 6.2 Sắp xếp lịch TH
- Ưu tiên: GV Thỉnh giảng > GV Cố hữu
- Mỗi nhóm TH có 3 buổi liên tiếp
- Không được xếp vào 3 tuần cuối (ôn thi)
- Phải sau n tuần lý thuyết

### 6.3 Đổi lịch / Mượn bù
- Ngày đổi trong phạm vi 1 tuần so với ngày gốc
- Cần cả PDT và TTDT đồng ý
- Không được xung đột với lịch khác

---

## 7. GIAO DIỆN CHÍNH

### 7.1 Dashboard theo role

**Admin:**
- Thống kê tài khoản
- Quản lý tài khoản

**PDT:**
- Giai đoạn hiện tại
- Số hợp đồng cần nhập
- Số đăng ký chờ duyệt
- Số yêu cầu đổi lịch chờ xử lý

**TTDT:**
- Số phòng máy
- Lịch TH chờ xác nhận
- Số yêu cầu đổi lịch chờ xử lý

**GV Thỉnh giảng:**
- Giai đoạn hiện tại
- Hợp đồng của tôi
- Đăng ký lịch của tôi
- Lịch giảng dạy

**GV Cố hữu:**
- Hợp đồng của tôi
- Lịch giảng dạy

### 7.2 Form đăng ký lịch (GV Thỉnh giảng)

```
┌─────────────────────────────────────────────┐
│  ĐĂNG KÝ LỊCH CÓ THỂ DẠY THỰC HÀNH         │
├─────────────────────────────────────────────┤
│  Hợp đồng: [HD001 - Lập trình C# - HK2]    │
│  Số buổi TH: 3 buổi                         │
├─────────────────────────────────────────────┤
│  Chọn lịch rảnh:                            │
│                                             │
│     │ T2 │ T3 │ T4 │ T5 │ T6 │ T7 │ CN │   │
│  Ca1│ ☐  │ ☑  │ ☐  │ ☐  │ ☐  │ ☐  │ ☐  │   │
│  Ca2│ ☐  │ ☐  │ ☐  │ ☑  │ ☐  │ ☐  │ ☐  │   │
│  Ca3│ ☐  │ ☐  │ ☐  │ ☐  │ ☐  │ ☐  │ ☐  │   │
│  Ca4│ ☐  │ ☐  │ ☐  │ ☐  │ ☐  │ ☐  │ ☐  │   │
│                                             │
│  Tuần bắt đầu: [Tuần 7 ▼] (sau n tuần LT)  │
│  Số tuần liên tiếp: [3] (tối thiểu 3)       │
├─────────────────────────────────────────────┤
│          [Gửi đăng ký]  [Hủy]               │
└─────────────────────────────────────────────┘
```

---

## 8. MIGRATION PLAN

1. Giữ nguyên database hiện có
2. Thêm/sửa các bảng cần thiết
3. Xóa Controllers/Views không cần thiết
4. Tạo Controllers/Views mới theo luồng
5. Cập nhật Dashboard theo role
6. Test từng giai đoạn
