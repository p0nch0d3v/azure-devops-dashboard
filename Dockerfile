FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Install node
RUN apt update -yq && apt upgrade -yq
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash -
RUN apt install -yq nodejs

# Copy everything
COPY . ./

# Restore as distinct layers
RUN dotnet restore

# Build
RUN dotnet build

# Build and publish a release
RUN dotnet publish -o out

# Copy the build to corresponding folder
RUN cp -r /app/out/wwwroot/azure-dashboard/browser/*.* /app/out/wwwroot/

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
ENV ASPNETCORE_HTTP_PORTS=80
ENV ASPNETCORE_URLS=http://*:80
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "AzureDevOpsDashboard.Web.dll"]
