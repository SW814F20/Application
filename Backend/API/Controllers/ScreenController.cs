using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using AutoMapper;
using API.Helpers;
using Microsoft.Extensions.Options;
using Microsoft.AspNetCore.Authorization;
using API.Services;
using API.Entities;
using API.Models.Screen;

namespace API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class ScreenController : ControllerBase
    {
        private IScreenService _screenService;
        private IMapper _mapper;
        private readonly AppSettings _appSettings;

        public ScreenController(
            IScreenService screenService,
            IMapper mapper,
            IOptions<AppSettings> appSettings)
        {
            _screenService = screenService;
            _mapper = mapper;
            _appSettings = appSettings.Value;
        }

        /// <summary>
        /// Create a new app
        /// </summary>
        /// <param name="model"></param>
        /// <returns>HttpCode 200 if success or HttpCode 400 for BadRequest with exception message</returns>
        [HttpPost("Create")]
        public IActionResult Create([FromBody]RegisterModel model)
        {
            // map model to entity
            var screen = _mapper.Map<Entities.Screen>(model);

            // Try to create the app.
            try
            {
                _screenService.Create(screen);
                return Ok(screen);
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
            var screen = _screenService.GetAll();
            var model = _mapper.Map<IList<ScreenModel>>(screen);
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
            var screen = _screenService.GetById(id);
            var model = _mapper.Map<ScreenModel>(screen);
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
            var screen = _mapper.Map<Screen>(model);
            screen.Id = id;
            // Try to update the app with the model passed from HttpPut
            try
            {
                _screenService.Update(screen);
                return Ok();
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
            _screenService.Delete(id);
            return Ok();
        }
    }
}
