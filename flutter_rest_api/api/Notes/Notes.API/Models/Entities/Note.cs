using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Formatters;

namespace Notes.API.Models.Entities
{
    public class Note
    {
        public string NoteID { get; set; }

        public string NoteTitle { get; set; }

        public string NoteContent { get; set; }

        public DateTimeOffset CreateDateTime { get; set; }

        public DateTimeOffset? LatestEditDateTime { get; set; }

        public string APIKeyID { get; set; }

        public static Note FromDictionary(Dictionary<string, object> dictionary)
        {
            return new Note
            {
                NoteTitle = dictionary["noteTitle"] as string,
                CreateDateTime = ParseNullableDateString(dictionary["createDateTime"]) ?? DateTimeOffset.Now,
                LatestEditDateTime = ParseNullableDateString(dictionary["latestEditDateTime"]),
                NoteContent = dictionary["noteContent"] as string,
            };
        }

        public Dictionary<string, object> ToDictionary()
        {
            return new Dictionary<string, object>
            {
                {"noteTitle", NoteTitle},
                {"createDateTime", CreateDateTime.ToString()},
                {"latestEditDateTime", LatestEditDateTime.ToString()},
                {"noteContent", NoteContent},
            };
        }

        private static DateTimeOffset? ParseNullableDateString(object dateTimeString)
        {
            if (!(dateTimeString is string) || (string) dateTimeString == "")
            {
                return null;
            }

            return DateTimeOffset.Parse((string) dateTimeString);
        }
    }
}
