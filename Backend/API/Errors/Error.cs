namespace API.Errors
{
    public class Error
    {
        public int StatusCode { get; private set; }

        public string StatusDescription { get; private set; }

        public string Message { get; private set; }

        public Error(int statusCode, string statusDescription)
        {
            this.StatusCode = statusCode;
            this.StatusDescription = statusDescription;
        }

        public Error(int statusCode, string statusDescription, string message)
            : this(statusCode, statusDescription) => this.Message = message;
    }
}