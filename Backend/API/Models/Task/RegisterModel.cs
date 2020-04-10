using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace API.Models.Task
{
    public class RegisterModel
    {
        [Required]
        public string Name { get; set; }
        [Required]
        public int AppId { get; set; }
        [Required]
        public List<int> ScreenId { get; set; }
        [Required]
        public string Description { get; set; }
        [Required]
        public string IssueUrl { get; set; }
    }
}