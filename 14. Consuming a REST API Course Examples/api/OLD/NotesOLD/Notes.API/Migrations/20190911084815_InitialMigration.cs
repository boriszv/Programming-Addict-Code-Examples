using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Notes.API.Migrations
{
    public partial class InitialMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "APIKey",
                columns: table => new
                {
                    ID = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_APIKey", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Note",
                columns: table => new
                {
                    NoteID = table.Column<Guid>(nullable: false),
                    NoteTitle = table.Column<string>(maxLength: 50, nullable: false),
                    NoteContent = table.Column<string>(maxLength: 3000, nullable: false),
                    CreateDateTime = table.Column<DateTimeOffset>(nullable: false),
                    LatestEditDateTime = table.Column<DateTimeOffset>(nullable: true),
                    APIKeyID = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Note", x => x.NoteID);
                    table.ForeignKey(
                        name: "FK_Note_APIKey_APIKeyID",
                        column: x => x.APIKeyID,
                        principalTable: "APIKey",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Note_APIKeyID",
                table: "Note",
                column: "APIKeyID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Note");

            migrationBuilder.DropTable(
                name: "APIKey");
        }
    }
}
