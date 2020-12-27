using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Google.Cloud.Firestore;
using Microsoft.EntityFrameworkCore;
using Notes.API.Models.Entities;

namespace Notes.API.Repositories
{
    public class ApplicationRepository : IApplicationRepository
    {
        private readonly FirestoreDb _db;

        public ApplicationRepository(FirestoreDb db)
        {
            _db = db;
        }

        public async Task<IEnumerable<Note>> GetNoteList(string apiKeyID)
        {
            var notesSnapshot = await _db.Collection("apiKeys")
                .Document(apiKeyID)
                .Collection("notes")
                .GetSnapshotAsync();

            return notesSnapshot.Documents.Select(x =>
            {
                var note = Note.FromDictionary(x.ToDictionary());
                note.NoteID = x.Id;
                note.APIKeyID = apiKeyID;

                return note;
            }).ToList();
        }

        public async Task<Note> GetNote(string noteId, string apiKeyID)
        {
            var noteSnapshot = await _db.Collection("apiKeys")
                .Document(apiKeyID)
                .Collection("notes")
                .Document(noteId)
                .GetSnapshotAsync();

            if (!noteSnapshot.Exists)
            {
                return null;
            }

            var note = Note.FromDictionary(noteSnapshot.ToDictionary());
            note.NoteID = noteSnapshot.Id;
            note.APIKeyID = apiKeyID;

            return note;
        }

        public async Task AddNote(Note note)
        {
            await _db.Collection("apiKeys")
                .Document(note.APIKeyID)
                .Collection("notes")
                .Document(note.NoteID)
                .SetAsync(note.ToDictionary());
        }

        public async Task UpdateNote(Note note)
        {
            await _db.Collection("apiKeys")
                .Document(note.APIKeyID)
                .Collection("notes")
                .Document(note.NoteID)
                .SetAsync(note.ToDictionary());
        }

        public async Task RemoveNote(string noteId, string apiKeyID)
        {
            await _db.Collection("apiKeys")
                .Document(apiKeyID)
                .Collection("notes")
                .Document(noteId)
                .DeleteAsync();
        }

        public async Task<bool> NoteExists(string noteId, string apiKeyID)
        {
            var snapshot = await _db.Collection("apiKeys")
                .Document(apiKeyID)
                .Collection("notes")
                .Document(noteId)
                .GetSnapshotAsync();

            return snapshot.Exists;
        }

        public async Task AddAPIKey(APIKey apiKey)
        {
            var apiKeyQuery = _db.Collection("apiKeys").Document(apiKey.ID);
            await apiKeyQuery.CreateAsync(new Dictionary<string, object>());

            var notesQuery = apiKeyQuery.Collection("notes");

            var tasks = apiKey.Notes
                .Select(x => notesQuery.Document().SetAsync(x.ToDictionary()))
                .ToList();

            await Task.WhenAll(tasks);
        }

        public async Task<bool> APIKeyExists(string apiKeyID)
        {
            return (await _db.Collection("apiKeys")
                .Document(apiKeyID)
                .GetSnapshotAsync())
                .Exists;
        }
    }
}
