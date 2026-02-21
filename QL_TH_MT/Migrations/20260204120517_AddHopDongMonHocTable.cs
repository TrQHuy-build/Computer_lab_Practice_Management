using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace QL_TH_MT.Migrations
{
    /// <inheritdoc />
    public partial class AddHopDongMonHocTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_HopDongs_MonHocs_MonHocId",
                table: "HopDongs");

            migrationBuilder.DropIndex(
                name: "IX_HopDongs_MonHocId",
                table: "HopDongs");

            migrationBuilder.DropColumn(
                name: "MonHocId",
                table: "HopDongs");

            migrationBuilder.DropColumn(
                name: "SoHocPhan",
                table: "HopDongs");

            migrationBuilder.CreateTable(
                name: "HopDongMonHocs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    HopDongId = table.Column<int>(type: "int", nullable: false),
                    MonHocId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HopDongMonHocs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_HopDongMonHocs_HopDongs_HopDongId",
                        column: x => x.HopDongId,
                        principalTable: "HopDongs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_HopDongMonHocs_MonHocs_MonHocId",
                        column: x => x.MonHocId,
                        principalTable: "MonHocs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 1,
                column: "MatKhauHash",
                value: "$2a$11$NmEjbxwRj9ZGjVOqoT/exOHnJjhV2IHbYleZeRq30cf1aeEW.ifN2");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 2,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 3,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 4,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 5,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 6,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 7,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 8,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 9,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 10,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 11,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 12,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 13,
                column: "MatKhauHash",
                value: "$2a$11$2IJkqc0YrUUXkEplL8rjZOdNipz5MNcHJXrMhZHD47eYQKnnxLt5u");

            migrationBuilder.CreateIndex(
                name: "IX_HopDongMonHocs_HopDongId_MonHocId",
                table: "HopDongMonHocs",
                columns: new[] { "HopDongId", "MonHocId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_HopDongMonHocs_MonHocId",
                table: "HopDongMonHocs",
                column: "MonHocId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "HopDongMonHocs");

            migrationBuilder.AddColumn<int>(
                name: "MonHocId",
                table: "HopDongs",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "SoHocPhan",
                table: "HopDongs",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 1,
                column: "MatKhauHash",
                value: "$2a$11$d3RUGyYDcsRhqLL.KCGNueiScweN90Vq7/QBfu.c5OGKQzjlEfdIC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 2,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 3,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 4,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 5,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 6,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 7,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 8,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 9,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 10,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 11,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 12,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.UpdateData(
                table: "TaiKhoans",
                keyColumn: "Id",
                keyValue: 13,
                column: "MatKhauHash",
                value: "$2a$11$c4s4Tyja7T649TUYij6XzOjGlLrmSa7BZbodAYtoXqnK1kUK7VXjC");

            migrationBuilder.CreateIndex(
                name: "IX_HopDongs_MonHocId",
                table: "HopDongs",
                column: "MonHocId");

            migrationBuilder.AddForeignKey(
                name: "FK_HopDongs_MonHocs_MonHocId",
                table: "HopDongs",
                column: "MonHocId",
                principalTable: "MonHocs",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
