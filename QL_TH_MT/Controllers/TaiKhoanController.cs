using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using QL_TH_MT.Data;
using QL_TH_MT.Models;
using QL_TH_MT.ViewModels;


namespace QL_TH_MT.Controllers
{
    public class TaiKhoanController : Controller
    {
        private readonly NewAppDbContext _context;

        public TaiKhoanController(NewAppDbContext context)
        {
            _context = context;
        }

        // GET: /TaiKhoan/DangNhap
        [HttpGet]
        public IActionResult DangNhap(string? returnUrl = null)
        {
            if (User.Identity?.IsAuthenticated == true)
            {
                return RedirectToAction("Index", "TrangChu");
            }

            ViewData["ReturnUrl"] = returnUrl;
            return View();
        }

        // POST: /TaiKhoan/DangNhap
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DangNhap(LoginViewModel model, string? returnUrl = null)
        {
            ViewData["ReturnUrl"] = returnUrl;

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var taiKhoan = await _context.TaiKhoans
                .FirstOrDefaultAsync(t => t.TenDangNhap == model.TenDangNhap && t.TrangThaiHoatDong);

            if (taiKhoan == null || !BCrypt.Net.BCrypt.Verify(model.MatKhau, taiKhoan.MatKhauHash))
            {
                ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không đúng");
                return View(model);
            }

            // Tạo claims
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, taiKhoan.Id.ToString()),
                new Claim(ClaimTypes.Name, taiKhoan.HoTen),
                new Claim("TenDangNhap", taiKhoan.TenDangNhap),
                new Claim(ClaimTypes.Role, taiKhoan.VaiTro.ToString())
            };

            if (taiKhoan.LoaiGiangVien.HasValue)
            {
                claims.Add(new Claim("LoaiGiangVien", taiKhoan.LoaiGiangVien.Value.ToString()));
            }

            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            var authProperties = new AuthenticationProperties
            {
                IsPersistent = model.RememberMe,
                ExpiresUtc = DateTimeOffset.UtcNow.AddHours(8)
            };

            await HttpContext.SignInAsync(
                CookieAuthenticationDefaults.AuthenticationScheme,
                new ClaimsPrincipal(claimsIdentity),
                authProperties);

            // Cập nhật lần đăng nhập cuối
            taiKhoan.LanDangNhapCuoi = DateTime.Now;
            await _context.SaveChangesAsync();

