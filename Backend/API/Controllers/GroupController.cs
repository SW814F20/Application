using API.Models;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class GroupController : ControllerBase
    {
        private readonly APIContext _context;

        public GroupController(APIContext context)
        {
            _context = context;
            if (_context.User == null)
            {
                _context.User.Add(new User { }); _context.SaveChanges();
            }
        }
    }
}