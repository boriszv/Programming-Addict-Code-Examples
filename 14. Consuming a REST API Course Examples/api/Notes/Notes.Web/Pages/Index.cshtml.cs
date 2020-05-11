using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json.Linq;

namespace Notes.Web.Pages
{
    public class IndexModel : PageModel
    {
        public string APIKey { get; set; }

        public string BasePath { get; set; }

        public IndexModel(IConfiguration configuration)
        {
            BasePath = configuration.GetValue<string>("BasePath");
        }

        public async Task OnGet()
        {
            using (var client = new HttpClient())
            {
                var result = await client.GetStringAsync("http://www.programmingaddict.com/notes-api/apiKey");
                var json = JObject.Parse(result);
                APIKey = json["apiKey"].ToString();
            }
        }
    }
}
