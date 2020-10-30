using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Google.Cloud.Firestore;
using Notes.Api.Models;

namespace Notes.Api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class NotesController : ControllerBase
    {
        private FirestoreDb _db;

        public NotesController(FirestoreDb db)
        {
            _db = db;
        }

        private CollectionReference GetNotesReference(string apiKey)
        {
            return _db.Collection("users")
                .Document(apiKey)
                .Collection("notes");
        }

        [HttpGet]
        public async Task<IActionResult> GetList([FromHeader] string apiKey)
        {
            var notesSnapshot = await GetNotesReference(apiKey).GetSnapshotAsync();
            return Ok(notesSnapshot.Documents
                .Select(document => document.ToDictionary())
                .ToList());
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get([FromHeader] string apiKey, string id)
        {
            var noteSnapshot = await GetNotesReference(apiKey)
                .Document(id)
                .GetSnapshotAsync();

            if (!noteSnapshot.Exists)
            {
                return NotFound();
            }

            return Ok(noteSnapshot.ToDictionary());
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromHeader] string apiKey, [FromBody] NoteManipulationDto noteManipulationDto)
        {
            var apiKeyRef = await _db.Collection("users").Document(apiKey).GetSnapshotAsync();
            if (!apiKeyRef.Exists)
            {
                return NotFound();
            }

            await GetNotesReference(apiKey)
                .Document()
                .SetAsync(new
                {
                    NoteTitle = noteManipulationDto.NoteTitle,
                    NoteContent = noteManipulationDto.NoteContent,
                    CreateDateTime = DateTimeOffset.Now.ToString(),
                    LatestEditDateTime = (string)null
                });

            return StatusCode(201);
        }
        
        
        [HttpPut("{noteid}")]
        public async Task<IActionResult> Update([FromHeader] string apiKey, string noteid, [FromBody] NoteManipulationDto noteManipulationDto)
        {
            var apiKeyRef = await _db.Collection("users").Document(apiKey).GetSnapshotAsync();
            if (!apiKeyRef.Exists)
            {
                return NotFound();
            }

            if (!(await GetNotesReference(apiKey).Document(apiKey).GetSnapshotAsync()).Exists)
            {
                return NotFound();
            }
            
            await GetNotesReference(apiKey)
                .Document(noteid)
                .SetAsync(new
                {
                    NoteTitle = noteManipulationDto.NoteTitle,
                    NoteContent = noteManipulationDto.NoteContent,
                    LatestEditDateTime = DateTimeOffset.Now.ToString(),

                }, SetOptions.MergeAll);

            return NoContent();
        }
        
        [HttpDelete("{noteid}")]
        public async Task<IActionResult> Delete(string noteid, [FromHeader] string apiKey)
        {
            var apiKeyRef = await _db.Collection("users").Document(apiKey).GetSnapshotAsync();
            if (!apiKeyRef.Exists)
            {
                return NotFound();
            }

            if (!(await GetNotesReference(apiKey).Document(apiKey).GetSnapshotAsync()).Exists)
            {
                return NotFound();
            }

            await GetNotesReference(apiKey)
                .Document(noteid)
                .DeleteAsync();

            return NoContent();
        }
    }
}