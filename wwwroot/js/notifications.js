// Hệ thống thông báo popup thống nhất
const Notify = {
    // Thông báo thành công
    success: function(message, title = 'Thành công!', callback = null) {
        Swal.fire({
            icon: 'success',
            title: title,
            text: message,
            confirmButtonText: 'OK',
            confirmButtonColor: '#28a745',
            timer: 3000,
            timerProgressBar: true
        }).then((result) => {
            if (callback && typeof callback === 'function') {
                callback();
            }
        });
    },

    // Thông báo lỗi
    error: function(message, title = 'Lỗi!', callback = null) {
        Swal.fire({
            icon: 'error',
            title: title,
            text: message,
            confirmButtonText: 'Đóng',
            confirmButtonColor: '#dc3545'
        }).then((result) => {
            if (callback && typeof callback === 'function') {
                callback();
            }
        });
    },

    // Thông báo cảnh báo
    warning: function(message, title = 'Cảnh báo!', callback = null) {
        Swal.fire({
            icon: 'warning',
            title: title,
            text: message,
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        }).then((result) => {
            if (callback && typeof callback === 'function') {
                callback();
            }
        });
    },

    // Thông báo thông tin
    info: function(message, title = 'Thông tin', callback = null) {
        Swal.fire({
            icon: 'info',
            title: title,
            text: message,
            confirmButtonText: 'OK',
            confirmButtonColor: '#17a2b8'
        }).then((result) => {
            if (callback && typeof callback === 'function') {
                callback();
            }
        });
    },

    // Hộp thoại xác nhận
    confirm: function(message, title = 'Xác nhận', onConfirm = null, onCancel = null) {
        Swal.fire({
            icon: 'question',
            title: title,
            text: message,
            showCancelButton: true,
            confirmButtonText: 'Xác nhận',
            cancelButtonText: 'Hủy',
            confirmButtonColor: '#007bff',
            cancelButtonColor: '#6c757d',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                if (onConfirm && typeof onConfirm === 'function') {
                    onConfirm();
                }
            } else if (result.isDismissed && onCancel && typeof onCancel === 'function') {
                onCancel();
            }
        });
    },

    // Xử lý JSON response từ server
    handleResponse: function(response, successCallback = null, errorCallback = null) {
        if (response.success) {
            this.success(response.message, 'Thành công!', successCallback);
        } else {
            this.error(response.message, 'Lỗi!', errorCallback);
        }
    },

    // Toast notification nhỏ góc màn hình
    toast: function(message, type = 'success') {
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });

        Toast.fire({
            icon: type,
            title: message
        });
    },

    // Loading overlay
    loading: function(message = 'Đang xử lý...') {
        Swal.fire({
            title: message,
            allowOutsideClick: false,
            allowEscapeKey: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });
    },

    // Đóng loading
    closeLoading: function() {
        Swal.close();
    }
};

// Helper function cho AJAX calls với xử lý lỗi tự động
function ajaxPost(url, data, successCallback, errorCallback = null) {
    Notify.loading();
    
    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function(response) {
            Notify.closeLoading();
            if (response.success) {
                Notify.success(response.message, 'Thành công!', successCallback);
            } else {
                Notify.error(response.message, 'Lỗi!', errorCallback);
            }
        },
        error: function(xhr, status, error) {
            Notify.closeLoading();
            let errorMsg = 'Có lỗi xảy ra khi kết nối đến server.';
            if (xhr.responseJSON && xhr.responseJSON.message) {
                errorMsg = xhr.responseJSON.message;
            }
            Notify.error(errorMsg, 'Lỗi kết nối!', errorCallback);
        }
    });
}

// Helper function cho AJAX GET
function ajaxGet(url, successCallback, errorCallback = null) {
    Notify.loading();
    
    $.ajax({
        url: url,
        type: 'GET',
        success: function(response) {
            Notify.closeLoading();
            if (typeof successCallback === 'function') {
                successCallback(response);
            }
        },
        error: function(xhr, status, error) {
            Notify.closeLoading();
            let errorMsg = 'Có lỗi xảy ra khi kết nối đến server.';
            if (xhr.responseJSON && xhr.responseJSON.message) {
                errorMsg = xhr.responseJSON.message;
            }
            Notify.error(errorMsg, 'Lỗi kết nối!', errorCallback);
        }
    });
}

// Confirm delete helper
function confirmDelete(message, url, data = {}) {
    Notify.confirm(
        message,
        'Xác nhận xóa',
        function() {
            ajaxPost(url, data, function() {
                location.reload();
            });
        }
    );
}
