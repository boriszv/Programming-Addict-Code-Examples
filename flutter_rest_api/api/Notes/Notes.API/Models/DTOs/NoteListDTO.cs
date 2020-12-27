using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API.Models.DTOs
{
    public class NoteListDTO
    {
        public string NoteID { get; set; }

        public string NoteTitle { get; set; }

        public DateTimeOffset CreateDateTime { get; set; }

        public DateTimeOffset? LatestEditDateTime { get; set; }
    }
}
