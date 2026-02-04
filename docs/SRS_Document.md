# TÀI LIỆU ĐẶC TẢ YÊU CẦU PHẦN MỀM (SRS)
# HỆ THỐNG QUẢN LÝ ĐĂNG KÝ PHÒNG THỰC HÀNH

**Phiên bản:** 1.0  
**Ngày:** 03/02/2026  
**Tác giả:** Nhóm phát triển QL_TH_MT

---

## MỤC LỤC
1. [Giới thiệu](#1-giới-thiệu)
2. [Mô tả tổng quan](#2-mô-tả-tổng-quan)
3. [Yêu cầu chức năng](#3-yêu-cầu-chức-năng)
4. [Yêu cầu phi chức năng](#4-yêu-cầu-phi-chức-năng)
5. [Giao diện hệ thống](#5-giao-diện-hệ-thống)
6. [Ràng buộc thiết kế](#6-ràng-buộc-thiết-kế)
7. [Phụ lục](#7-phụ-lục)

---

## 1. GIỚI THIỆU

### 1.1. Mục đích
Tài liệu này mô tả chi tiết các yêu cầu phần mềm cho Hệ thống Quản lý Đăng ký Phòng Thực hành Máy tính (QL_TH_MT). Tài liệu được sử dụng bởi:
- Đội ngũ phát triển để hiểu và triển khai hệ thống
- Người dùng cuối để xác nhận yêu cầu
- Đội ngũ kiểm thử để xây dựng test cases

### 1.2. Phạm vi
Hệ thống QL_TH_MT bao gồm:
- Quản lý đăng ký sử dụng phòng thực hành
- Quy trình duyệt đa cấp (PDT → TTDT)
- Quản lý phòng máy, phần mềm, học phần
- Báo cáo bảo trì thiết bị
- Thống kê và báo cáo

### 1.3. Định nghĩa và thuật ngữ

| Thuật ngữ | Định nghĩa |
|-----------|------------|
| GV | Giáo viên/Giảng viên |
| PDT | Phòng Đào Tạo |
| TTDT | Trung tâm Đào Tạo |
| QL_TT | Quản lý Trung tâm |
| NV_TT | Nhân viên Trung tâm |
| PM | Phần mềm |
| SV | Sinh viên |
| Booking | Đăng ký sử dụng phòng |

### 1.4. Tài liệu tham khảo
- README.md - Hướng dẫn sử dụng hệ thống
- PHAN_TICH_DU_AN.md - Phân tích dự án
- Database_Schema.sql - Cấu trúc cơ sở dữ liệu

---

## 2. MÔ TẢ TỔNG QUAN

### 2.1. Bối cảnh sản phẩm
Hệ thống QL_TH_MT là một ứng dụng web độc lập, giúp tự động hóa quy trình đăng ký và quản lý phòng thực hành máy tính tại các cơ sở giáo dục.

### 2.2. Chức năng sản phẩm

```
┌─────────────────────────────────────────────────────────────────────┐
│                    HỆ THỐNG QL_TH_MT                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │
│  │  Quản lý     │  │  Quản lý     │  │  Quản lý     │              │
│  │  Đăng ký     │  │  Phòng máy   │  │  Phần mềm    │              │
│  └──────────────┘  └──────────────┘  └──────────────┘              │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │
│  │  Quản lý     │  │  Báo cáo     │  │  Quản lý     │              │
│  │  Bảo trì     │  │  Thống kê    │  │  Mượn-Bù     │              │
│  └──────────────┘  └──────────────┘  └──────────────┘              │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │
│  │  Xác thực    │  │  Thông báo   │  │  Quản lý     │              │
│  │  & Phân quyền│  │  Hệ thống    │  │  Học phần    │              │
│  └──────────────┘  └──────────────┘  └──────────────┘              │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.3. Đặc điểm người dùng

| Vai trò | Trình độ | Tần suất sử dụng |
|---------|----------|------------------|
| Admin | Cao | Thỉnh thoảng |
| QL_TT | Trung bình-Cao | Hàng ngày |
| NV_TT | Trung bình | Hàng ngày |
| PDT | Trung bình | Hàng ngày |
| GV | Cơ bản | Hàng tuần |

### 2.4. Giả định và phụ thuộc
- Người dùng có kết nối internet ổn định
- Trình duyệt hỗ trợ: Chrome, Firefox, Edge (phiên bản mới nhất)
- SQL Server đã được cài đặt và cấu hình

---

## 3. YÊU CẦU CHỨC NĂNG

### 3.1. UC01 - Đăng nhập hệ thống

**Mô tả:** Người dùng đăng nhập vào hệ thống bằng tài khoản được cấp.

**Tiền điều kiện:** 
- Người dùng có tài khoản trong hệ thống
- Tài khoản đang hoạt động

**Luồng chính:**
1. Người dùng truy cập trang đăng nhập
2. Hệ thống hiển thị form đăng nhập
3. Người dùng nhập tên đăng nhập và mật khẩu
4. Người dùng nhấn nút "Đăng nhập"
5. Hệ thống xác thực thông tin
6. Hệ thống chuyển hướng đến Dashboard

**Luồng thay thế:**
- 5a. Thông tin không hợp lệ:
  - 5a1. Hệ thống hiển thị thông báo lỗi
  - 5a2. Quay lại bước 3

**Hậu điều kiện:**
- Session được tạo với thông tin người dùng
- Cookie authentication được thiết lập

---

### 3.2. UC03 - Tạo đăng ký phòng

**Mô tả:** Giáo viên hoặc nhân viên TTDT tạo yêu cầu đăng ký sử dụng phòng thực hành.

**Actor:** GV, NV_TT, QL_TT, Admin

**Tiền điều kiện:**
- Người dùng đã đăng nhập
- Có quyền tạo đăng ký (REGISTER_ROOM)
- Có ít nhất một phòng máy đang hoạt động

**Luồng chính:**
1. Người dùng chọn menu "Đăng ký phòng" → "Tạo mới"
2. Hệ thống hiển thị form đăng ký với:
   - Danh sách học phần
   - Danh sách phòng máy khả dụng
   - Danh sách giáo viên (nếu là NV_TT trở lên)
   - Danh sách phần mềm
3. Người dùng chọn học phần
4. Người dùng chọn phòng máy
5. Người dùng nhập ngày bắt đầu, ngày kết thúc
6. Người dùng chọn các thứ trong tuần
7. Người dùng nhập giờ bắt đầu, giờ kết thúc
8. Người dùng nhập số lượng sinh viên
9. Người dùng chọn các phần mềm cần thiết
10. Người dùng nhập ghi chú (tùy chọn)
11. Người dùng nhấn "Đăng ký"
12. Hệ thống kiểm tra:
    - Thời hạn đăng ký (≥ 3 ngày trước)
    - Sức chứa phòng
    - Xung đột lịch
13. Hệ thống tạo đăng ký với trạng thái "ChoDuyetPDT"
14. Hệ thống gửi thông báo cho PDT
15. Hệ thống hiển thị thông báo thành công

**Luồng thay thế:**
- 12a. Vi phạm thời hạn đăng ký:
  - 12a1. Hiển thị lỗi "Phải đăng ký trước ít nhất X ngày"
  - 12a2. Quay lại form

- 12b. Vượt sức chứa:
  - 12b1. Hiển thị lỗi "Số SV vượt sức chứa phòng"
  - 12b2. Quay lại form

- 12c. Xung đột lịch:
  - 12c1. Hiển thị thông tin đăng ký trùng
  - 12c2. Quay lại form

**Business Rules:**
| Rule | Mô tả |
|------|-------|
| BR01 | GV phải đăng ký trước ít nhất 3 ngày (cấu hình) |
| BR02 | Số SV ≤ SucChuaThucTe của phòng |
| BR03 | Không được trùng thời gian với đăng ký đã duyệt |
| BR04 | GV chỉ có thể đăng ký cho chính mình |

**Hậu điều kiện:**
- Đăng ký được tạo trong CSDL
- Thông báo được gửi cho PDT
- Lịch sử được ghi nhận

---

### 3.3. UC06 - Duyệt đăng ký (PDT)

**Mô tả:** Nhân viên PDT duyệt hoặc từ chối đăng ký từ giáo viên.

**Actor:** PDT

**Tiền điều kiện:**
- Đăng ký ở trạng thái "ChoDuyetPDT"
- Người dùng có quyền APPROVE_PDT

**Luồng chính (Đồng ý):**
1. PDT xem danh sách đăng ký chờ duyệt
2. PDT chọn một đăng ký để xem chi tiết
3. PDT kiểm tra thông tin đăng ký
4. PDT nhấn "Đồng ý"
5. Hệ thống cập nhật trạng thái → "ChoDuyetTTDT"
6. Hệ thống gửi thông báo cho TTDT và GV
7. Hệ thống ghi lịch sử

**Luồng thay thế (Từ chối):**
- 4a. PDT nhấn "Từ chối":
  - 4a1. Hệ thống hiển thị dialog nhập lý do
  - 4a2. PDT nhập lý do từ chối (bắt buộc)
  - 4a3. Hệ thống cập nhật trạng thái → "PDTTuChoi"
  - 4a4. Hệ thống gửi thông báo cho GV

**Hậu điều kiện:**
- Trạng thái đăng ký được cập nhật
- Thông báo được gửi cho các bên liên quan

---

### 3.4. UC07 - Duyệt đăng ký (TTDT)

**Mô tả:** Nhân viên TTDT duyệt hoặc từ chối đăng ký đã qua PDT.

**Actor:** NV_TT, QL_TT, Admin

**Tiền điều kiện:**
- Đăng ký ở trạng thái "ChoDuyetTTDT"
- Người dùng có quyền APPROVE_TTDT

**Luồng chính:** Tương tự UC06

**Hậu điều kiện:**
- Nếu đồng ý: Trạng thái → "TTDTDongY", đăng ký có hiệu lực
- Nếu từ chối: Trạng thái → "TTDTTuChoi"

---

### 3.5. UC08 - Ghi đè lịch

**Mô tả:** Quản lý có thể ghi đè đăng ký đã được duyệt trong trường hợp đặc biệt.

**Actor:** QL_TT, Admin

**Tiền điều kiện:**
- Có đăng ký đã duyệt cần ghi đè
- Người dùng có quyền MANAGE_ROOM

**Luồng chính:**
1. Quản lý tạo đăng ký mới có xung đột
2. Hệ thống cảnh báo có xung đột
3. Quản lý chọn "Ghi đè"
4. Quản lý nhập lý do ghi đè
5. Hệ thống đánh dấu đăng ký cũ là "DaGhiDeLich"
6. Hệ thống tạo đăng ký mới
7. Hệ thống gửi thông báo cho GV bị ghi đè

**Business Rules:**
| Rule | Mô tả |
|------|-------|
| BR06 | Chỉ QL_TT và Admin mới được ghi đè |
| BR06a | Phải ghi nhận lý do ghi đè |
| BR06b | Phải thông báo cho GV bị ảnh hưởng |

---

### 3.6. UC15 - Mượn-Bù lịch

**Mô tả:** Giáo viên mượn lịch của giáo viên khác và cam kết trả bù.

**Actor:** GV

**Tiền điều kiện:**
- GV đã đăng nhập
- Có lịch của GV khác có thể mượn
- GV có lịch có thể cho mượn (để trả bù)

**Luồng chính:**
1. GV xem lịch phòng
2. GV chọn lịch muốn mượn
3. Hệ thống hiển thị form mượn-bù
4. GV chọn lịch trả bù của mình
5. GV nhập lý do mượn
6. GV gửi yêu cầu
7. Hệ thống gửi thông báo cho GV cho mượn
8. GV cho mượn đồng ý/từ chối
9. Nếu đồng ý, TTDT duyệt
10. Hệ thống hoán đổi lịch

---

## 4. YÊU CẦU PHI CHỨC NĂNG

### 4.1. Hiệu năng

| ID | Yêu cầu | Mục tiêu |
|----|---------|----------|
| NFR01 | Thời gian tải trang | < 3 giây |
| NFR02 | Thời gian xử lý form | < 2 giây |
| NFR03 | Số người dùng đồng thời | ≥ 100 |
| NFR04 | Thời gian response API | < 500ms |

### 4.2. Bảo mật

| ID | Yêu cầu |
|----|---------|
| NFR05 | Mật khẩu phải được hash (không lưu plain text) |
| NFR06 | Session timeout sau 8 giờ không hoạt động |
| NFR07 | Tất cả endpoint phải được authorize |
| NFR08 | Chống SQL Injection, XSS |
| NFR09 | HTTPS cho production |

### 4.3. Khả dụng

| ID | Yêu cầu | Mục tiêu |
|----|---------|----------|
| NFR10 | Uptime | ≥ 99% |
| NFR11 | Sao lưu dữ liệu | Hàng ngày |
| NFR12 | Recovery time | < 4 giờ |

### 4.4. Khả năng mở rộng

| ID | Yêu cầu |
|----|---------|
| NFR13 | Hỗ trợ thêm vai trò người dùng mới |
| NFR14 | Hỗ trợ thêm loại phòng máy |
| NFR15 | Tích hợp API bên ngoài (tương lai) |

### 4.5. Usability

| ID | Yêu cầu |
|----|---------|
| NFR16 | Responsive design (desktop, tablet, mobile) |
| NFR17 | Hỗ trợ tiếng Việt |
| NFR18 | Thông báo lỗi rõ ràng, thân thiện |
| NFR19 | Có hướng dẫn sử dụng |

---

## 5. GIAO DIỆN HỆ THỐNG

### 5.1. Giao diện người dùng

#### 5.1.1. Trang đăng nhập
```
┌────────────────────────────────────────────────────────────┐
│                    QL_TH_MT                                │
│            Hệ thống quản lý phòng TH                       │
│                                                            │
│     ┌────────────────────────────────────────┐             │
│     │  Tên đăng nhập: [________________]     │             │
│     │                                        │             │
│     │  Mật khẩu:      [________________]     │             │
│     │                                        │             │
│     │           [ Đăng nhập ]                │             │
│     └────────────────────────────────────────┘             │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

#### 5.1.2. Dashboard
```
┌────────────────────────────────────────────────────────────────────┐
│ Logo  │  Đăng ký phòng  │  Phòng máy  │  Báo cáo  │  [User ▼]     │
├───────┴────────────────────────────────────────────┴───────────────┤
│                                                                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐             │
│  │  Chờ duyệt   │  │  Đã duyệt    │  │  Phòng trống │             │
│  │     12       │  │     45       │  │      8       │             │
│  └──────────────┘  └──────────────┘  └──────────────┘             │
│                                                                    │
│  ┌─────────────────────────────────────────────────────────────┐  │
│  │               LỊCH PHÒNG TUẦN NÀY                           │  │
│  ├─────────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐         │  │
│  │ Phòng   │ T2  │ T3  │ T4  │ T5  │ T6  │ T7  │ CN  │         │  │
│  ├─────────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤         │  │
│  │ A101    │ ██  │     │ ██  │     │ ██  │     │     │         │  │
│  │ A102    │     │ ██  │     │ ██  │     │ ██  │     │         │  │
│  └─────────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘         │  │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

### 5.2. Giao diện phần cứng
- Không có yêu cầu đặc biệt
- Máy tính có kết nối internet

### 5.3. Giao diện phần mềm

| Hệ thống | Giao diện |
|----------|-----------|
| SQL Server | Entity Framework Core |
| Browser | HTTP/HTTPS |
| Email (tương lai) | SMTP |

### 5.4. Giao diện truyền thông
- HTTP/HTTPS port 80/443
- SQL Server port 1433

---

## 6. RÀNG BUỘC THIẾT KẾ

### 6.1. Ràng buộc công nghệ
- Backend: ASP.NET Core 8.0
- ORM: Entity Framework Core 8.0
- Database: SQL Server 2019+
- Frontend: Bootstrap 5, vanilla JavaScript

### 6.2. Ràng buộc triển khai
- Windows Server hoặc Linux container
- IIS hoặc Kestrel
- .NET 8.0 Runtime

### 6.3. Ràng buộc pháp lý
- Tuân thủ quy định về bảo vệ dữ liệu cá nhân
- Lưu trữ log hoạt động

---

## 7. PHỤ LỤC

### 7.1. Mô hình dữ liệu
Xem file: `PHAN_TICH_DU_AN.md` - Phần 4.8 ER Diagram

### 7.2. Màn hình mẫu
Xem folder: `Views/`

### 7.3. Lịch sử thay đổi

| Phiên bản | Ngày | Mô tả | Tác giả |
|-----------|------|-------|---------|
| 1.0 | 03/02/2026 | Khởi tạo tài liệu | Team |

---

*Hết tài liệu SRS*
