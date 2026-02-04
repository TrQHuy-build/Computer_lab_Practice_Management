/**
 * HƯỚNG DẪN SỬ DỤNG HỆ THỐNG THÔNG BÁO POPUP
 * 
 * File này chứa các ví dụ về cách sử dụng hệ thống thông báo popup
 * đã được tích hợp sẵn trong ứng dụng.
 */

// ========================================
// 1. THÔNG BÁO THÀNH CÔNG
// ========================================

// Cơ bản
Notify.success('Lưu dữ liệu thành công!');

// Với title tùy chỉnh
Notify.success('Dữ liệu đã được lưu vào hệ thống', 'Hoàn tất!');

// Với callback sau khi đóng
Notify.success('Tạo mới thành công!', 'Thành công!', function() {
    window.location.href = '/Home/Index';
});


// ========================================
// 2. THÔNG BÁO LỖI
// ========================================

// Cơ bản
Notify.error('Không thể kết nối đến server');

// Với title tùy chỉnh
Notify.error('Tên đăng nhập đã tồn tại', 'Lỗi validation');


// ========================================
// 3. THÔNG BÁO CẢNH BÁO
// ========================================

Notify.warning('Có một số dữ liệu chưa được lưu', 'Chú ý!');


// ========================================
// 4. THÔNG BÁO THÔNG TIN
// ========================================

Notify.info('Hệ thống sẽ bảo trì vào 23h00 hôm nay', 'Thông báo');


// ========================================
// 5. HỘP THOẠI XÁC NHẬN
// ========================================

// Xác nhận xóa
Notify.confirm(
    'Bạn có chắc muốn xóa mục này? Hành động này không thể hoàn tác!',
    'Xác nhận xóa',
    function() {
        // Người dùng nhấn "Xác nhận"
        console.log('Đã xác nhận xóa');
        // Thực hiện xóa...
    },
    function() {
        // Người dùng nhấn "Hủy" (optional)
        console.log('Đã hủy');
    }
);


// ========================================
// 6. TOAST NOTIFICATION (Góc màn hình)
// ========================================

// Thành công
Notify.toast('Đã lưu tự động!', 'success');

// Lỗi
Notify.toast('Không thể tải dữ liệu', 'error');

// Thông tin
Notify.toast('Có thông báo mới', 'info');

// Cảnh báo
Notify.toast('Phiên đăng nhập sắp hết hạn', 'warning');


// ========================================
// 7. LOADING OVERLAY
// ========================================

// Hiển thị loading
Notify.loading('Đang xử lý dữ liệu...');

// Đóng loading sau 2 giây
setTimeout(() => {
    Notify.closeLoading();
}, 2000);


// ========================================
// 8. XỬ LÝ JSON RESPONSE TỰ ĐỘNG
// ========================================

// Khi nhận response JSON từ server có format: { success: true/false, message: "..." }
fetch('/api/save', {
    method: 'POST',
    body: JSON.stringify(data)
})
.then(response => response.json())
.then(data => {
    Notify.handleResponse(data, function() {
        // Callback khi thành công
        location.reload();
    });
});


// ========================================
// 9. AJAX POST VỚI XỬ LÝ TỰ ĐỘNG
// ========================================

// Helper function đã tích hợp loading và notification
ajaxPost(
    '/QuanLyHocKy/KichHoat',
    { id: 123 },
    function() {
        // Success callback
        location.reload();
    },
    function() {
        // Error callback (optional)
        console.log('Có lỗi xảy ra');
    }
);


// ========================================
// 10. XÁC NHẬN XÓA NHANH
// ========================================

// Helper function cho nút xóa
function deleteItem(id) {
    confirmDelete(
        'Bạn có chắc muốn xóa mục này?',
        '/Controller/Delete',
        { id: id }
    );
}

// Sử dụng trong HTML:
// <button onclick="deleteItem(123)">Xóa</button>


// ========================================
// 11. VÍ DỤ FORM SUBMIT VỚI AJAX
// ========================================

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
                window.location.href = '/Success/Page';
            });
        } else {
            Notify.error(data.message, 'Lỗi!');
        }
    })
    .catch(error => {
        Notify.closeLoading();
        Notify.error('Không thể kết nối đến server: ' + error.message, 'Lỗi kết nối!');
    });
});


// ========================================
// 12. XÁC NHẬN TRƯỚC KHI RỜI TRANG
// ========================================

let hasUnsavedChanges = false;

// Đánh dấu có thay đổi chưa lưu
document.querySelectorAll('input, textarea, select').forEach(el => {
    el.addEventListener('change', () => {
        hasUnsavedChanges = true;
    });
});

// Cảnh báo khi rời trang
window.addEventListener('beforeunload', function(e) {
    if (hasUnsavedChanges) {
        e.preventDefault();
        e.returnValue = '';
    }
});


// ========================================
// 13. THÔNG BÁO NHIỀU NỘI DUNG (HTML)
// ========================================

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


// ========================================
// 14. THÔNG BÁO VỚI TIMER
// ========================================

Swal.fire({
    icon: 'success',
    title: 'Thành công!',
    text: 'Trang sẽ tự động chuyển sau 3 giây',
    timer: 3000,
    timerProgressBar: true,
    showConfirmButton: false
}).then(() => {
    window.location.href = '/NewPage';
});


// ========================================
// 15. INPUT DIALOG
// ========================================

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
        console.log('Lý do:', result.value);
        // Xử lý với lý do đã nhập
    }
});
