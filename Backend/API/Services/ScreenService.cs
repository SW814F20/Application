using System;
using System.Collections.Generic;
using System.Linq;
using API.Entities;
using API.Helpers;

namespace API.Services
{
    // ScreenService used by the ScreenController
    public class ScreenService : IScreenService
    {
        private DataContext _context;

        public ScreenService(DataContext context)
        {
            _context = context;
        }

        public IEnumerable<Screen> GetAll()
        {
            return _context.Screens;
        }

        public Screen GetById(int id)
        {
            return _context.Screens.Find(id);
        }

        public Screen Create(Screen screen)
        {
            // validation
            if (string.IsNullOrWhiteSpace(screen.ScreenContent))
                throw new AppException("Screen should contain some content");

            if (_context.Screens.Any(x => x.ScreenName == screen.ScreenName))
                throw new AppException("A screen with name \"" + screen.ScreenName + "\" already exists");

            _context.Screens.Add(screen);
            _context.SaveChanges();

            return screen;
        }

        public void Update(Screen screenParam)
        {
            var screen = _context.Screens.Find(screenParam.Id);

            if (screen == null)
                throw new AppException("Screen not found");

            // update screenName if it has changed
            if (!string.IsNullOrWhiteSpace(screenParam.ScreenName) && screenParam.ScreenName != screen.ScreenName)
            {
                // throw error if the new username is already taken
                if (_context.Screens.Any(x => x.ScreenName == screenParam.ScreenName))
                    throw new AppException("Screen with name " + screenParam.ScreenName + " already exists");

                screen.ScreenName = screenParam.ScreenName;
            }

            // update user properties if provided
            if (!string.IsNullOrWhiteSpace(screenParam.ScreenName))
                screen.ScreenName = screenParam.ScreenName;

            if (!string.IsNullOrWhiteSpace(screenParam.ScreenContent))
                screen.ScreenContent = screenParam.ScreenContent;

            _context.Screens.Update(screen);
            _context.SaveChanges();
        }

        public void Delete(int id)
        {
            var screen = _context.Screens.Find(id);
            if (screen != null)
            {
                _context.Screens.Remove(screen);
                _context.SaveChanges();
            }
        }
    }
}