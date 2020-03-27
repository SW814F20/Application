using System.Collections.Generic;

namespace API.Models.Task
{
    public class UpdateModel
    {
        public string Name { get; set; }
        public List<int> ScreenId { get; set; }
        public string Description { get; set; }
    }
}