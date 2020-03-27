using System.Collections.Generic;
using API.Entities;

namespace API.Services
{
    // Interface for the TaskService
    public interface ITaskService
    {
        IEnumerable<Task> GetAll();
        Task GetById(int id);
        Task Create(Task task);
        void Update(Task Task);
        void Delete(int id);
    }
}