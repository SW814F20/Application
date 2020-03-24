using System.Collections.Generic;
using API.Entities;

namespace API.Services
{
    // Interface for the UserService
    public interface IAppService
    {
        IEnumerable<App> GetAll();
        App GetById(int id);
        App Create(App app);
        void Update(App app);
        void Delete(int id);
    }
}