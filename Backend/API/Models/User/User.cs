using System.Collections.Generic;

namespace API.Models.User
{
    public class UserModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Username { get; set; }
        public List<App.AppModel> App { get; set; }
    }
}