using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API.Models.DTOs
{
    public class NoteDTO
    {
        public Guid NoteID { get; set; }

        public string NoteTitle { get; set; }

        public string NoteContent { get; set; }

        public DateTimeOffset CreateDateTime { get; set; }

        public DateTimeOffset? LatestEditDateTime { get; set; }
    }
}
