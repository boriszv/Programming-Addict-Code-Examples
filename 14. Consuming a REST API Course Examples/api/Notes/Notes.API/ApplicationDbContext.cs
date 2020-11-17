using Microsoft.EntityFrameworkCore;
using Notes.API.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API
{
    public class ApplicationDbContext : DbContext
    {
        public DbSet<Note> Notes { get; set; }
        public DbSet<APIKey> APIKeys { get; set; }
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySql("connection string is omitted for security reasons");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}
