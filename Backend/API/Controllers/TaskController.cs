using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using AutoMapper;
using API.Helpers;
using Microsoft.Extensions.Options;
using Microsoft.AspNetCore.Authorization;
using API.Services;
using API.Entities;
using API.Models.Task;

namespace API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class TaskController : ControllerBase
    {
        private ITaskService _taskService;
        private IMapper _mapper;
        private readonly AppSettings _appSettings;

        public TaskController(
            ITaskService taskService,
            IMapper mapper,
            IOptions<AppSettings> appSettings)
        {
            _taskService = taskService;
            _mapper = mapper;
            _appSettings = appSettings.Value;
        }

        /// <summary>
        /// Create a new task
        /// </summary>
        /// <param name="model"></param>
        /// <returns>HttpCode 200 if success or HttpCode 400 for BadRequest with exception message</returns>
        [HttpPost("Create")]
        public IActionResult Create([FromBody]RegisterModel model)
        {
            // map model to entity
            var task = _mapper.Map<Entities.Task>(model);

            // Try to create the task.
            try
            {
                _taskService.Create(task);
                return Ok(task);
            }
            // return error message if there was an exception
            catch (AppException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        /// <summary>
        /// Get All Screens in the system
        /// </summary>
        /// <returns>HttpCode 200 with a list of screens</returns>
        [HttpGet]
        public IActionResult GetAll()
        {
            var task = _taskService.GetAll();
            var model = _mapper.Map<IList<TaskModel>>(task);
            return Ok(model);
        }

        /// <summary>
        /// Get information about a specific screen based on the Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>HttpCode 200 with the screen model</returns>
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var task = _taskService.GetById(id);
            var model = _mapper.Map<TaskModel>(task);
            return Ok(model);
        }

        /// <summary>
        /// Update an existing screen with a new model.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="model"></param>
        /// <returns>HttpCode 200 for Success and HttpCode 400 for BadRequest</returns>
        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody]UpdateModel model)
        {
            // Map the model to the entity and set the id within that model.
            var task = _mapper.Map<Task>(model);
            task.Id = id;
            // Try to update the screen with the model passed from HttpPut
            try
            {
                _taskService.Update(task);
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
        /// Delete a screen based on their Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>HttpCode 200 for success</returns>
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            _taskService.Delete(id);
            return Ok();
        }
    }
}
