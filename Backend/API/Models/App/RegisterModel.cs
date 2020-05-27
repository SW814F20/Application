using System.ComponentModel.DataAnnotations;

namespace API.Models.App
{
    public class RegisterModel
    {
        [Required]
        public string AppName { get; set; }

        [Required]
        public string Repository { get; set; }
        public string User { get; set; }

        [Required]
        public string AppColor { get; set; }

    }
}