            if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }

            return RedirectToAction("Index", "TrangChu");
        }

        // GET: /TaiKhoan/DangXuat
        public async Task<IActionResult> DangXuat()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("DangNhap");
        }

        // GET: /TaiKhoan/TuChoiTruyCap
        public IActionResult TuChoiTruyCap()
        {
            return View();
        }

        // GET: /TaiKhoan/DoiMatKhau
        [HttpGet]
        public IActionResult DoiMatKhau()
        {
            if (User.Identity?.IsAuthenticated != true)
            {
                return RedirectToAction("DangNhap");
            }
            return View();
        }

        // POST: /TaiKhoan/DoiMatKhau
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DoiMatKhau(DoiMatKhauViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
            var taiKhoan = await _context.TaiKhoans.FindAsync(userId);

            if (taiKhoan == null)
            {
                return RedirectToAction("DangNhap");
            }

            if (!BCrypt.Net.BCrypt.Verify(model.MatKhauCu, taiKhoan.MatKhauHash))
            {
                ModelState.AddModelError("MatKhauCu", "Mật khẩu hiện tại không đúng");
                return View(model);
            }

            taiKhoan.MatKhauHash = BCrypt.Net.BCrypt.HashPassword(model.MatKhauMoi);
            await _context.SaveChangesAsync();

            TempData["Success"] = "Đổi mật khẩu thành công!";
            return RedirectToAction("Index", "TrangChu");
        }

        #region Admin - Quản lý tài khoản

        // GET: /TaiKhoan/DanhSach
        [HttpGet]
        public async Task<IActionResult> DanhSach()
        {
            if (!KiemTraQuyenAdmin())
            {
                return RedirectToAction("TuChoiTruyCap");
            }

            var danhSach = await _context.TaiKhoans
                .OrderBy(t => t.VaiTro)
                .ThenBy(t => t.HoTen)
                .Select(t => new TaiKhoanViewModel
                {
                    Id = t.Id,
                    TenDangNhap = t.TenDangNhap,
                    HoTen = t.HoTen,
                    Email = t.Email,
                    VaiTro = t.VaiTro.ToString(),
                    LoaiGiangVien = t.LoaiGiangVien.HasValue ? t.LoaiGiangVien.Value.ToString() : null,
                    DangHoatDong = t.TrangThaiHoatDong
                })
                .ToListAsync();

            return View(danhSach);
        }

        // GET: /TaiKhoan/Tao
        [HttpGet]
        public IActionResult Tao()
        {
            if (!KiemTraQuyenAdmin())
            {
                return RedirectToAction("TuChoiTruyCap");
            }

            return View(new CreateAccountViewModel());
        }

        // POST: /TaiKhoan/Tao
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Tao(CreateAccountViewModel model)
        {
            if (!KiemTraQuyenAdmin())
            {
                return RedirectToAction("TuChoiTruyCap");
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // Kiểm tra tên đăng nhập đã tồn tại
            if (await _context.TaiKhoans.AnyAsync(t => t.TenDangNhap == model.TenDangNhap))
            {
                ModelState.AddModelError("TenDangNhap", "Tên đăng nhập đã tồn tại");
                return View(model);
            }

            // Parse VaiTro từ string sang enum
            if (!Enum.TryParse<LoaiVaiTro>(model.VaiTro, out var vaiTro))
            {
                ModelState.AddModelError("VaiTro", "Vai trò không hợp lệ");
                return View(model);
            }

            // Parse LoaiGiangVien nếu có
            LoaiGiangVien? loaiGiangVien = null;
            if (vaiTro == LoaiVaiTro.GiangVien && !string.IsNullOrEmpty(model.LoaiGiangVien))
            {
                if (Enum.TryParse<LoaiGiangVien>(model.LoaiGiangVien, out var lgv))
                {
                    loaiGiangVien = lgv;
                }
            }

            var taiKhoan = new TaiKhoanNew
            {
                TenDangNhap = model.TenDangNhap,
                MatKhauHash = BCrypt.Net.BCrypt.HashPassword(model.MatKhau),
                HoTen = model.HoTen,
                Email = model.Email,
                SoDienThoai = model.SoDienThoai,
                VaiTro = vaiTro,
                LoaiGiangVien = loaiGiangVien,
                TrangThaiHoatDong = true,
                NgayTao = DateTime.Now
            };

            _context.TaiKhoans.Add(taiKhoan);
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Tạo tài khoản {model.TenDangNhap} thành công!";
            return RedirectToAction("DanhSach");
        }

        // GET: /TaiKhoan/Sua/5
        [HttpGet]
        public async Task<IActionResult> Sua(int id)
        {
            if (!KiemTraQuyenAdmin())
            {
                return RedirectToAction("TuChoiTruyCap");
            }

            var taiKhoan = await _context.TaiKhoans.FindAsync(id);
            if (taiKhoan == null)
            {
                return NotFound();
            }

            var model = new TaoTaiKhoanViewModel
            {
                TenDangNhap = taiKhoan.TenDangNhap,
                HoTen = taiKhoan.HoTen,
                Email = taiKhoan.Email,
                SoDienThoai = taiKhoan.SoDienThoai,
                VaiTro = taiKhoan.VaiTro,
                LoaiGiangVien = taiKhoan.LoaiGiangVien
            };

            ViewBag.TaiKhoanId = id;
            return View(model);
        }

        // POST: /TaiKhoan/Sua/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Sua(int id, TaoTaiKhoanViewModel model)
        {
            if (!KiemTraQuyenAdmin())
            {
                return RedirectToAction("TuChoiTruyCap");
            }

            var taiKhoan = await _context.TaiKhoans.FindAsync(id);
            if (taiKhoan == null)
            {
                return NotFound();
            }

            // Không validate mật khẩu khi sửa (có thể để trống)
            ModelState.Remove("MatKhau");
            ModelState.Remove("XacNhanMatKhau");

            if (!ModelState.IsValid)
            {
                ViewBag.TaiKhoanId = id;
                return View(model);
            }

            taiKhoan.HoTen = model.HoTen;
            taiKhoan.Email = model.Email;
            taiKhoan.SoDienThoai = model.SoDienThoai;
            taiKhoan.VaiTro = model.VaiTro;
            taiKhoan.LoaiGiangVien = model.VaiTro == LoaiVaiTro.GiangVien ? model.LoaiGiangVien : null;

            // Đổi mật khẩu nếu có nhập
            if (!string.IsNullOrEmpty(model.MatKhau))
            {
                taiKhoan.MatKhauHash = BCrypt.Net.BCrypt.HashPassword(model.MatKhau);
            }

            await _context.SaveChangesAsync();

            TempData["Success"] = "Cập nhật tài khoản thành công!";
            return RedirectToAction("DanhSach");
        }

        // POST: /TaiKhoan/KhoaMo/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> KhoaMo(int id)
        {
            if (!KiemTraQuyenAdmin())
            {
                return Json(new { success = false, message = "Không có quyền" });
            }

            var taiKhoan = await _context.TaiKhoans.FindAsync(id);
            if (taiKhoan == null)
            {
                return Json(new { success = false, message = "Không tìm thấy tài khoản" });
            }

            taiKhoan.TrangThaiHoatDong = !taiKhoan.TrangThaiHoatDong;
            await _context.SaveChangesAsync();

            return Json(new
            {
                success = true,
                message = taiKhoan.TrangThaiHoatDong ? "Đã mở khóa tài khoản" : "Đã khóa tài khoản",
                trangThai = taiKhoan.TrangThaiHoatDong
            });
        }

        // POST: /TaiKhoan/Xoa
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Xoa([FromForm] int id)
        {
            if (!KiemTraQuyenAdmin())
            {
                TempData["Error"] = "Không có quyền thực hiện thao tác này!";
                return RedirectToAction("DanhSach");
            }

            var taiKhoan = await _context.TaiKhoans.FindAsync(id);
            if (taiKhoan == null)
            {
                TempData["Error"] = "Không tìm thấy tài khoản!";
                return RedirectToAction("DanhSach");
            }

            // Không cho xóa chính mình
            if (taiKhoan.Id == GetUserId())
            {
                TempData["Error"] = "Không thể xóa tài khoản đang đăng nhập!";
                return RedirectToAction("DanhSach");
            }

            // Soft delete - chuyển trạng thái về false thay vì xóa hoàn toàn
            taiKhoan.TrangThaiHoatDong = false;
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Đã xóa tài khoản {taiKhoan.TenDangNhap} - {taiKhoan.HoTen} thành công!";
            return RedirectToAction("DanhSach");
        }

        #endregion

        #region Helper

        private bool KiemTraQuyenAdmin()
        {
            return User.IsInRole(LoaiVaiTro.Admin.ToString());
        }

        private int GetUserId()
        {
            return int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
        }

        #endregion
    }
}


