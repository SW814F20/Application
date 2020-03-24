using System.Collections.Generic;

namespace API.Models
{
    public class Group
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<App.AppModel> Applications { get; set; }
    }
}