using Microsoft.EntityFrameworkCore;
namespace API.Models
{
    public class APIContext : DbContext
    {
        public APIContext(DbContextOptions<APIContext> options) : base(options)
        {
        }
        public DbSet<User> User { get; set; }

    }
}