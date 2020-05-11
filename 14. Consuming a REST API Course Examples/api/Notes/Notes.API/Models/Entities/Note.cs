using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API.Models.Entities
{
    [Table(nameof(Note))]
    public class Note
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid NoteID { get; set; }

        [Required]
        [StringLength(50)]
        public string NoteTitle { get; set; }

        [Required]
        [StringLength(3000)]
        public string NoteContent { get; set; }

        [Required]
        public DateTimeOffset CreateDateTime { get; set; }

        public DateTimeOffset? LatestEditDateTime { get; set; }

        [Required]
        [ForeignKey(nameof(APIKey))]
        public Guid APIKeyID { get; set; }

        public APIKey APIKey { get; set; }
    }
}
