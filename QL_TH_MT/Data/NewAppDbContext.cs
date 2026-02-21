using Microsoft.EntityFrameworkCore;
using QL_TH_MT.Models;


namespace QL_TH_MT.Data
{
    public class NewAppDbContext : DbContext
    {
        public NewAppDbContext(DbContextOptions<NewAppDbContext> options)
            : base(options)
        {
        }

        // ====== QUẢN LÝ TÀI KHOẢN ======
        public DbSet<TaiKhoanNew> TaiKhoans { get; set; }

        // ====== QUẢN LÝ HỌC KỲ ======
        public DbSet<HocKyNew> HocKys { get; set; }

        // ====== QUẢN LÝ MÔN HỌC, HỌC PHẦN ======
        public DbSet<MonHocNew> MonHocs { get; set; }
        public DbSet<HocPhanNew> HocPhans { get; set; }

        // ====== QUẢN LÝ HỢP ĐỒNG ======
        public DbSet<HopDongNew> HopDongs { get; set; }
        public DbSet<HopDongMonHocNew> HopDongMonHocs { get; set; }

        // ====== ĐĂNG KÝ LỊCH GIẢNG VIÊN THỈNH GIẢNG ======
        public DbSet<DangKyLichThinhGiangNew> DangKyLichThinhGiangs { get; set; }

        // ====== QUẢN LÝ PHÒNG THỰC HÀNH ======
        public DbSet<PhongThucHanhNew> PhongThucHanhs { get; set; }
        public DbSet<PhanMemNew> PhanMems { get; set; }
        public DbSet<PhongThucHanhPhanMemNew> PhongThucHanhPhanMems { get; set; }

        // ====== LỊCH THỰC HÀNH ======
        public DbSet<LichThucHanhNew> LichThucHanhs { get; set; }

        // ====== YÊU CẦU THAY ĐỔI LỊCH ======
        public DbSet<YeuCauMuonBuNew> YeuCauMuonBus { get; set; }
        public DbSet<YeuCauDoiPhongNew> YeuCauDoiPhongs { get; set; }

