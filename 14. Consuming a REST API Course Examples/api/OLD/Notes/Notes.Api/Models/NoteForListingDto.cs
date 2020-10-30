using System;

namespace Notes.Api.Models
{
    public class NoteForListingDto
    {
        public string NoteID { get; set; }

        public string NoteTitle { get; set; }

        public DateTimeOffset CreateDateTime { get; set; }

        public DateTimeOffset? LatestEditDateTime { get; set; }
    }
}