using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Notes.API.Models.DTOs;
using Notes.API.Models.Entities;
using Notes.API.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API.Controllers
{
    [Route("apiKey")]
    [ApiController]
    public class APIKeyController : ControllerBase
    {
        private readonly IApplicationRepository _repository;
        private readonly IMapper _mapper;

        public APIKeyController(IApplicationRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> GetNewAPIKey()
        {
            var entity = new APIKey
            {
                Notes = new List<Note>
                {
                    new Note
                    {
                        NoteTitle = "Welcome",
                        NoteContent = "This is a test note",
                        CreateDateTime = DateTime.Now
                    },
                    new Note
                    {
                        NoteTitle = "Hello",
                        NoteContent = "This is an another test note",
                        CreateDateTime = DateTime.Now
                    },
                    new Note
                    {
                        NoteTitle = "And finally",
                        NoteContent = "We have the third test note",
                        CreateDateTime = DateTime.Now
                    },
                }
            };

            await _repository.AddAPIKey(entity);

            if (!await _repository.Save())
            {
                return StatusCode(500, "Creating APIKey failed on save");
            }

            var result = _mapper.Map<APIKeyDTO>(entity);
            return Ok(result);
        }
    }
}
