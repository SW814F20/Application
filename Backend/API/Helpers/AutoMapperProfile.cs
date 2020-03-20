using AutoMapper;
using API.Entities;
using API.Models.User;
using API.Models.App;
using API.Models.Screen;

namespace API.Helpers
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            // User mappings
            CreateMap<Entities.User, Models.User.UserModel>();
            CreateMap<Models.User.RegisterModel, Entities.User>();
            CreateMap<Models.User.UpdateModel, Entities.User>();
            // App mappings
            CreateMap<Entities.App, AppModel>();
            CreateMap<Models.App.RegisterModel, App>();
            CreateMap<Models.App.UpdateModel, Entities.App>();
            // Screen mappings
            CreateMap<Entities.Screen, ScreenModel>();
            CreateMap<Models.Screen.RegisterModel, Screen>();
            CreateMap<Models.Screen.UpdateModel, Entities.Screen>();
        }
    }
}