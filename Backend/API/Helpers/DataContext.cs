using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using API.Entities;
using System;

namespace API.Helpers
{
    public class DataContext : DbContext
    {
        protected readonly IConfiguration Configuration;

        public DataContext(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        // Configures the PosgresSQL connection string and version.
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
                    => optionsBuilder.UseNpgsql(Configuration.GetConnectionString("DefaultConnection"),
                    optionsBuilder => optionsBuilder.SetPostgresVersion(new Version(9, 6)));

        public DbSet<User> Users { get; set; }
    }
}