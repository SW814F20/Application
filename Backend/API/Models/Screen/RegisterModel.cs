using System.ComponentModel.DataAnnotations;

namespace API.Models.Screen
{
    public class RegisterModel
    {
        [Required]
        public string ScreenName { get; set; }

        [Required]
        public string ScreenContent { get; set; }
    }
}