        // ====== THÔNG BÁO ======
        public DbSet<ThongBaoNew> ThongBaos { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // ====== CẤU HÌNH TÀI KHOẢN ======
            modelBuilder.Entity<TaiKhoanNew>(entity =>
            {
                entity.ToTable("TaiKhoans");
                entity.HasIndex(e => e.TenDangNhap).IsUnique();
            });

            // ====== CẤU HÌNH HỌC KỲ ======
            modelBuilder.Entity<HocKyNew>(entity =>
            {
                entity.ToTable("HocKys");
                entity.HasOne(e => e.NguoiTao)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiTaoId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // ====== CẤU HÌNH MÔN HỌC ======
            modelBuilder.Entity<MonHocNew>(entity =>
            {
                entity.ToTable("MonHocs");
                entity.HasIndex(e => e.MaMonHoc).IsUnique();
            });

            // ====== CẤU HÌNH HỌC PHẦN ======
            modelBuilder.Entity<HocPhanNew>(entity =>
            {
                entity.ToTable("HocPhans");
                entity.HasIndex(e => e.MaHocPhan).IsUnique();

                entity.HasOne(e => e.MonHoc)
                    .WithMany(m => m.HocPhans)
                    .HasForeignKey(e => e.MonHocId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.HocKy)
                    .WithMany()
                    .HasForeignKey(e => e.HocKyId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.GiangVien)
                    .WithMany()
                    .HasForeignKey(e => e.GiangVienId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // ====== CẤU HÌNH HỢP ĐỒNG ======
            modelBuilder.Entity<HopDongNew>(entity =>
            {
                entity.ToTable("HopDongs");
                entity.HasIndex(e => e.SoHopDong).IsUnique();

                entity.HasOne(e => e.GiangVien)
                    .WithMany()
                    .HasForeignKey(e => e.GiangVienId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.HocKy)
                    .WithMany(h => h.HopDongs)
                    .HasForeignKey(e => e.HocKyId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiTao)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiTaoId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // ====== CẤU HÌNH HỢP ĐỒNG - MÔN HỌC (Many-to-Many) ======
            modelBuilder.Entity<HopDongMonHocNew>(entity =>
            {
                entity.ToTable("HopDongMonHocs");

                entity.HasOne(e => e.HopDong)
                    .WithMany(h => h.HopDongMonHocs)
                    .HasForeignKey(e => e.HopDongId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.MonHoc)
                    .WithMany(m => m.HopDongMonHocs)
                    .HasForeignKey(e => e.MonHocId)
                    .OnDelete(DeleteBehavior.Restrict);

                // Đảm bảo không trùng cặp HopDong-MonHoc
                entity.HasIndex(e => new { e.HopDongId, e.MonHocId }).IsUnique();
            });

            // ====== CẤU HÌNH ĐĂNG KÝ LỊCH THỈNH GIẢNG ======
            modelBuilder.Entity<DangKyLichThinhGiangNew>(entity =>
            {
                entity.ToTable("DangKyLichThinhGiangs");

                entity.HasOne(e => e.HopDong)
                    .WithMany(h => h.DangKyLichs)
                    .HasForeignKey(e => e.HopDongId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.GiangVien)
                    .WithMany()
                    .HasForeignKey(e => e.GiangVienId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.HocKy)
                    .WithMany()
                    .HasForeignKey(e => e.HocKyId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiDuyet)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiDuyetId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // ====== CẤU HÌNH PHÒNG THỰC HÀNH ======
            modelBuilder.Entity<PhongThucHanhNew>(entity =>
            {
                entity.ToTable("PhongThucHanhs");
                entity.HasIndex(e => e.MaPhong).IsUnique();

                entity.HasOne(e => e.NguoiKiemKe)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiKiemKeId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // ====== CẤU HÌNH PHẦN MỀM ======
            modelBuilder.Entity<PhanMemNew>(entity =>
            {
                entity.ToTable("PhanMems");
            });

            // ====== CẤU HÌNH PHÒNG - PHẦN MỀM ======
            modelBuilder.Entity<PhongThucHanhPhanMemNew>(entity =>
            {
                entity.ToTable("PhongThucHanhPhanMems");

                entity.HasOne(e => e.PhongThucHanh)
                    .WithMany(p => p.PhanMems)
                    .HasForeignKey(e => e.PhongThucHanhId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.PhanMem)
                    .WithMany(p => p.PhongThucHanhs)
                    .HasForeignKey(e => e.PhanMemId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.NguoiCaiDat)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiCaiDatId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // ====== CẤU HÌNH LỊCH THỰC HÀNH ======
            modelBuilder.Entity<LichThucHanhNew>(entity =>
            {
                entity.ToTable("LichThucHanhs");

                entity.HasOne(e => e.HocPhan)
                    .WithMany(hp => hp.LichThucHanhs)
                    .HasForeignKey(e => e.HocPhanId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.PhongThucHanh)
                    .WithMany(p => p.LichThucHanhs)
                    .HasForeignKey(e => e.PhongThucHanhId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.HocKy)
                    .WithMany(h => h.LichThucHanhs)
                    .HasForeignKey(e => e.HocKyId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiTao)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiTaoId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiDuyetTTDT)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiDuyetTTDTId)
                    .OnDelete(DeleteBehavior.Restrict);

                // Index để kiểm tra trùng lịch
                entity.HasIndex(e => new { e.PhongThucHanhId, e.NgayThucHanh, e.CaHoc }).IsUnique();
            });

            // ====== CẤU HÌNH YÊU CẦU MƯỢN BÙ ======
            modelBuilder.Entity<YeuCauMuonBuNew>(entity =>
            {
                entity.ToTable("YeuCauMuonBus");

                entity.HasOne(e => e.LichThucHanhGoc)
                    .WithMany()
                    .HasForeignKey(e => e.LichThucHanhGocId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.GiangVien)
                    .WithMany()
                    .HasForeignKey(e => e.GiangVienId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiDuyetPDT)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiDuyetPDTId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiDuyetTTDT)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiDuyetTTDTId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // ====== CẤU HÌNH YÊU CẦU ĐỔI PHÒNG ======
            modelBuilder.Entity<YeuCauDoiPhongNew>(entity =>
            {
                entity.ToTable("YeuCauDoiPhongs");

                entity.HasOne(e => e.LichThucHanhGoc)
                    .WithMany()
                    .HasForeignKey(e => e.LichThucHanhGocId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.GiangVien)
                    .WithMany()
                    .HasForeignKey(e => e.GiangVienId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.PhongGoc)
                    .WithMany()
                    .HasForeignKey(e => e.PhongGocId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.PhongMoi)
                    .WithMany()
                    .HasForeignKey(e => e.PhongMoiId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiDuyetPDT)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiDuyetPDTId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiDuyetTTDT)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiDuyetTTDTId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // ====== CẤU HÌNH THÔNG BÁO ======
            modelBuilder.Entity<ThongBaoNew>(entity =>
            {
                entity.ToTable("ThongBaos");

                entity.HasOne(e => e.NguoiGui)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiGuiId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(e => e.NguoiNhan)
                    .WithMany()
                    .HasForeignKey(e => e.NguoiNhanId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasIndex(e => new { e.NguoiNhanId, e.DaDoc });
            });

            // ====== SEED DATA ======
            var seedDate = new DateTime(2026, 1, 1);
            var defaultPassword = BCrypt.Net.BCrypt.HashPassword("123456");

            modelBuilder.Entity<TaiKhoanNew>().HasData(
                // Admin
                new TaiKhoanNew
                {
                    Id = 1,
                    TenDangNhap = "admin",
                    MatKhauHash = BCrypt.Net.BCrypt.HashPassword("Admin@123"),
                    HoTen = "Administrator",
                    Email = "admin@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.Admin,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                // Phòng Đào Tạo
                new TaiKhoanNew
                {
                    Id = 2,
                    TenDangNhap = "pdt",
                    MatKhauHash = defaultPassword,
                    HoTen = "Phòng Đào Tạo",
                    Email = "pdt@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.PhongDaoTao,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                // Trung tâm Đào tạo Thực hành
                new TaiKhoanNew
                {
                    Id = 3,
                    TenDangNhap = "ttdtth",
                    MatKhauHash = defaultPassword,
                    HoTen = "Trung tâm Đào tạo Thực hành",
                    Email = "ttdtth@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.TrungTamDaoTaoThucHanh,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                // ===== GIẢNG VIÊN CỐ HỮU =====
                new TaiKhoanNew
                {
                    Id = 4,
                    TenDangNhap = "tranphongnha",
                    MatKhauHash = defaultPassword,
                    HoTen = "Trần Phong Nhã",
                    Email = "tranphongnha@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.CoHuu,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                new TaiKhoanNew
                {
                    Id = 5,
                    TenDangNhap = "tranthidung",
                    MatKhauHash = defaultPassword,
                    HoTen = "Trần Thị Dung",
                    Email = "tranthidung@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.CoHuu,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                new TaiKhoanNew
                {
                    Id = 6,
                    TenDangNhap = "phamthimien",
                    MatKhauHash = defaultPassword,
                    HoTen = "Phạm Thị Miên",
                    Email = "phamthimien@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.CoHuu,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                new TaiKhoanNew
                {
                    Id = 7,
                    TenDangNhap = "nguyenvuthai",
                    MatKhauHash = defaultPassword,
                    HoTen = "Nguyễn Vũ Thái",
                    Email = "nguyenvuthai@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.CoHuu,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                new TaiKhoanNew
                {
                    Id = 8,
                    TenDangNhap = "tranquockhanh",
                    MatKhauHash = defaultPassword,
                    HoTen = "Trần Quốc Khánh",
                    Email = "tranquockhanh@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.CoHuu,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                new TaiKhoanNew
                {
                    Id = 9,
                    TenDangNhap = "nguyenthienduong",
                    MatKhauHash = defaultPassword,
                    HoTen = "Nguyễn Thiện Dương",
                    Email = "nguyenthienduong@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.CoHuu,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                new TaiKhoanNew
                {
                    Id = 10,
                    TenDangNhap = "tranthiminhanh",
                    MatKhauHash = defaultPassword,
                    HoTen = "Trần Thị Minh Ánh",
                    Email = "tranthiminhanh@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.CoHuu,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                new TaiKhoanNew
                {
                    Id = 11,
                    TenDangNhap = "tranducanh",
                    MatKhauHash = defaultPassword,
                    HoTen = "Trần Đức Anh",
                    Email = "tranducanh@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.CoHuu,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                // ===== GIẢNG VIÊN THỈNH GIẢNG =====
                new TaiKhoanNew
                {
                    Id = 12,
                    TenDangNhap = "nguyendinhhien",
                    MatKhauHash = defaultPassword,
                    HoTen = "Nguyễn Đình Hiển",
                    Email = "nguyendinhhien@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.ThinhGiang,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                },
                new TaiKhoanNew
                {
                    Id = 13,
                    TenDangNhap = "luutoandinh",
                    MatKhauHash = defaultPassword,
                    HoTen = "Lưu Toàn Định",
                    Email = "luutoandinh@utc2.edu.vn",
                    VaiTro = LoaiVaiTro.GiangVien,
                    LoaiGiangVien = LoaiGiangVien.ThinhGiang,
                    TrangThaiHoatDong = true,
                    NgayTao = seedDate
                }
            );
        }
    }
}



