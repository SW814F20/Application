using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using AutoMapper;
using API.Helpers;
using Microsoft.Extensions.Options;
using Microsoft.AspNetCore.Authorization;
using API.Services;
using API.Entities;
using API.Models.App;

namespace API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class AppController : ControllerBase
    {
        private IAppService _appService;
        private IMapper _mapper;
        private readonly AppSettings _appSettings;

        public AppController(
            IAppService appService,
            IMapper mapper,
            IOptions<AppSettings> appSettings)
        {
            _appService = appService;
            _mapper = mapper;
            _appSettings = appSettings.Value;
        }

        /// <summary>
        /// Create a new app
        /// </summary>
        /// <param name="model"></param>
        /// <returns>HttpCode 200 if success or HttpCode 400 for BadRequest with exception message</returns>
        [HttpPost("Create")]
        public IActionResult Register([FromBody]RegisterModel model)
        {
            // map model to entity
            var app = _mapper.Map<Entities.App>(model);

            // Try to create the app.
            try
            {
                _appService.Create(app);
                return Ok(app);
            }
            // return error message if there was an exception
            catch (AppException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        /// <summary>
        /// Get All Apps in the system
        /// </summary>
        /// <returns>HttpCode 200 with a list of apps</returns>
        [HttpGet]
        public IActionResult GetAll()
        {
            var app = _appService.GetAll();
            var model = _mapper.Map<IList<AppModel>>(app);
            return Ok(model);
        }

        /// <summary>
        /// Get information about a specific app based on the Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>HttpCode 200 with the app model</returns>
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var app = _appService.GetById(id);
            var model = _mapper.Map<AppModel>(app);
            return Ok(model);
        }

        /// <summary>
        /// Update an existing user with a new model.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="model"></param>
        /// <returns>HttpCode 200 for Success and HttpCode 400 for BadRequest</returns>
        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody]UpdateModel model)
        {
            // Map the model to the entity and set the id within that model.
            var app = _mapper.Map<App>(model);
            app.Id = id;
            // Try to update the app with the model passed from HttpPut
            try
            {
                _appService.Update(app);
                return Ok(app);
            }
            // Catch the exception and return a HttpBadRequest with the same message.
            catch (AppException ex)
            {
                // return error message if there was an exception
                return BadRequest(new { message = ex.Message });
            }
        }

        /// <summary>
        /// Delete a user based on their Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>HttpCode 200 for success</returns>
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            _appService.Delete(id);
            return Ok();
        }
    }
}
