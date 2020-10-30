using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Notes.API.Models.Entities;

namespace Notes.API.Repositories
{
    public class ApplicationRepository : IApplicationRepository
    {
        private readonly ApplicationDbContext _db;

        public ApplicationRepository(ApplicationDbContext db)
        {
            _db = db;
        }

        public async Task<bool> Save()
        {
            return (await _db.SaveChangesAsync()) > 0;
        }

        public async Task<IEnumerable<Note>> GetNoteList(Guid apiKeyID)
        {
            return await _db.Notes
                .Where(n => n.APIKeyID == apiKeyID)
                .ToListAsync();
        }

        public async Task<Note> GetNote(Guid noteId, Guid apiKeyID)
        {
            return await _db.Notes
                .Where(n => n.NoteID == noteId && n.APIKeyID == apiKeyID)
                .FirstOrDefaultAsync();
        }

        public async Task AddNote(Note note)
        {
            await _db.Notes.AddAsync(note);
        }

        public void UpdateNote(Note note)
        {
            _db.Notes.Update(note);
        }

        public async Task RemoveNote(Guid noteId, Guid apiKeyID)
        {
            var note = await GetNote(noteId, apiKeyID);
            _db.Notes.Remove(note);
        }

        public async Task<bool> NoteExists(Guid noteId, Guid apiKeyID)
        {
            return await _db.Notes
                .Where(n => n.NoteID == noteId && n.APIKeyID == apiKeyID)
                .AnyAsync();
        }

        public async Task AddAPIKey(APIKey apiKey)
        {
            await _db.APIKeys.AddAsync(apiKey);
        }

        public async Task<bool> APIKeyExists(Guid apiKeyID)
        {
            return await _db.APIKeys
                .Where(a => a.ID == apiKeyID)
                .AnyAsync();
        }
    }
}
