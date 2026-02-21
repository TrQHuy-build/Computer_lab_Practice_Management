# Test Cases - Hệ thống Quản lý Lịch Thực hành UTC2

## Thông tin chung
- **URL**: http://localhost:5199
- **Ngày tạo**: 04/02/2026
- **Phiên bản**: 1.0

---

## I. TEST CASES THEO ROLE

### 1. ADMIN - Quản lý tài khoản

#### TC-AD-001: Đăng nhập Admin
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Đăng nhập với tài khoản Admin |
| **Điều kiện tiên quyết** | Có tài khoản admin trong hệ thống |
| **Bước thực hiện** | 1. Truy cập http://localhost:5199 <br> 2. Nhập username: admin <br> 3. Nhập password: admin <br> 4. Click "Đăng nhập" |
| **Kết quả mong đợi** | Đăng nhập thành công, chuyển đến Dashboard |
| **Trạng thái** | ⬜ Chưa test |

#### TC-AD-002: Tạo tài khoản mới
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Admin tạo tài khoản cho người dùng mới |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền Admin |
| **Bước thực hiện** | 1. Vào menu Quản lý tài khoản <br> 2. Click "Thêm mới" <br> 3. Điền thông tin: Tên đăng nhập, Mật khẩu, Vai trò, Nhân viên <br> 4. Click "Lưu" |
| **Kết quả mong đợi** | Tài khoản được tạo thành công |
| **Trạng thái** | ⬜ Chưa test |

---

### 2. PHÒNG ĐÀO TẠO (PDT)

