using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using API.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Identity;
using Microsoft.OpenApi.Models;

namespace API
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "App Planner API",
                    Version = "v1",
                    Description = "Dotnet core 3.1 Web API for the App Planner App",
                    Contact = new OpenApiContact
                    {
                        Name = "SW814F20",
                        Email = "SW814F20@cs.aau.dk",
                        Url = new Uri("https://github.com/SW814F20"),
                    },
                    License = new OpenApiLicense
                    {
                        Name = "GNU General Public License, version 2",
                        Url = new Uri("https://www.gnu.org/licenses/old-licenses/gpl-2.0.html"),
                    }
                });
            });
            services.AddDbContext<APIContext>(options =>
            options.UseNpgsql(Configuration.GetConnectionString("DefaultConnection"),
            options => options.SetPostgresVersion(new Version(9, 6))));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

            app.UseSwagger();

            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "App Planner API");
            });
        }
    }
}
