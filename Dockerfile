FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG NG_APP_PUBLIC_ORGANIZATION=''
ARG NG_APP_PUBLIC_CLIENT_ID=''

ENV NG_APP_PUBLIC_ORGANIZATION=${NG_APP_PUBLIC_ORGANIZATION}
ENV NG_APP_PUBLIC_CLIENT_ID=${NG_APP_PUBLIC_CLIENT_ID}
ENV ENV_FILE_PATH=/app/AzureDevOpsDashboard.Web/ClientApp/.env

WORKDIR /app

# Install node
RUN apt update -yq && apt upgrade -yq
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash -
RUN apt install -yq nodejs

# Copy everything
COPY . ./

# Set environment variables for build
RUN > $ENV_FILE_PATH
RUN echo "NG_APP_PUBLIC_ORGANIZATION=${NG_APP_PUBLIC_ORGANIZATION}" >> ${ENV_FILE_PATH}
RUN echo "NG_APP_PUBLIC_CLIENT_ID=${NG_APP_PUBLIC_CLIENT_ID}" >> ${ENV_FILE_PATH}
RUN cat ${ENV_FILE_PATH}

# Restore as distinct layers
RUN dotnet restore

# Build
RUN dotnet build

# Build and publish a release
RUN dotnet publish -o out

# RUN ls -la /app/out/wwwroot/azure-dashboard

# Copy the build to corresponding folder
RUN cp -r /app/out/wwwroot/azure-dashboard/*.* /app/out/wwwroot/

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
ENV ASPNETCORE_HTTP_PORTS=80
ENV ASPNETCORE_URLS=http://*:80
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "AzureDevOpsDashboard.Web.dll"]
