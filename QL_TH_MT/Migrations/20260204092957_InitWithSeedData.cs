using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace QL_TH_MT.Migrations
{
    /// <inheritdoc />
    public partial class InitWithSeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "MonHocs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaMonHoc = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    TenMonHoc = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    SoTinChi = table.Column<int>(type: "int", nullable: false),
                    SoBuoiThucHanh = table.Column<int>(type: "int", nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    TrangThaiHoatDong = table.Column<bool>(type: "bit", nullable: false),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MonHocs", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "PhanMems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TenPhanMem = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    PhienBan = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    MoTa = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    DungLuong = table.Column<int>(type: "int", nullable: true),
                    TrangThaiHoatDong = table.Column<bool>(type: "bit", nullable: false),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PhanMems", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "TaiKhoans",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TenDangNhap = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    MatKhauHash = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    HoTen = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    SoDienThoai = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    VaiTro = table.Column<int>(type: "int", nullable: false),
                    LoaiGiangVien = table.Column<int>(type: "int", nullable: true),
                    TrangThaiHoatDong = table.Column<bool>(type: "bit", nullable: false),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LanDangNhapCuoi = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TaiKhoans", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "HocKys",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TenHocKy = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    NamHoc = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    SoHocKy = table.Column<int>(type: "int", nullable: false),
                    TienHocKy = table.Column<DateTime>(type: "datetime2", nullable: false),
                    BatDauHocKy = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KetThucHocKy = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KetThucNhapHopDong = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KetThucDangKyLich = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KetThucSapXepLich = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KetThucThongBao = table.Column<DateTime>(type: "datetime2", nullable: true),
                    TrangThai = table.Column<int>(type: "int", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NguoiTaoId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HocKys", x => x.Id);
                    table.ForeignKey(
                        name: "FK_HocKys_TaiKhoans_NguoiTaoId",
                        column: x => x.NguoiTaoId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "PhongThucHanhs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaPhong = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    TenPhong = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    ViTri = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    SucChua = table.Column<int>(type: "int", nullable: false),
                    SoMayHoatDong = table.Column<int>(type: "int", nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    TrangThaiHoatDong = table.Column<bool>(type: "bit", nullable: false),
                    NgayKiemKeGanNhat = table.Column<DateTime>(type: "datetime2", nullable: true),
                    NguoiKiemKeId = table.Column<int>(type: "int", nullable: true),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NgayCapNhat = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PhongThucHanhs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PhongThucHanhs_TaiKhoans_NguoiKiemKeId",
                        column: x => x.NguoiKiemKeId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "ThongBaos",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TieuDe = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    NoiDung = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LoaiThongBao = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    NguoiGuiId = table.Column<int>(type: "int", nullable: true),
                    NguoiNhanId = table.Column<int>(type: "int", nullable: false),
                    DaDoc = table.Column<bool>(type: "bit", nullable: false),
                    LinkLienQuan = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NgayDoc = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ThongBaos", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ThongBaos_TaiKhoans_NguoiGuiId",
                        column: x => x.NguoiGuiId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ThongBaos_TaiKhoans_NguoiNhanId",
                        column: x => x.NguoiNhanId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "HocPhans",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaHocPhan = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    TenHocPhan = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Nhom = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    SiSo = table.Column<int>(type: "int", nullable: false),
                    MonHocId = table.Column<int>(type: "int", nullable: false),
                    HocKyId = table.Column<int>(type: "int", nullable: false),
                    GiangVienId = table.Column<int>(type: "int", nullable: true),
                    TrangThaiHoatDong = table.Column<bool>(type: "bit", nullable: false),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HocPhans", x => x.Id);
                    table.ForeignKey(
                        name: "FK_HocPhans_HocKys_HocKyId",
                        column: x => x.HocKyId,
                        principalTable: "HocKys",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_HocPhans_MonHocs_MonHocId",
                        column: x => x.MonHocId,
                        principalTable: "MonHocs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_HocPhans_TaiKhoans_GiangVienId",
                        column: x => x.GiangVienId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "HopDongs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SoHopDong = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    GiangVienId = table.Column<int>(type: "int", nullable: false),
                    MonHocId = table.Column<int>(type: "int", nullable: false),
                    HocKyId = table.Column<int>(type: "int", nullable: false),
                    SoHocPhan = table.Column<int>(type: "int", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    TrangThai = table.Column<int>(type: "int", nullable: false),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NguoiTaoId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HopDongs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_HopDongs_HocKys_HocKyId",
                        column: x => x.HocKyId,
                        principalTable: "HocKys",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_HopDongs_MonHocs_MonHocId",
                        column: x => x.MonHocId,
                        principalTable: "MonHocs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_HopDongs_TaiKhoans_GiangVienId",
                        column: x => x.GiangVienId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_HopDongs_TaiKhoans_NguoiTaoId",
                        column: x => x.NguoiTaoId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "PhongThucHanhPhanMems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PhongThucHanhId = table.Column<int>(type: "int", nullable: false),
                    PhanMemId = table.Column<int>(type: "int", nullable: false),
                    NgayCaiDat = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NguoiCaiDatId = table.Column<int>(type: "int", nullable: true),
                    GhiChu = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PhongThucHanhPhanMems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PhongThucHanhPhanMems_PhanMems_PhanMemId",
                        column: x => x.PhanMemId,
                        principalTable: "PhanMems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PhongThucHanhPhanMems_PhongThucHanhs_PhongThucHanhId",
                        column: x => x.PhongThucHanhId,
                        principalTable: "PhongThucHanhs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PhongThucHanhPhanMems_TaiKhoans_NguoiCaiDatId",
                        column: x => x.NguoiCaiDatId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "LichThucHanhs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    HocPhanId = table.Column<int>(type: "int", nullable: false),
                    PhongThucHanhId = table.Column<int>(type: "int", nullable: false),
                    HocKyId = table.Column<int>(type: "int", nullable: false),
                    TuanHoc = table.Column<int>(type: "int", nullable: false),
                    ThuTrongTuan = table.Column<int>(type: "int", nullable: false),
                    CaHoc = table.Column<int>(type: "int", nullable: false),
                    NgayThucHanh = table.Column<DateTime>(type: "datetime2", nullable: false),
                    BuoiThu = table.Column<int>(type: "int", nullable: false),
                    TrangThai = table.Column<int>(type: "int", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    NguoiTaoId = table.Column<int>(type: "int", nullable: true),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NguoiDuyetTTDTId = table.Column<int>(type: "int", nullable: true),
                    NgayDuyetTTDT = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LichThucHanhs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LichThucHanhs_HocKys_HocKyId",
                        column: x => x.HocKyId,
                        principalTable: "HocKys",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_LichThucHanhs_HocPhans_HocPhanId",
                        column: x => x.HocPhanId,
                        principalTable: "HocPhans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_LichThucHanhs_PhongThucHanhs_PhongThucHanhId",
                        column: x => x.PhongThucHanhId,
                        principalTable: "PhongThucHanhs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_LichThucHanhs_TaiKhoans_NguoiDuyetTTDTId",
                        column: x => x.NguoiDuyetTTDTId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_LichThucHanhs_TaiKhoans_NguoiTaoId",
                        column: x => x.NguoiTaoId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "DangKyLichThinhGiangs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    HopDongId = table.Column<int>(type: "int", nullable: false),
                    GiangVienId = table.Column<int>(type: "int", nullable: false),
                    HocKyId = table.Column<int>(type: "int", nullable: false),
                    ThuTrongTuan = table.Column<int>(type: "int", nullable: false),
                    CaHoc = table.Column<int>(type: "int", nullable: false),
                    SoTuanLienTiep = table.Column<int>(type: "int", nullable: false),
                    TuanBatDau = table.Column<int>(type: "int", nullable: true),
                    GhiChu = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    TrangThai = table.Column<int>(type: "int", nullable: false),
                    NgayDangKy = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NguoiDuyetId = table.Column<int>(type: "int", nullable: true),
                    NgayDuyet = table.Column<DateTime>(type: "datetime2", nullable: true),
                    LyDoTuChoi = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DangKyLichThinhGiangs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DangKyLichThinhGiangs_HocKys_HocKyId",
                        column: x => x.HocKyId,
                        principalTable: "HocKys",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_DangKyLichThinhGiangs_HopDongs_HopDongId",
                        column: x => x.HopDongId,
                        principalTable: "HopDongs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DangKyLichThinhGiangs_TaiKhoans_GiangVienId",
                        column: x => x.GiangVienId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_DangKyLichThinhGiangs_TaiKhoans_NguoiDuyetId",
                        column: x => x.NguoiDuyetId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "YeuCauDoiPhongs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    LichThucHanhGocId = table.Column<int>(type: "int", nullable: false),
                    GiangVienId = table.Column<int>(type: "int", nullable: false),
                    NgayThucHanhGoc = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CaHocGoc = table.Column<int>(type: "int", nullable: false),
                    PhongGocId = table.Column<int>(type: "int", nullable: false),
                    NgayThucHanhMoi = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CaHocMoi = table.Column<int>(type: "int", nullable: true),
                    PhongMoiId = table.Column<int>(type: "int", nullable: true),
                    LyDo = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    TrangThai = table.Column<int>(type: "int", nullable: false),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NguoiDuyetPDTId = table.Column<int>(type: "int", nullable: true),
                    NgayDuyetPDT = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KetQuaDuyetPDT = table.Column<bool>(type: "bit", nullable: true),
                    GhiChuPDT = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    NguoiDuyetTTDTId = table.Column<int>(type: "int", nullable: true),
                    NgayDuyetTTDT = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KetQuaDuyetTTDT = table.Column<bool>(type: "bit", nullable: true),
                    GhiChuTTDT = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_YeuCauDoiPhongs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_YeuCauDoiPhongs_LichThucHanhs_LichThucHanhGocId",
                        column: x => x.LichThucHanhGocId,
                        principalTable: "LichThucHanhs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_YeuCauDoiPhongs_PhongThucHanhs_PhongGocId",
                        column: x => x.PhongGocId,
                        principalTable: "PhongThucHanhs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_YeuCauDoiPhongs_PhongThucHanhs_PhongMoiId",
                        column: x => x.PhongMoiId,
                        principalTable: "PhongThucHanhs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_YeuCauDoiPhongs_TaiKhoans_GiangVienId",
                        column: x => x.GiangVienId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_YeuCauDoiPhongs_TaiKhoans_NguoiDuyetPDTId",
                        column: x => x.NguoiDuyetPDTId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_YeuCauDoiPhongs_TaiKhoans_NguoiDuyetTTDTId",
                        column: x => x.NguoiDuyetTTDTId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "YeuCauMuonBus",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    LichThucHanhGocId = table.Column<int>(type: "int", nullable: false),
                    GiangVienId = table.Column<int>(type: "int", nullable: false),
                    NgayGoc = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NgayMoi = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CaHocMoi = table.Column<int>(type: "int", nullable: true),
                    LyDo = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    TrangThai = table.Column<int>(type: "int", nullable: false),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NguoiDuyetPDTId = table.Column<int>(type: "int", nullable: true),
                    NgayDuyetPDT = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KetQuaDuyetPDT = table.Column<bool>(type: "bit", nullable: true),
                    GhiChuPDT = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    NguoiDuyetTTDTId = table.Column<int>(type: "int", nullable: true),
                    NgayDuyetTTDT = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KetQuaDuyetTTDT = table.Column<bool>(type: "bit", nullable: true),
                    GhiChuTTDT = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_YeuCauMuonBus", x => x.Id);
                    table.ForeignKey(
                        name: "FK_YeuCauMuonBus_LichThucHanhs_LichThucHanhGocId",
                        column: x => x.LichThucHanhGocId,
                        principalTable: "LichThucHanhs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_YeuCauMuonBus_TaiKhoans_GiangVienId",
                        column: x => x.GiangVienId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_YeuCauMuonBus_TaiKhoans_NguoiDuyetPDTId",
                        column: x => x.NguoiDuyetPDTId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_YeuCauMuonBus_TaiKhoans_NguoiDuyetTTDTId",
                        column: x => x.NguoiDuyetTTDTId,
                        principalTable: "TaiKhoans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.InsertData(
                table: "TaiKhoans",
                columns: new[] { "Id", "Email", "HoTen", "LanDangNhapCuoi", "LoaiGiangVien", "MatKhauHash", "NgayTao", "SoDienThoai", "TenDangNhap", "TrangThaiHoatDong", "VaiTro" },
                values: new object[,]
                {
                    { 1, "admin@utc2.edu.vn", "Administrator", null, null, "$2a$11$d3RUGyYDcsRhqLL.KCGNueiScweN90Vq7/QBfu.c5OGKQzjlEfdIC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "admin", true, 1 },
                    { 2, "pdt@utc2.edu.vn", "Phòng Đào Tạo", null, null, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "pdt", true, 2 },
                    { 3, "ttdtth@utc2.edu.vn", "Trung tâm Đào tạo Thực hành", null, null, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "ttdtth", true, 3 },
                    { 4, "tranphongnha@utc2.edu.vn", "Trần Phong Nhã", null, 2, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "tranphongnha", true, 4 },
                    { 5, "tranthidung@utc2.edu.vn", "Trần Thị Dung", null, 2, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "tranthidung", true, 4 },
                    { 6, "phamthimien@utc2.edu.vn", "Phạm Thị Miên", null, 2, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "phamthimien", true, 4 },
                    { 7, "nguyenvuthai@utc2.edu.vn", "Nguyễn Vũ Thái", null, 2, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "nguyenvuthai", true, 4 },
                    { 8, "tranquockhanh@utc2.edu.vn", "Trần Quốc Khánh", null, 2, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "tranquockhanh", true, 4 },
                    { 9, "nguyenthienduong@utc2.edu.vn", "Nguyễn Thiện Dương", null, 2, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "nguyenthienduong", true, 4 },
                    { 10, "tranthiminhanh@utc2.edu.vn", "Trần Thị Minh Ánh", null, 2, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "tranthiminhanh", true, 4 },
                    { 11, "tranducanh@utc2.edu.vn", "Trần Đức Anh", null, 2, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "tranducanh", true, 4 },
                    { 12, "nguyendinhhien@utc2.edu.vn", "Nguyễn Đình Hiển", null, 1, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "nguyendinhhien", true, 4 },
                    { 13, "luutoandinh@utc2.edu.vn", "Lưu Toàn Định", null, 1, "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "luutoandinh", true, 4 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_DangKyLichThinhGiangs_GiangVienId",
                table: "DangKyLichThinhGiangs",
                column: "GiangVienId");

            migrationBuilder.CreateIndex(
                name: "IX_DangKyLichThinhGiangs_HocKyId",
                table: "DangKyLichThinhGiangs",
                column: "HocKyId");

            migrationBuilder.CreateIndex(
                name: "IX_DangKyLichThinhGiangs_HopDongId",
                table: "DangKyLichThinhGiangs",
                column: "HopDongId");

            migrationBuilder.CreateIndex(
                name: "IX_DangKyLichThinhGiangs_NguoiDuyetId",
                table: "DangKyLichThinhGiangs",
                column: "NguoiDuyetId");

            migrationBuilder.CreateIndex(
                name: "IX_HocKys_NguoiTaoId",
                table: "HocKys",
                column: "NguoiTaoId");

            migrationBuilder.CreateIndex(
                name: "IX_HocPhans_GiangVienId",
                table: "HocPhans",
                column: "GiangVienId");

            migrationBuilder.CreateIndex(
                name: "IX_HocPhans_HocKyId",
                table: "HocPhans",
                column: "HocKyId");

            migrationBuilder.CreateIndex(
                name: "IX_HocPhans_MaHocPhan",
                table: "HocPhans",
                column: "MaHocPhan",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_HocPhans_MonHocId",
                table: "HocPhans",
                column: "MonHocId");

            migrationBuilder.CreateIndex(
                name: "IX_HopDongs_GiangVienId",
                table: "HopDongs",
                column: "GiangVienId");

            migrationBuilder.CreateIndex(
                name: "IX_HopDongs_HocKyId",
                table: "HopDongs",
                column: "HocKyId");

            migrationBuilder.CreateIndex(
                name: "IX_HopDongs_MonHocId",
                table: "HopDongs",
                column: "MonHocId");

            migrationBuilder.CreateIndex(
                name: "IX_HopDongs_NguoiTaoId",
                table: "HopDongs",
                column: "NguoiTaoId");

            migrationBuilder.CreateIndex(
                name: "IX_HopDongs_SoHopDong",
                table: "HopDongs",
                column: "SoHopDong",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_LichThucHanhs_HocKyId",
                table: "LichThucHanhs",
                column: "HocKyId");

            migrationBuilder.CreateIndex(
                name: "IX_LichThucHanhs_HocPhanId",
                table: "LichThucHanhs",
                column: "HocPhanId");

            migrationBuilder.CreateIndex(
                name: "IX_LichThucHanhs_NguoiDuyetTTDTId",
                table: "LichThucHanhs",
                column: "NguoiDuyetTTDTId");

            migrationBuilder.CreateIndex(
                name: "IX_LichThucHanhs_NguoiTaoId",
                table: "LichThucHanhs",
                column: "NguoiTaoId");

            migrationBuilder.CreateIndex(
                name: "IX_LichThucHanhs_PhongThucHanhId_NgayThucHanh_CaHoc",
                table: "LichThucHanhs",
                columns: new[] { "PhongThucHanhId", "NgayThucHanh", "CaHoc" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_MonHocs_MaMonHoc",
                table: "MonHocs",
                column: "MaMonHoc",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_PhongThucHanhPhanMems_NguoiCaiDatId",
                table: "PhongThucHanhPhanMems",
                column: "NguoiCaiDatId");

            migrationBuilder.CreateIndex(
                name: "IX_PhongThucHanhPhanMems_PhanMemId",
                table: "PhongThucHanhPhanMems",
                column: "PhanMemId");

            migrationBuilder.CreateIndex(
                name: "IX_PhongThucHanhPhanMems_PhongThucHanhId",
                table: "PhongThucHanhPhanMems",
                column: "PhongThucHanhId");

            migrationBuilder.CreateIndex(
                name: "IX_PhongThucHanhs_MaPhong",
                table: "PhongThucHanhs",
                column: "MaPhong",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_PhongThucHanhs_NguoiKiemKeId",
                table: "PhongThucHanhs",
                column: "NguoiKiemKeId");

            migrationBuilder.CreateIndex(
                name: "IX_TaiKhoans_TenDangNhap",
                table: "TaiKhoans",
                column: "TenDangNhap",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ThongBaos_NguoiGuiId",
                table: "ThongBaos",
                column: "NguoiGuiId");

            migrationBuilder.CreateIndex(
                name: "IX_ThongBaos_NguoiNhanId_DaDoc",
                table: "ThongBaos",
                columns: new[] { "NguoiNhanId", "DaDoc" });

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauDoiPhongs_GiangVienId",
                table: "YeuCauDoiPhongs",
                column: "GiangVienId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauDoiPhongs_LichThucHanhGocId",
                table: "YeuCauDoiPhongs",
                column: "LichThucHanhGocId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauDoiPhongs_NguoiDuyetPDTId",
                table: "YeuCauDoiPhongs",
                column: "NguoiDuyetPDTId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauDoiPhongs_NguoiDuyetTTDTId",
                table: "YeuCauDoiPhongs",
                column: "NguoiDuyetTTDTId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauDoiPhongs_PhongGocId",
                table: "YeuCauDoiPhongs",
                column: "PhongGocId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauDoiPhongs_PhongMoiId",
                table: "YeuCauDoiPhongs",
                column: "PhongMoiId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauMuonBus_GiangVienId",
                table: "YeuCauMuonBus",
                column: "GiangVienId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauMuonBus_LichThucHanhGocId",
                table: "YeuCauMuonBus",
                column: "LichThucHanhGocId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauMuonBus_NguoiDuyetPDTId",
                table: "YeuCauMuonBus",
                column: "NguoiDuyetPDTId");

            migrationBuilder.CreateIndex(
                name: "IX_YeuCauMuonBus_NguoiDuyetTTDTId",
                table: "YeuCauMuonBus",
                column: "NguoiDuyetTTDTId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DangKyLichThinhGiangs");

            migrationBuilder.DropTable(
                name: "PhongThucHanhPhanMems");

            migrationBuilder.DropTable(
                name: "ThongBaos");

            migrationBuilder.DropTable(
                name: "YeuCauDoiPhongs");

            migrationBuilder.DropTable(
                name: "YeuCauMuonBus");

            migrationBuilder.DropTable(
                name: "HopDongs");

            migrationBuilder.DropTable(
                name: "PhanMems");

            migrationBuilder.DropTable(
                name: "LichThucHanhs");

            migrationBuilder.DropTable(
                name: "HocPhans");

            migrationBuilder.DropTable(
                name: "PhongThucHanhs");

            migrationBuilder.DropTable(
                name: "HocKys");

            migrationBuilder.DropTable(
                name: "MonHocs");

            migrationBuilder.DropTable(
                name: "TaiKhoans");
        }
    }
}
