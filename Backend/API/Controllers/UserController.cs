using API.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly APIContext _context;

        private readonly UserManager<User> _userManager;
        public UserController(APIContext context)
        {
            _context = context;
            if (_context.User == null)
            {
                _context.User.Add(new User { }); _context.SaveChanges();
            }
        }
    }
}