namespace API.Models
{
    public class App
    {
        public int Id { get; set; }

        public string AppName { get; set; }

        public string AppUrl { get; set; }

        public Group Owner { get; set; }
    }
}