using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Google.Cloud.Firestore;
using Microsoft.AspNetCore.Mvc;

namespace Notes.Api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ApiKeysController : ControllerBase
    {
        private FirestoreDb _db;

        public ApiKeysController(FirestoreDb db)
        {
            _db = db;
        }

        [HttpGet]
        public async Task<IActionResult> GetNewAPIKey()
        {
            var notesRef = _db.Collection("users")
                .Document()
                .Collection("notes");

            await notesRef.AddAsync(new
            {
                NoteTitle = "Welcome",
                NoteContent = "This is a test note",
                CreateDateTime = DateTimeOffset.Now.ToString(),
                LatestEditDateTime = (string)null
            });

            await notesRef.AddAsync(new
            {
                NoteTitle = "Hello",
                NoteContent = "This is an another test note",
                CreateDateTime = DateTimeOffset.Now.ToString(),
                LatestEditDateTime = (string)null
            });

            await notesRef.AddAsync(new
            {
                NoteTitle = "And finally",
                NoteContent = "We have the third test note",
                CreateDateTime = DateTimeOffset.Now.ToString(),
                LatestEditDateTime = (string)null
            });

            return Ok();
        }
    }
}