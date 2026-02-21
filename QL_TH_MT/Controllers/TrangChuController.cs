using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using QL_TH_MT.Data;
using QL_TH_MT.Models;
using QL_TH_MT.ViewModels;
using QL_TH_MT.Services;

namespace QL_TH_MT.Controllers
{
    [Authorize]
    public class TrangChuController : Controller
    {
        private readonly NewAppDbContext _context;
        private readonly HocKyServiceNew _hocKyService;
        private readonly ThongBaoServiceNew _thongBaoService;

        public TrangChuController(NewAppDbContext context, HocKyServiceNew hocKyService, ThongBaoServiceNew thongBaoService)
        {
            _context = context;
            _hocKyService = hocKyService;
            _thongBaoService = thongBaoService;
        }

        public async Task<IActionResult> Index()
        {
            var userId = GetUserId();
            var user = await _context.TaiKhoans.FindAsync(userId);
            var hocKy = await _hocKyService.GetHocKyHienTaiAsync();
            var giaiDoan = _hocKyService.XacDinhGiaiDoan(hocKy);

            var viewModel = new DashboardViewModel
            {
                NguoiDung = user,
                HocKyHienTai = hocKy,
                GiaiDoan = giaiDoan,
                GiaiDoanHienTai = _hocKyService.GetTenGiaiDoan(giaiDoan),
                TenGiaiDoan = _hocKyService.GetTenGiaiDoan(giaiDoan),
                SoThongBaoChuaDoc = await _thongBaoService.DemThongBaoChuaDoc(userId)
            };

            // Lấy thống kê theo vai trò
            if (user != null)
            {
                switch (user.VaiTro)
                {
                    case LoaiVaiTro.Admin:
                        viewModel.DanhSachCongViec = GetCongViecAdmin();
                        break;

                    case LoaiVaiTro.PhongDaoTao:
                        viewModel.DanhSachCongViec = GetCongViecPhongDaoTao(giaiDoan);
                        if (hocKy != null)
                        {
                            viewModel.TongHocPhan = await _context.HocPhans.CountAsync(hp => hp.HocKyId == hocKy.Id);
                            viewModel.TongLichThucHanh = await _context.LichThucHanhs.CountAsync(l => l.HocKyId == hocKy.Id);
                        }
                        break;

                    case LoaiVaiTro.TrungTamDaoTaoThucHanh:
                        viewModel.DanhSachCongViec = GetCongViecTrungTam(giaiDoan);
                        viewModel.SoYeuCauChoDuyet = await _context.LichThucHanhs
                            .CountAsync(l => l.TrangThai == 1); // Chờ TTDT duyệt
                        break;

                    case LoaiVaiTro.GiangVien:
                        viewModel.DanhSachCongViec = GetCongViecGiangVien(user, giaiDoan);
                        if (hocKy != null)
                        {
                            viewModel.TongLichThucHanh = await _context.LichThucHanhs
                                .Include(l => l.HocPhan)
                                .CountAsync(l => l.HocKyId == hocKy.Id && l.HocPhan!.GiangVienId == userId);
                        }
                        break;
                }
            }

            return View(viewModel);
        }

        private List<CongViecViewModel> GetCongViecAdmin()
        {
            return new List<CongViecViewModel>
            {
                new CongViecViewModel
                {
                    TieuDe = "Quản lý tài khoản",
                    MoTa = "Tạo và quản lý tài khoản người dùng",
                    Link = "/TaiKhoan/DanhSach",
                    Icon = "bi-people",
                    MauSac = "primary"
                }
            };
        }

