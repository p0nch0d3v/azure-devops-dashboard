# Define variables
$envFile = '.env.docker'
$imageName = 'azure-devops-dashboard:dev'
$containerName = 'azure-devops-dashboard-dev'

# Stop and remove the container if it exists
docker container stop $containerName
docker container rm $containerName

# Remove the Docker image if it exists
docker image rm $imageName

# Build the Docker image
docker build `
    --progress plain `
    --no-cache `
    --tag $imageName `
    --debug `
    .

# Check if the .env.docker file exists and load environment variables
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^\s*([^=]+)=(.*)') {
            $key = $matches[1]
            $value = $matches[2]
            [Environment]::SetEnvironmentVariable($key, $value)
        }
    }
    Get-Content $envFile
}

# Run the Docker container
docker run `
    --rm `
    --publish 5678:80 `
    --env MODE=$env:MODE `
    --env NODE_ENV=$env:NODE_ENV `
    --name $containerName `
    $imageName