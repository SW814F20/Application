using System.Collections.Generic;

namespace API.Entities
{
    public class Task
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int AppId { get; set; }
        public List<int> ScreenId { get; set; }
        public string Description { get; set; }
        public string IssueUrl { get; set; }
    }
}