        private List<CongViecViewModel> GetCongViecPhongDaoTao(GiaiDoanHocKy giaiDoan)
        {
            var danhSach = new List<CongViecViewModel>();

            // Quản lý học kỳ (luôn hiển thị)
            danhSach.Add(new CongViecViewModel
            {
                TieuDe = "Quản lý học kỳ",
                MoTa = "Thiết lập các mốc thời gian học kỳ",
                Link = "/QuanLyHocKy",
                Icon = "bi-calendar-event",
                MauSac = "info"
            });

            // Quản lý môn học (luôn hiển thị)
            danhSach.Add(new CongViecViewModel
            {
                TieuDe = "Quản lý môn học",
                MoTa = "Thêm, sửa, xóa môn học",
                Link = "/QuanLyMonHoc",
                Icon = "bi-book",
                MauSac = "secondary"
            });

            // Tuần 1: Nhập hợp đồng
            if (giaiDoan == GiaiDoanHocKy.Tuan1_NhapHopDong)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Nhập hợp đồng giảng dạy",
                    MoTa = "Liên kết giảng viên với môn học",
                    Link = "/QuanLyHopDong",
                    Icon = "bi-file-earmark-text",
                    MauSac = "warning"
                });

                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Quản lý học phần",
                    MoTa = "Tạo các lớp học phần",
                    Link = "/QuanLyHocPhan",
                    Icon = "bi-collection",
                    MauSac = "success"
                });
            }

            // Tuần 2: Duyệt đăng ký lịch
            if (giaiDoan == GiaiDoanHocKy.Tuan2_DangKyLich)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Duyệt đăng ký lịch",
                    MoTa = "Xác nhận lịch GV thỉnh giảng",
                    Link = "/QuanLyDangKyLich/DanhSachChoDuyet",
                    Icon = "bi-check-circle",
                    MauSac = "danger"
                });
            }

            // Tuần 3: Sắp xếp lịch
            if (giaiDoan == GiaiDoanHocKy.Tuan3_SapXepLich)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Sắp xếp lịch thực hành",
                    MoTa = "Xếp lịch cho tất cả học phần",
                    Link = "/SapXepLich",
                    Icon = "bi-calendar-check",
                    MauSac = "primary"
                });
            }

            // Tuần 4 + Học kỳ: Duyệt yêu cầu thay đổi
            if (giaiDoan >= GiaiDoanHocKy.Tuan4_ThongBao && giaiDoan <= GiaiDoanHocKy.DangHoc_ThucHanh)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Duyệt yêu cầu thay đổi",
                    MoTa = "Mượn bù, đổi phòng",
                    Link = "/QuanLyYeuCau",
                    Icon = "bi-arrow-repeat",
                    MauSac = "warning"
                });
            }

            // Xem lịch (luôn hiển thị khi có lịch)
            danhSach.Add(new CongViecViewModel
            {
                TieuDe = "Xem lịch thực hành",
                MoTa = "Xem tổng quan lịch thực hành",
                Link = "/LichThucHanh",
                Icon = "bi-table",
                MauSac = "dark"
            });

            return danhSach;
        }

        private List<CongViecViewModel> GetCongViecTrungTam(GiaiDoanHocKy giaiDoan)
        {
            var danhSach = new List<CongViecViewModel>();

            // Quản lý phòng (luôn hiển thị)
            danhSach.Add(new CongViecViewModel
            {
                TieuDe = "Quản lý phòng thực hành",
                MoTa = "Kiểm kê và cập nhật phòng",
                Link = "/QuanLyPhong",
                Icon = "bi-building",
                MauSac = "primary"
            });

            // Quản lý phần mềm
            danhSach.Add(new CongViecViewModel
            {
                TieuDe = "Quản lý phần mềm",
                MoTa = "Quản lý phần mềm các phòng",
                Link = "/QuanLyPhanMem",
                Icon = "bi-pc-display",
                MauSac = "info"
            });

            // Tuần 1: Kiểm kê phòng
            if (giaiDoan == GiaiDoanHocKy.Tuan1_NhapHopDong)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Kiểm kê phòng",
                    MoTa = "Cập nhật tình trạng phòng máy",
                    Link = "/QuanLyPhong/KiemKe",
                    Icon = "bi-clipboard-check",
                    MauSac = "warning"
                });
            }

            // Tuần 3: Duyệt lịch
            if (giaiDoan == GiaiDoanHocKy.Tuan3_SapXepLich)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Duyệt lịch thực hành",
                    MoTa = "Xác nhận lịch từ Phòng đào tạo",
                    Link = "/LichThucHanh/DanhSachChoDuyet",
                    Icon = "bi-check2-square",
                    MauSac = "danger"
                });
            }

            // Tuần 4 + Học kỳ: Duyệt yêu cầu
            if (giaiDoan >= GiaiDoanHocKy.Tuan4_ThongBao && giaiDoan <= GiaiDoanHocKy.DangHoc_ThucHanh)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Duyệt yêu cầu thay đổi",
                    MoTa = "Mượn bù, đổi phòng",
                    Link = "/QuanLyYeuCau",
                    Icon = "bi-arrow-repeat",
                    MauSac = "warning"
                });
            }

            // Xem lịch
            danhSach.Add(new CongViecViewModel
            {
                TieuDe = "Xem lịch thực hành",
                MoTa = "Xem lịch sử dụng phòng",
                Link = "/LichThucHanh",
                Icon = "bi-table",
                MauSac = "dark"
            });

            return danhSach;
        }

        private List<CongViecViewModel> GetCongViecGiangVien(TaiKhoanNew user, GiaiDoanHocKy giaiDoan)
        {
            var danhSach = new List<CongViecViewModel>();

            // Tuần 2: Đăng ký lịch (chỉ GV thỉnh giảng)
            if (giaiDoan == GiaiDoanHocKy.Tuan2_DangKyLich && user.LoaiGiangVien == LoaiGiangVien.ThinhGiang)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Đăng ký lịch giảng dạy",
                    MoTa = "Chọn ngày/ca có thể giảng dạy",
                    Link = "/DangKyLich",
                    Icon = "bi-calendar-plus",
                    MauSac = "warning"
                });
            }

            // Xem lịch của mình
            danhSach.Add(new CongViecViewModel
            {
                TieuDe = "Lịch giảng dạy",
                MoTa = "Xem lịch thực hành của bạn",
                Link = "/LichThucHanh/CuaToi",
                Icon = "bi-calendar-week",
                MauSac = "primary"
            });

            // Tuần 4 + Học kỳ: Yêu cầu thay đổi
            if (giaiDoan >= GiaiDoanHocKy.Tuan4_ThongBao && giaiDoan <= GiaiDoanHocKy.DangHoc_ThucHanh)
            {
                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Mượn bù",
                    MoTa = "Yêu cầu đổi ngày thực hành",
                    Link = "/YeuCau/MuonBu",
                    Icon = "bi-calendar-x",
                    MauSac = "info"
                });

                danhSach.Add(new CongViecViewModel
                {
                    TieuDe = "Đổi phòng",
                    MoTa = "Yêu cầu đổi phòng/ca thực hành",
                    Link = "/YeuCau/DoiPhong",
                    Icon = "bi-door-open",
                    MauSac = "secondary"
                });
            }

            return danhSach;
        }

        private int GetUserId()
        {
            return int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
        }
    }
}
