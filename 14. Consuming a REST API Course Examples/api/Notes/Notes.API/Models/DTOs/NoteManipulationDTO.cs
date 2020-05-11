using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API.Models.DTOs
{
    public class NoteManipulationDTO
    {
        public string NoteTitle { get; set; }

        public string NoteContent { get; set; }
    }
}
