using System.Collections.Generic;
using System.Linq;
using API.Entities;
using API.Helpers;

namespace API.Services
{
    // UserService used by the UserController
    public class AppService : IAppService
    {
        private DataContext _context;

        public AppService(DataContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All Aps
        /// </summary>
        /// <returns>List of all apps</returns>
        public IEnumerable<App> GetAll()
        {
            return _context.Apps;
        }

        public App GetById(int id)
        {
            return _context.Apps.Find(id);
        }
        /// <summary>
        /// Create a new App
        /// </summary>
        /// <param name="app"></param>
        /// <returns>HttpCode 200 on success</returns>
        public App Create(App app)
        {
            // validation
            if (string.IsNullOrWhiteSpace(app.AppName))
                throw new AppException("The AppName is required");
            if (string.IsNullOrWhiteSpace(app.AppUrl))
                throw new AppException("The AppUrl is required");

            if (_context.Apps.Any(x => x.AppName == app.AppName))
                throw new AppException("An app with name \"" + app.AppName + "\" already exists");
            if (_context.Apps.Any(x => x.AppUrl == app.AppUrl))
                throw new AppException("An app with url \"" + app.AppUrl + "\" already exists");

            _context.Apps.Add(app);
            _context.SaveChanges();

            return app;
        }
        /// <summary>
        /// Update existing app with new information
        /// </summary>
        /// <param name="appParam"></param>
        public void Update(App appParam)
        {
            var app = _context.Apps.Find(appParam.Id);

            if (app == null)
                throw new AppException("App not found");

            // update AppName if it has changed
            if (!string.IsNullOrWhiteSpace(app.AppName) && appParam.AppName != app.AppName)
            {
                // throw error if the new AppName is already taken
                if (_context.Apps.Any(x => x.AppName == appParam.AppName))
                    throw new AppException("AppName " + appParam.AppName + " already exists");

                app.AppName = appParam.AppName;
            }

            _context.Apps.Update(app);
            _context.SaveChanges();
        }
        /// <summary>
        /// Delete an App based on the Id
        /// </summary>
        /// <param name="id"></param>
        public void Delete(int id)
        {
            var app = _context.Apps.Find(id);
            if (app != null)
            {
                _context.Apps.Remove(app);
                _context.SaveChanges();
            }
        }
    }
}
