using Notes.API.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API.Repositories
{
    public interface IApplicationRepository
    {
        Task<bool> Save();

        #region Notes

        Task<IEnumerable<Note>> GetNoteList(Guid apiKeyID);
        Task<Note> GetNote(Guid noteId, Guid apiKeyID);
        Task AddNote(Note note);
        void UpdateNote(Note note);
        Task RemoveNote(Guid noteId, Guid apiKeyID);
        Task<bool> NoteExists(Guid noteId, Guid apiKeyID);

        #endregion

        #region APIKey

        Task AddAPIKey(APIKey apiKey);
        Task<bool> APIKeyExists(Guid apiKeyID);
        
        #endregion
    }
}
