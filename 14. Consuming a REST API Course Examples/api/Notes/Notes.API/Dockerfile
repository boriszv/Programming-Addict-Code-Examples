FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /

COPY /bin/Release/netcoreapp3.1/linux-x64/publish/* ./
ENV ASPNETCORE_ENVIRONMENT=Production
ENV PORT=80
ENV GOOGLE_APPLICATION_CREDENTIALS=permissions.json

ENTRYPOINT ["dotnet", "Notes.API.dll"]