using AutoMapper;
using Notes.API.Models.DTOs;
using Notes.API.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Notes.API
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            #region Notes

            CreateMap<Note, NoteListDTO>();
            CreateMap<Note, NoteDTO>();
            CreateMap<NoteInsertDTO, Note>();
            CreateMap<NoteUpdateDTO, Note>();

            #endregion

            #region APIKey

            CreateMap<APIKey, APIKeyDTO>()
                .ForMember(a => a.ApiKey, opt => opt.MapFrom(a => a.ID));

            #endregion
        }
    }
}
