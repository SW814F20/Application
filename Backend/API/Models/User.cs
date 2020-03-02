using Microsoft.AspNetCore.Identity;

namespace API.Models
{
    public class User : IdentityUser<string>
    {
        public string DisplayName { get; set; }
        public string UserEmail { get; set; }
        // from the group model (Entity framework will connect the Primarykey and forign key)
        public Group Group { get; set; }
        public int GroupId { get; set; }
    }
}