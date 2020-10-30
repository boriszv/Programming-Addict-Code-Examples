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
        public async Task<IActionResult> GetList([FromHeader] Guid apiKey)
        {
            if (apiKey == Guid.Empty)
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

        [HttpGet("{noteid}")]
        public async Task<IActionResult> Get(Guid noteid, [FromHeader] Guid apiKey)
        {
            if (apiKey == Guid.Empty)
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
        public async Task<IActionResult> Post([FromBody] NoteInsertDTO data, [FromHeader] Guid apiKey)
        {
            if (apiKey == Guid.Empty)
            {
                return Unauthorized();
            }

            if (!await _repository.APIKeyExists(apiKey))
            {
                return NotFound();
            }

            var entity = _mapper.Map<Note>(data);
            entity.CreateDateTime = DateTimeOffset.Now;
            entity.APIKeyID = apiKey;

            await _repository.AddNote(entity);

            if (!await _repository.Save())
            {
                return StatusCode(500, "Creating note failed on save");
            }

            var result = _mapper.Map<NoteDTO>(entity);
            return CreatedAtAction(
                nameof(Get),
                new
                {
                    noteid = entity.NoteID
                },
                result);
        }

        [HttpPut("{noteid}")]
        public async Task<IActionResult> Put(Guid noteid, [FromBody] NoteUpdateDTO data, [FromHeader] Guid apiKey)
        {
            if (apiKey == Guid.Empty)
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

            _repository.UpdateNote(entity);

            if (!await _repository.Save())
            {
                return StatusCode(500, "Updating note failed on save");
            }

            return NoContent();
        }

        [HttpDelete("{noteid}")]
        public async Task<IActionResult> Delete(Guid noteid, [FromHeader] Guid apiKey)
        {
            if (apiKey == Guid.Empty)
            {
                return Unauthorized();
            }

            if (!await _repository.NoteExists(noteid, apiKey))
            {
                return NotFound();
            }

            await _repository.RemoveNote(noteid, apiKey);

            if (!await _repository.Save())
            {
                return StatusCode(500, "Deleting note failed on save");
            }

            return NoContent();
        }
    }
}