#### TC-PDT-001: Đăng nhập PDT
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Đăng nhập với tài khoản PDT |
| **Điều kiện tiên quyết** | Có tài khoản PDT trong hệ thống |
| **Bước thực hiện** | 1. Truy cập http://localhost:5199 <br> 2. Nhập username: pdt <br> 3. Nhập password: pdt123 <br> 4. Click "Đăng nhập" |
| **Kết quả mong đợi** | Đăng nhập thành công, hiển thị menu theo quyền PDT |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-002: Quản lý Học kỳ - Xem danh sách
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Xem danh sách học kỳ |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền PDT |
| **Bước thực hiện** | 1. Vào menu "Học kỳ" <br> 2. Xem danh sách học kỳ |
| **Kết quả mong đợi** | Hiển thị danh sách học kỳ với 3 mốc thời gian: Tiền học kỳ, Bắt đầu, Kết thúc |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-003: Quản lý Học kỳ - Thêm mới
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Tạo học kỳ mới với 3 mốc thời gian |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền PDT |
| **Bước thực hiện** | 1. Vào menu "Học kỳ" <br> 2. Click "Thêm mới" <br> 3. Điền: Tên học kỳ, Năm học, Ngày tiền học kỳ, Ngày bắt đầu, Ngày kết thúc <br> 4. Click "Lưu" |
| **Kết quả mong đợi** | Học kỳ được tạo thành công với đầy đủ 3 mốc thời gian |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-004: Quản lý Môn học - Xem danh sách
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Xem danh sách môn học |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền PDT |
| **Bước thực hiện** | 1. Vào menu "Môn học" (http://localhost:5199/MonHoc) <br> 2. Xem danh sách |
| **Kết quả mong đợi** | Hiển thị danh sách môn học với mã, tên, số tín chỉ, số buổi TH |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-005: Quản lý Môn học - Thêm mới
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Thêm môn học mới |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền PDT |
| **Bước thực hiện** | 1. Vào menu "Môn học" <br> 2. Click "Thêm mới" <br> 3. Điền: Mã môn, Tên môn, Số tín chỉ, Số buổi TH (mặc định 3), Khoa/Bộ môn <br> 4. Click "Lưu" |
| **Kết quả mong đợi** | Môn học được tạo thành công |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-006: Quản lý Học phần - Xem danh sách
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Xem danh sách học phần |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền PDT |
| **Bước thực hiện** | 1. Vào menu "Học phần" (http://localhost:5199/HocPhan) <br> 2. Xem danh sách |
| **Kết quả mong đợi** | Hiển thị danh sách học phần |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-007: Quản lý Hợp đồng - Xem danh sách
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Xem danh sách hợp đồng giảng viên |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền PDT |
| **Bước thực hiện** | 1. Vào menu "Hợp đồng" (http://localhost:5199/HopDong) <br> 2. Xem danh sách hợp đồng |
| **Kết quả mong đợi** | Hiển thị danh sách hợp đồng với GV, môn học, học kỳ, trạng thái |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-008: Quản lý Hợp đồng - Tạo mới
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Tạo hợp đồng liên kết GV với môn học |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền PDT, có GV và môn học trong hệ thống |
| **Bước thực hiện** | 1. Vào menu "Hợp đồng" <br> 2. Click "Thêm mới" <br> 3. Chọn: Học kỳ, Giảng viên, Môn học, Số nhóm TH, Tổng số buổi TH <br> 4. Click "Lưu" |
| **Kết quả mong đợi** | Hợp đồng được tạo với trạng thái "Chờ xác nhận" |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-009: Quản lý Hợp đồng - Duyệt hợp đồng
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | PDT duyệt hợp đồng |
| **Điều kiện tiên quyết** | Có hợp đồng ở trạng thái "Chờ xác nhận" |
| **Bước thực hiện** | 1. Vào danh sách hợp đồng <br> 2. Chọn hợp đồng cần duyệt <br> 3. Click "Duyệt" <br> 4. Xác nhận |
| **Kết quả mong đợi** | Hợp đồng chuyển sang trạng thái "Đã duyệt" |
| **Trạng thái** | ⬜ Chưa test |

#### TC-PDT-010: Duyệt đăng ký lịch GV thỉnh giảng
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | PDT duyệt yêu cầu đăng ký ngày giảng dạy của GV thỉnh giảng |
| **Điều kiện tiên quyết** | Có đăng ký lịch ở trạng thái "Chờ duyệt" |
| **Bước thực hiện** | 1. Vào menu "Đăng ký lịch giảng dạy" <br> 2. Tab "Chờ duyệt" <br> 3. Xem chi tiết và click "Duyệt" |
| **Kết quả mong đợi** | Đăng ký được duyệt, GV được thông báo |
| **Trạng thái** | ⬜ Chưa test |

---

### 3. TRUNG TÂM ĐÀO TẠO THỰC HÀNH (TTDT)

#### TC-TT-001: Đăng nhập TTDT
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Đăng nhập với tài khoản TTDT |
| **Điều kiện tiên quyết** | Có tài khoản TTDT trong hệ thống |
| **Bước thực hiện** | 1. Truy cập http://localhost:5199 <br> 2. Nhập username: ttdt <br> 3. Nhập password: ttdt123 <br> 4. Click "Đăng nhập" |
| **Kết quả mong đợi** | Đăng nhập thành công, hiển thị menu theo quyền TTDT |
| **Trạng thái** | ⬜ Chưa test |

#### TC-TT-002: Quản lý Phòng máy - Xem danh sách
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Xem danh sách phòng máy tại E7 |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền TTDT |
| **Bước thực hiện** | 1. Vào menu "Phòng máy" (http://localhost:5199/PhongMay) <br> 2. Xem danh sách |
| **Kết quả mong đợi** | Hiển thị danh sách phòng với mã phòng, tên, số máy, trạng thái |
| **Trạng thái** | ⬜ Chưa test |

#### TC-TT-003: Quản lý Phòng máy - Thêm mới
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Thêm phòng máy mới |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền TTDT |
| **Bước thực hiện** | 1. Vào menu "Phòng máy" <br> 2. Click "Thêm mới" <br> 3. Điền: Mã phòng, Tên phòng, Vị trí, Số lượng máy <br> 4. Click "Lưu" |
| **Kết quả mong đợi** | Phòng máy được tạo với trạng thái "Chờ duyệt" |
| **Trạng thái** | ⬜ Chưa test |

#### TC-TT-004: Quản lý Phần mềm - Xem danh sách
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Xem danh sách phần mềm |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền TTDT |
| **Bước thực hiện** | 1. Vào menu "Phần mềm" (http://localhost:5199/PhanMem) <br> 2. Xem danh sách |
| **Kết quả mong đợi** | Hiển thị danh sách phần mềm với tên, phiên bản, nhà sản xuất |
| **Trạng thái** | ⬜ Chưa test |

#### TC-TT-005: Quản lý Phần mềm - Thêm mới
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Thêm phần mềm mới |
| **Điều kiện tiên quyết** | Đã đăng nhập với quyền TTDT |
| **Bước thực hiện** | 1. Vào menu "Phần mềm" <br> 2. Click "Thêm mới" <br> 3. Điền: Tên PM, Phiên bản, Nhà SX, Mô tả <br> 4. Click "Lưu" |
| **Kết quả mong đợi** | Phần mềm được tạo thành công |
| **Trạng thái** | ⬜ Chưa test |

#### TC-TT-006: Duyệt lịch thực hành
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | TTDT duyệt lịch thực hành sau khi PDT sắp xếp |
| **Điều kiện tiên quyết** | Có lịch thực hành chờ TTDT duyệt |
| **Bước thực hiện** | 1. Vào menu "Lịch thực hành" <br> 2. Tab "Chờ duyệt" <br> 3. Xem và click "Duyệt" |
| **Kết quả mong đợi** | Lịch được duyệt, thông báo đến GV |
| **Trạng thái** | ⬜ Chưa test |

---

### 4. GIẢNG VIÊN THỈNH GIẢNG

#### TC-GV-TG-001: Đăng nhập GV Thỉnh giảng
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Đăng nhập với tài khoản GV thỉnh giảng |
| **Điều kiện tiên quyết** | Có tài khoản GV thỉnh giảng |
| **Bước thực hiện** | 1. Truy cập http://localhost:5199 <br> 2. Nhập thông tin đăng nhập <br> 3. Click "Đăng nhập" |
| **Kết quả mong đợi** | Đăng nhập thành công với menu GV thỉnh giảng |
| **Trạng thái** | ⬜ Chưa test |

#### TC-GV-TG-002: Đăng ký lịch giảng dạy
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | GV thỉnh giảng đăng ký ngày có thể giảng dạy |
| **Điều kiện tiên quyết** | Đã có hợp đồng được duyệt, trong thời gian đăng ký (tuần 2) |
| **Bước thực hiện** | 1. Vào "Đăng ký lịch giảng dạy" (http://localhost:5199/DangKyLichGiangDay) <br> 2. Chọn hợp đồng <br> 3. Chọn Thứ trong tuần, Ca học <br> 4. Đặt số tuần liên tiếp >= 3 <br> 5. Click "Đăng ký" |
| **Kết quả mong đợi** | Đăng ký được tạo với trạng thái "Chờ duyệt" |
| **Trạng thái** | ⬜ Chưa test |

#### TC-GV-TG-003: Xem lịch giảng dạy của tôi
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Xem lịch thực hành đã được xếp |
| **Điều kiện tiên quyết** | Đã có lịch được duyệt |
| **Bước thực hiện** | 1. Vào "Lịch thực hành" > "Lịch của tôi" |
| **Kết quả mong đợi** | Hiển thị lịch thực hành của GV đăng nhập |
| **Trạng thái** | ⬜ Chưa test |

---

### 5. GIẢNG VIÊN CỐ HỮU

#### TC-GV-CH-001: Đăng nhập GV Cố hữu
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Đăng nhập với tài khoản GV cố hữu |
| **Điều kiện tiên quyết** | Có tài khoản GV cố hữu |
| **Bước thực hiện** | 1. Truy cập http://localhost:5199 <br> 2. Nhập thông tin đăng nhập <br> 3. Click "Đăng nhập" |
| **Kết quả mong đợi** | Đăng nhập thành công, KHÔNG có menu đăng ký lịch |
| **Trạng thái** | ⬜ Chưa test |

#### TC-GV-CH-002: Xem lịch giảng dạy
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | GV cố hữu xem lịch thực hành được phân công |
| **Điều kiện tiên quyết** | Đã có lịch được xếp |
| **Bước thực hiện** | 1. Vào "Lịch thực hành" > "Lịch của tôi" |
| **Kết quả mong đợi** | Hiển thị lịch thực hành được phân công |
| **Trạng thái** | ⬜ Chưa test |

---

### 6. CHỨC NĂNG MƯỢN BÙ / ĐỔI LỊCH (TẤT CẢ GV)

#### TC-MB-001: Tạo yêu cầu mượn bù
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | GV tạo yêu cầu mượn bù lịch |
| **Điều kiện tiên quyết** | Có lịch thực hành đã được duyệt |
| **Bước thực hiện** | 1. Vào "Mượn bù" (http://localhost:5199/MuonBu) <br> 2. Click "Tạo yêu cầu" <br> 3. Chọn buổi muốn mượn <br> 4. Chọn ngày trả bù (trong phạm vi 1 tuần) <br> 5. Nhập lý do <br> 6. Click "Gửi" |
| **Kết quả mong đợi** | Yêu cầu được tạo, chờ duyệt từ PDT và TTDT |
| **Trạng thái** | ⬜ Chưa test |

#### TC-DL-001: Tạo yêu cầu đổi lịch
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | GV tạo yêu cầu đổi phòng/lịch |
| **Điều kiện tiên quyết** | Có lịch thực hành đã được duyệt |
| **Bước thực hiện** | 1. Vào "Đổi lịch" (http://localhost:5199/DoiLich) <br> 2. Click "Tạo yêu cầu" <br> 3. Chọn buổi cần đổi <br> 4. Chọn: Ngày mới, Ca mới, Phòng mới <br> 5. Nhập lý do <br> 6. Click "Gửi" |
| **Kết quả mong đợi** | Yêu cầu được tạo, chờ duyệt từ cả PDT và TTDT |
| **Trạng thái** | ⬜ Chưa test |

#### TC-DL-002: PDT duyệt yêu cầu đổi lịch
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | PDT duyệt yêu cầu đổi lịch |
| **Điều kiện tiên quyết** | Có yêu cầu đổi lịch chờ PDT duyệt |
| **Bước thực hiện** | 1. Đăng nhập PDT <br> 2. Vào "Đổi lịch" <br> 3. Xem yêu cầu và click "Duyệt" |
| **Kết quả mong đợi** | Yêu cầu chuyển sang chờ TTDT duyệt |
| **Trạng thái** | ⬜ Chưa test |

#### TC-DL-003: TTDT duyệt yêu cầu đổi lịch
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | TTDT duyệt yêu cầu đổi lịch sau khi PDT đã duyệt |
| **Điều kiện tiên quyết** | Yêu cầu đã được PDT duyệt |
| **Bước thực hiện** | 1. Đăng nhập TTDT <br> 2. Vào "Đổi lịch" <br> 3. Xem yêu cầu và click "Duyệt" |
| **Kết quả mong đợi** | Lịch được cập nhật, GV được thông báo |
| **Trạng thái** | ⬜ Chưa test |

---

## II. TEST CASES THEO QUY TRÌNH THỜI GIAN

### Quy trình: Trước học kỳ (4 tuần)

#### TC-QT-001: Tuần 1 - PDT nhập hợp đồng
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | PDT nhập thông tin hợp đồng GV-Môn học |
| **Thời điểm** | Tuần 1 trước học kỳ |
| **Bước thực hiện** | 1. Tạo hợp đồng cho GV thỉnh giảng <br> 2. Tạo hợp đồng cho GV cố hữu <br> 3. Liên kết với môn học |
| **Kết quả mong đợi** | Tất cả hợp đồng được tạo thành công |
| **Trạng thái** | ⬜ Chưa test |

#### TC-QT-002: Tuần 1 - TTDT kiểm kê phòng
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | TTDT cập nhật thông tin phòng thực hành E7 |
| **Thời điểm** | Tuần 1 trước học kỳ |
| **Bước thực hiện** | 1. Kiểm tra danh sách phòng <br> 2. Cập nhật số máy, trạng thái <br> 3. Thêm phòng mới nếu cần |
| **Kết quả mong đợi** | Thông tin phòng được cập nhật |
| **Trạng thái** | ⬜ Chưa test |

#### TC-QT-003: Tuần 2 - GV thỉnh giảng đăng ký lịch
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | GV thỉnh giảng đăng ký ngày có thể giảng dạy |
| **Thời điểm** | Tuần 2 trước học kỳ |
| **Bước thực hiện** | 1. Đăng nhập GV thỉnh giảng <br> 2. Vào đăng ký lịch <br> 3. Chọn thứ, ca cho 3 tuần liên tiếp <br> 4. Gửi đăng ký |
| **Ràng buộc** | Tối thiểu 3 tuần liên tiếp cùng ngày, cùng ca |
| **Kết quả mong đợi** | Đăng ký được gửi, chờ PDT duyệt |
| **Trạng thái** | ⬜ Chưa test |

#### TC-QT-004: Tuần 2 - PDT duyệt đăng ký
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | PDT xác nhận đăng ký lịch của GV thỉnh giảng |
| **Thời điểm** | Tuần 2 trước học kỳ |
| **Bước thực hiện** | 1. Đăng nhập PDT <br> 2. Xem danh sách đăng ký <br> 3. Duyệt/Từ chối |
| **Kết quả mong đợi** | Đăng ký được duyệt hoặc từ chối với lý do |
| **Trạng thái** | ⬜ Chưa test |

#### TC-QT-005: Tuần 3 - PDT sắp xếp lịch
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | PDT sắp xếp lịch thực hành cho học kỳ |
| **Thời điểm** | Tuần 3 trước học kỳ |
| **Bước thực hiện** | 1. Vào "Lịch thực hành" > "Sắp xếp" <br> 2. Ưu tiên: GV thỉnh giảng > GV cố hữu <br> 3. Đảm bảo 3 tuần liên tiếp cùng ngày, ca <br> 4. Không xếp 3 tuần cuối (ôn thi) |
| **Kết quả mong đợi** | Lịch được sắp xếp, gửi TTDT duyệt |
| **Trạng thái** | ⬜ Chưa test |

#### TC-QT-006: Tuần 3 - TTDT duyệt lịch
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | TTDT xác nhận lịch thực hành |
| **Thời điểm** | Tuần 3 trước học kỳ |
| **Bước thực hiện** | 1. Đăng nhập TTDT <br> 2. Xem lịch đã sắp <br> 3. Kiểm tra phòng và duyệt |
| **Kết quả mong đợi** | Lịch được duyệt, sẵn sàng thông báo |
| **Trạng thái** | ⬜ Chưa test |

#### TC-QT-007: Tuần 4 - Thông báo và điều chỉnh
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Thông báo lịch cho GV và cho phép điều chỉnh |
| **Thời điểm** | Tuần 4 trước học kỳ |
| **Bước thực hiện** | 1. Hệ thống gửi thông báo tự động <br> 2. GV xem lịch và yêu cầu đổi nếu cần <br> 3. PDT và TTDT duyệt yêu cầu đổi |
| **Kết quả mong đợi** | Tất cả GV nhận được lịch chính thức |
| **Trạng thái** | ⬜ Chưa test |

### Quy trình: Học kỳ diễn ra

#### TC-QT-008: Thời gian lý thuyết
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Giai đoạn giảng dạy lý thuyết (không có TH) |
| **Thời gian** | n tuần (n phụ thuộc số tín chỉ) |
| **Bước thực hiện** | Hệ thống không cho phép xếp lịch TH trong giai đoạn này |
| **Kết quả mong đợi** | Không có buổi TH trong tuần lý thuyết |
| **Trạng thái** | ⬜ Chưa test |

#### TC-QT-009: Thời gian thực hành (3 tuần)
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | 3 buổi thực hành cho mỗi học phần |
| **Bước thực hiện** | 1. GV giảng dạy theo lịch <br> 2. Nếu cần đổi, dùng mượn bù/đổi lịch |
| **Kết quả mong đợi** | Hoàn thành 3 buổi TH cho mỗi học phần |
| **Trạng thái** | ⬜ Chưa test |

#### TC-QT-010: Thời gian ôn thi (3 tuần cuối)
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | 3 tuần cuối - không có thực hành |
| **Bước thực hiện** | Kiểm tra hệ thống không xếp lịch TH trong 3 tuần này |
| **Kết quả mong đợi** | Không có buổi TH nào trong 3 tuần cuối |
| **Trạng thái** | ⬜ Chưa test |

---

## III. TEST CASES VALIDATION

#### TC-VAL-001: Validate đăng ký < 3 tuần liên tiếp
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Hệ thống không cho đăng ký ít hơn 3 tuần liên tiếp |
| **Bước thực hiện** | 1. Đăng ký lịch với số tuần = 2 |
| **Kết quả mong đợi** | Hiện thông báo lỗi "Tối thiểu 3 tuần liên tiếp" |
| **Trạng thái** | ⬜ Chưa test |

#### TC-VAL-002: Validate trùng lịch
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Không cho xếp/đổi trùng lịch |
| **Bước thực hiện** | 1. Thử xếp lịch vào slot đã có |
| **Kết quả mong đợi** | Hiện thông báo lỗi "Trùng lịch" |
| **Trạng thái** | ⬜ Chưa test |

#### TC-VAL-003: Validate đổi lịch quá 1 tuần
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Mượn bù không được quá 1 tuần |
| **Bước thực hiện** | 1. Tạo yêu cầu mượn bù với ngày trả > 7 ngày |
| **Kết quả mong đợi** | Hiện thông báo lỗi "Phạm vi 1 tuần" |
| **Trạng thái** | ⬜ Chưa test |

#### TC-VAL-004: Validate xếp lịch 3 tuần cuối
| Mục | Nội dung |
|-----|----------|
| **Mô tả** | Không được xếp TH trong 3 tuần ôn thi |
| **Bước thực hiện** | 1. Thử xếp lịch vào 3 tuần cuối kỳ |
| **Kết quả mong đợi** | Hiện thông báo lỗi hoặc không cho chọn |
| **Trạng thái** | ⬜ Chưa test |

---

## IV. CHECKLIST KIỂM THỬ

### URLs cần kiểm tra:
- [ ] http://localhost:5199 - Trang đăng nhập
- [ ] http://localhost:5199/Dashboard - Dashboard
- [ ] http://localhost:5199/HocKy - Quản lý học kỳ
- [ ] http://localhost:5199/MonHoc - Quản lý môn học
- [ ] http://localhost:5199/HocPhan - Quản lý học phần
- [ ] http://localhost:5199/HopDong - Quản lý hợp đồng
- [ ] http://localhost:5199/PhongMay - Quản lý phòng máy
- [ ] http://localhost:5199/PhanMem - Quản lý phần mềm
- [ ] http://localhost:5199/DangKyLichGiangDay - Đăng ký lịch GV thỉnh giảng
- [ ] http://localhost:5199/LichThucHanh - Lịch thực hành
- [ ] http://localhost:5199/MuonBu - Mượn bù
- [ ] http://localhost:5199/DoiLich - Đổi lịch
- [ ] http://localhost:5199/ThongBao - Thông báo

### Tài khoản test:
| Username | Password | Role |
|----------|----------|------|
| admin | admin | Admin |
| pdt | pdt123 | Phòng đào tạo |
| ttdt | ttdt123 | Trung tâm đào tạo |
| gvtg1 | gv123 | GV Thỉnh giảng |
| gvch1 | gv123 | GV Cố hữu |

---

## V. KẾT QUẢ TỔNG HỢP

| Nhóm test | Tổng | Pass | Fail | Chưa test |
|-----------|------|------|------|-----------|
| Admin | 2 | 0 | 0 | 2 |
| PDT | 10 | 0 | 0 | 10 |
| TTDT | 6 | 0 | 0 | 6 |
| GV Thỉnh giảng | 3 | 0 | 0 | 3 |
| GV Cố hữu | 2 | 0 | 0 | 2 |
| Mượn bù/Đổi lịch | 4 | 0 | 0 | 4 |
| Quy trình | 10 | 0 | 0 | 10 |
| Validation | 4 | 0 | 0 | 4 |
| **TỔNG** | **41** | **0** | **0** | **41** |
