using System.Collections.Generic;

namespace API.Models.Task
{
    public class TaskModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int AppId { get; set; }
        public List<int> ScreenId { get; set; }
        public string Description { get; set; }
    }
}