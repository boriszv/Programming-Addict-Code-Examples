using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Notes.API.Models.DTOs;
using Notes.API.Models.Entities;
using Notes.API.Repositories;

namespace Notes.API.Controllers
{
    [Route("notes")]
    [ApiController]
    public class NotesController : ControllerBase
    {
        private readonly IApplicationRepository _repository;
        private readonly IMapper _mapper;

        public NotesController(IApplicationRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> GetList([FromHeader] string apiKey)
        {
            if (string.IsNullOrWhiteSpace(apiKey))
            {
                return Unauthorized();
            }

            if (!await _repository.APIKeyExists(apiKey))
            {
                return NotFound();
            }

            var entities = await _repository.GetNoteList(apiKey);

            var result = _mapper.Map<List<NoteListDTO>>(entities);
            return Ok(result);
        }

        [HttpGet("{noteid}", Name = "Get")]
        public async Task<IActionResult> Get(string noteid, [FromHeader] string apiKey)
        {
            if (string.IsNullOrWhiteSpace(apiKey))
            {
                return Unauthorized();
            }

            var entity = await _repository.GetNote(noteid, apiKey);
            if (entity == null)
            {
                return NotFound();
            }

            var result = _mapper.Map<NoteDTO>(entity);
            return Ok(result);
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] NoteInsertDTO data, [FromHeader] string apiKey)
        {
            if (string.IsNullOrWhiteSpace(apiKey))
            {
                return Unauthorized();
            }

            if (!await _repository.APIKeyExists(apiKey))
            {
                return NotFound();
            }

            var entity = _mapper.Map<Note>(data);

            entity.NoteID = Guid.NewGuid().ToString();
            entity.CreateDateTime = DateTimeOffset.Now;
            entity.APIKeyID = apiKey;

            await _repository.AddNote(entity);

            var result = _mapper.Map<NoteDTO>(entity);
            return StatusCode(201, result);
        }

        [HttpPut("{noteid}")]
        public async Task<IActionResult> Put(string noteid, [FromBody] NoteUpdateDTO data, [FromHeader] string apiKey)
        {
            if (apiKey == null)
            {
                return Unauthorized();
            }

            var entity = await _repository.GetNote(noteid, apiKey);
            if (entity == null)
            {
                return NotFound();
            }

            _mapper.Map(data, entity);

            entity.LatestEditDateTime = DateTime.Now;

            await _repository.UpdateNote(entity);
            return NoContent();
        }

        [HttpDelete("{noteid}")]
        public async Task<IActionResult> Delete(string noteid, [FromHeader] string apiKey)
        {
            if (string.IsNullOrWhiteSpace(apiKey))
            {
                return Unauthorized();
            }

            if (!await _repository.NoteExists(noteid, apiKey))
            {
                return NotFound();
            }

            await _repository.RemoveNote(noteid, apiKey);
            return NoContent();
        }
    }
}
