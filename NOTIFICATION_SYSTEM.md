# HỆ THỐNG THÔNG BÁO POPUP - HƯỚNG DẪN SỬ DỤNG

## 📋 Tổng quan

Hệ thống thông báo popup đã được tích hợp vào ứng dụng sử dụng **SweetAlert2** - một thư viện popup đẹp và hiện đại.

### ✅ Đã cập nhật

1. **File JavaScript chính**: `/wwwroot/js/notifications.js`
2. **Layout**: Đã thêm SweetAlert2 CDN vào `_Layout.cshtml`
3. **Các trang đã cập nhật**:
   - `Views/SapXepLich/Index.cshtml`
   - `Views/QuanLyHocPhan/Index.cshtml`

---

## 🎯 Các loại thông báo

### 1. Thông báo THÀNH CÔNG
```javascript
Notify.success('Lưu dữ liệu thành công!');
Notify.success('Dữ liệu đã được lưu', 'Hoàn tất!');
Notify.success('Tạo mới thành công!', 'Thành công!', function() {
    location.reload();
});
```

### 2. Thông báo LỖI
```javascript
Notify.error('Không thể kết nối đến server');
Notify.error('Tên đăng nhập đã tồn tại', 'Lỗi validation');
```

### 3. Thông báo CẢNH BÁO
```javascript
Notify.warning('Có một số dữ liệu chưa được lưu', 'Chú ý!');
```

### 4. Thông báo THÔNG TIN
```javascript
Notify.info('Hệ thống sẽ bảo trì vào 23h00', 'Thông báo');
```

### 5. Hộp thoại XÁC NHẬN
```javascript
Notify.confirm(
    'Bạn có chắc muốn xóa?',
    'Xác nhận xóa',
    function() {
        // Người dùng chọn "Xác nhận"
        console.log('Đã xác nhận');
    },
    function() {
        // Người dùng chọn "Hủy"
        console.log('Đã hủy');
    }
);
```

### 6. TOAST Notification (góc màn hình)
```javascript
Notify.toast('Đã lưu tự động!', 'success');
Notify.toast('Không thể tải dữ liệu', 'error');
Notify.toast('Có thông báo mới', 'info');
Notify.toast('Phiên đăng nhập sắp hết hạn', 'warning');
```

### 7. LOADING Overlay
```javascript
Notify.loading('Đang xử lý dữ liệu...');

// Đóng loading sau khi xong
setTimeout(() => {
    Notify.closeLoading();
}, 2000);
```

---

## 🔧 Helper Functions

### 1. AJAX POST với xử lý tự động
```javascript
ajaxPost(
    '/Controller/Action',
    { id: 123, name: 'Test' },
    function() {
        // Success callback
        location.reload();
    },
    function() {
        // Error callback (optional)
        console.log('Lỗi');
    }
);
```

### 2. XÁC NHẬN XÓA nhanh
```javascript
function deleteItem(id) {
    confirmDelete(
        'Bạn có chắc muốn xóa?',
        '/Controller/Delete',
        { id: id }
    );
}
```
**Sử dụng trong HTML:**
```html
<button onclick="deleteItem(123)" class="btn btn-danger">Xóa</button>
```

### 3. XỬ LÝ JSON Response tự động
```javascript
fetch('/api/save', {
    method: 'POST',
    body: JSON.stringify(data)
})
.then(response => response.json())
.then(data => {
    // Tự động hiển thị thông báo success hoặc error
    Notify.handleResponse(data, function() {
        location.reload();
    });
});
```

---

## 📝 Ví dụ thực tế

### Form Submit với AJAX
```javascript
document.getElementById('myForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const formData = new FormData(this);
    
    Notify.loading('Đang gửi dữ liệu...');
    
    fetch(this.action, {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        Notify.closeLoading();
        
        if (data.success) {
            Notify.success(data.message, 'Thành công!', function() {
                location.reload();
            });
        } else {
            Notify.error(data.message, 'Lỗi!');
        }
    })
    .catch(error => {
        Notify.closeLoading();
        Notify.error('Lỗi kết nối: ' + error.message);
    });
});
```

