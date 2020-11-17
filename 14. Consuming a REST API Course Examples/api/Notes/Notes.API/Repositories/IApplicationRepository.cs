using Notes.API.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API.Repositories
{
    public interface IApplicationRepository
    {
        #region Notes

        Task<IEnumerable<Note>> GetNoteList(string apiKeyID);
        Task<Note> GetNote(string noteId, string apiKeyID);
        Task AddNote(Note note);
        Task UpdateNote(Note note);
        Task RemoveNote(string noteId, string apiKeyID);
        Task<bool> NoteExists(string noteId, string apiKeyID);

        #endregion

        #region APIKey

        Task AddAPIKey(APIKey apiKey);
        Task<bool> APIKeyExists(string apiKeyID);
        
        #endregion
    }
}
