using System.Collections.Generic;
using System.Linq;
using API.Entities;
using API.Helpers;

namespace API.Services
{
    // ScreenService used by the TaskController
    public class TaskService : ITaskService
    {
        private DataContext _context;

        public TaskService(DataContext context)
        {
            _context = context;
        }

        public IEnumerable<Task> GetAll()
        {
            return _context.Tasks;
        }

        public Task GetById(int id)
        {
            return _context.Tasks.Find(id);
        }

        public Task Create(Task task)
        {
            // validation
            if (string.IsNullOrWhiteSpace(task.Name))
                throw new AppException("Task name is not allowed to be empty");
            if (string.IsNullOrWhiteSpace(task.Description))
                throw new AppException("Task description is not allowed to be empty");
            if (_context.Tasks.Any(t => t.Name == task.Name) && _context.Apps.Any(a => a.Id == task.AppId))
                throw new AppException("A task with name \"" + task.Name + "\" already exists for this app");

            _context.Tasks.Add(task);
            _context.SaveChanges();

            return task;
        }

        public void Update(Task taskParam)
        {
            var task = _context.Tasks.Find(taskParam.Id);

            if (task == null)
                throw new AppException("Task not found");

            // update taskName if it has changed
            if (!string.IsNullOrWhiteSpace(taskParam.Name) && taskParam.Name != task.Name)
            {
                // throw error if the new taskName is already taken for a given app
                if (_context.Tasks.Any(x => x.Name == taskParam.Name))
                    throw new AppException("A task with name \"" + task.Name + "\" already exists for this app");

                task.Name = taskParam.Name;
            }

            // Update ScreenId if any is provided in parameter
            if (taskParam.ScreenId.Any())
            {
                // Foreach id check if they exists in the database
                taskParam.ScreenId.ForEach(delegate (int id)
                {
                    if (!_context.Screens.Any(s => s.Id == id))
                    {
                        // Throws exception if screen with id was not found.
                        throw new AppException("Screen with id \"" + id + "\" was not found");
                    }
                });
                // If no errors occurred then update task with new Screen ids
                task.ScreenId = taskParam.ScreenId;
            }

            // Update task description if it is provided within the parameter
            if (!string.IsNullOrWhiteSpace(taskParam.Description))
                task.Description = taskParam.Description;

            _context.Tasks.Update(task);
            _context.SaveChanges();
        }

        public void Delete(int id)
        {
            var task = _context.Tasks.Find(id);
            if (task != null)
            {
                _context.Tasks.Remove(task);
                _context.SaveChanges();
            }
        }
    }
}