gcloud config set project thoughtquery
rm -rf bin/
dotnet publish -r linux-x64 -c Release --no-self-contained
rm -rf obj/
rm bin/Release/netcoreapp3.1/linux-x64/*
gcloud builds submit --tag gcr.io/thoughtquery/tq-notes-api