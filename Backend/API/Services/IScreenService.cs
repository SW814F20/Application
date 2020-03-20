using System.Collections.Generic;
using API.Entities;

namespace API.Services
{
    // Interface for the UserService
    public interface IScreenService
    {
        IEnumerable<Screen> GetAll();
        Screen GetById(int id);
        Screen Create(Screen screen);
        void Update(Screen screen);
        void Delete(int id);
    }
}