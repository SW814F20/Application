namespace API.Models
{
    public class Group
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public App[] Applications { get; set; }
    }
}