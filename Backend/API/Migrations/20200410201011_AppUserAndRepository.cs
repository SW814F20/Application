using Microsoft.EntityFrameworkCore.Migrations;

namespace API.Migrations
{
    public partial class AppUserAndRepository : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AppUrl",
                table: "Apps");

            migrationBuilder.AddColumn<string>(
                name: "Repository",
                table: "Apps",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "User",
                table: "Apps",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Repository",
                table: "Apps");

            migrationBuilder.DropColumn(
                name: "User",
                table: "Apps");

            migrationBuilder.AddColumn<string>(
                name: "AppUrl",
                table: "Apps",
                type: "text",
                nullable: true);
        }
    }
}
