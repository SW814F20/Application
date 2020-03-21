using Microsoft.EntityFrameworkCore.Migrations;

namespace API.Migrations
{
    public partial class AppColor : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "AppColor",
                table: "Apps",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AppColor",
                table: "Apps");
        }
    }
}