### Button Xóa
```javascript
function xoaItem(id, ten) {
    Notify.confirm(
        `Bạn có chắc muốn xóa "${ten}"? Hành động này không thể hoàn tác!`,
        'Xác nhận xóa',
        function() {
            ajaxPost('/Controller/Delete/' + id, {}, function() {
                Notify.toast('Đã xóa thành công!', 'success');
                setTimeout(() => location.reload(), 1000);
            });
        }
    );
}
```
**HTML:**
```html
<button onclick="xoaItem(123, 'Tên mục')" class="btn btn-danger">
    <i class="bi bi-trash"></i> Xóa
</button>
```

---

## 🎨 Tùy chỉnh

### Thông báo với HTML
```javascript
Swal.fire({
    icon: 'info',
    title: 'Thống kê chi tiết',
    html: `
        <div class="text-start">
            <p><strong>Tổng số:</strong> 150 mục</p>
            <p><strong>Đã xử lý:</strong> 120 mục</p>
            <p><strong>Còn lại:</strong> 30 mục</p>
        </div>
    `,
    confirmButtonText: 'Đóng'
});
```

### Thông báo với Timer
```javascript
Swal.fire({
    icon: 'success',
    title: 'Thành công!',
    text: 'Trang sẽ tự động chuyển sau 3 giây',
    timer: 3000,
    timerProgressBar: true,
    showConfirmButton: false
}).then(() => {
    location.href = '/NewPage';
});
```

### Input Dialog
```javascript
Swal.fire({
    title: 'Nhập lý do từ chối',
    input: 'textarea',
    inputPlaceholder: 'Nhập lý do...',
    showCancelButton: true,
    confirmButtonText: 'Gửi',
    cancelButtonText: 'Hủy',
    inputValidator: (value) => {
        if (!value) {
            return 'Bạn phải nhập lý do!'
        }
    }
}).then((result) => {
    if (result.isConfirmed) {
        // Xử lý với result.value
        console.log('Lý do:', result.value);
    }
});
```

---

## 🔄 Chuyển đổi code cũ sang mới

### Trước (alert cũ):
```javascript
if (confirm('Bạn có chắc muốn xóa?')) {
    // Xóa...
}
```

### Sau (SweetAlert2):
```javascript
Notify.confirm(
    'Bạn có chắc muốn xóa?',
    'Xác nhận',
    function() {
        // Xóa...
    }
);
```

### Trước (alert success):
```javascript
alert('Lưu thành công!');
location.reload();
```

### Sau (SweetAlert2):
```javascript
Notify.success('Lưu thành công!', 'Thành công!', function() {
    location.reload();
});
```

---

## 📦 Các file liên quan

1. **`/wwwroot/js/notifications.js`** - File JavaScript chính
2. **`/wwwroot/js/notification-examples.js`** - File ví dụ chi tiết
3. **`/Views/Shared/_Layout.cshtml`** - Đã thêm SweetAlert2 CDN

---

## 🚀 Danh sách TODO

Các trang cần cập nhật thêm:

- [ ] `Views/QuanLyHocKy/Index.cshtml` - Nút Kích hoạt, Xóa
- [ ] `Views/QuanLyMonHoc/Index.cshtml` - Nút Xóa
- [ ] `Views/QuanLyPhong/Index.cshtml` - Nút Kiểm kê, Xóa
- [ ] `Views/TaiKhoan/DanhSach.cshtml` - Nút Xóa tài khoản
- [ ] `Views/QuanLyHopDong/Index.cshtml` - Nút Xóa hợp đồng
- [ ] `Views/LichThucHanh/DanhSachChoDuyet.cshtml` - Nút Duyệt tất cả, Duyệt đơn
- [ ] `Views/DangKyLich/*.cshtml` - Các form đăng ký lịch

---

## 📞 Hỗ trợ

Xem file `/wwwroot/js/notification-examples.js` để có thêm nhiều ví dụ chi tiết hơn.

**SweetAlert2 Documentation**: https://sweetalert2.github.io/
