using System.ComponentModel.DataAnnotations;

namespace API.Models.App
{
    public class RegisterModel
    {
        [Required]
        public string AppName { get; set; }

        [Required]
        public string AppUrl { get; set; }

        [Required]
        public string AppColor { get; set; }

    }
}