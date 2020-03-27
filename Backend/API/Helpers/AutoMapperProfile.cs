using AutoMapper;
using API.Entities;
using API.Models.User;
using API.Models.App;
using API.Models.Screen;
using API.Models.Task;

namespace API.Helpers
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            // User mappings
            CreateMap<User, UserModel>();
            CreateMap<Models.User.RegisterModel, User>();
            CreateMap<Models.User.UpdateModel, User>();
            // App mappings
            CreateMap<App, AppModel>();
            CreateMap<Models.App.RegisterModel, App>();
            CreateMap<Models.App.UpdateModel, App>();
            CreateMap<Models.App.AppModel, App>();
            // Screen mappings
            CreateMap<Screen, ScreenModel>();
            CreateMap<Models.Screen.ScreenModel, Screen>();
            CreateMap<Models.Screen.RegisterModel, Screen>();
            CreateMap<Models.Screen.UpdateModel, Screen>();
            // Task mappings
            CreateMap<Task, TaskModel>();
            CreateMap<Models.Task.RegisterModel, Task>();
            CreateMap<Models.Task.UpdateModel, Task>();
        }
    }
}