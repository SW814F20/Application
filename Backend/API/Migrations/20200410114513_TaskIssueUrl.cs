using Microsoft.EntityFrameworkCore.Migrations;

namespace API.Migrations
{
    public partial class TaskIssueUrl : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "IssueUrl",
                table: "Tasks",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IssueUrl",
                table: "Tasks");
        }
    }
}
