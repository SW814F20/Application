using AutoMapper;
using API.Entities;
using API.Models.User;
using API.Models.App;

namespace API.Helpers
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<Entities.User, Models.User.UserModel>();
            CreateMap<Models.User.RegisterModel, Entities.User>();
            CreateMap<Models.User.UpdateModel, Entities.User>();
            CreateMap<Entities.App, AppModel>();
            CreateMap<Models.App.RegisterModel, App>();
            CreateMap<Models.App.UpdateModel, Entities.App>();
        }
    }
}