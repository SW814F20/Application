using Microsoft.AspNetCore.Identity;

namespace API.Models
{
    public class User : IdentityUser<string>
    {
        public Group Group { get; set; }
    }
}