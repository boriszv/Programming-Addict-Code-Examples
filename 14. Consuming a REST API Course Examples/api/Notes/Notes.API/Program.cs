using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace Notes.API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args)
        {
            return Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    string port = Environment.GetEnvironmentVariable("PORT") ?? "5000";
                    string url;
                    if (port != "5070")
                    {
                        url = String.Concat("http://0.0.0.0:", port);
                    }
                    else
                    {
                        url = "http://localhost:5070";
                    }
                    webBuilder.UseStartup<Startup>().UseUrls(url);
                });
        }
    }
}
