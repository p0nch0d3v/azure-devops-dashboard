# Azure DevOps Dashboard

This solution extends Azure DevOps capabilities to offer advanced tools for end-to-end project management, including story tracking, and board organization.

## Key feature:
- Provides cross-project Kanban boards, allowing users to visualize work across multiple status in a single view.

## How to run it locally
- Prerequisites
    - 1. `.NET 8` -> [Get it](https://dotnet.microsoft.com/en-us/download/dotnet/8.0).
    - 2. `Node v22 (LTS)` -> [Get it](https://nodejs.org/download/release/latest-v22.x/).
    - 3. `Docker` **OPTIONAL** [Get it](https://docs.docker.com/get-started/get-docker/).

- Due to Azure DevOps work with Micorosft login,it needs to be configured
    - 1. Locate the file `AzureDevOpsDashboard.Web/ClientApp/.env` and clone it into `.env.local`.
    - 2. Change the values of `NG_APP_PUBLIC_ORGANIZATION` and `NG_APP_PUBLIC_CLIENT_ID` keys correspondingly in the cloned file `.env.local`.
    - 3. On the folder `AzureDevOpsDashboard.Web/ClientApp` execute the node packages installation command, e.g. `npm install --legacy-peer-deps`.
    - 4. Run the `.NET` project, on the folder `AzureDevOpsDashboard.Web`,e.g. `dotnet run`.

- Alternatively you can run it using `Docker`
    - 1. Locate the file `.env.docker.template` and clone it into `.env.docker`.
    - 2. Change the values of `NG_APP_PUBLIC_ORGANIZATION` and `NG_APP_PUBLIC_CLIENT_ID` keys correspondingly in the cloned file `.env.docker`.
    - 3. Execute the command:
        - a. `test_docker_local.sh`, if you are running bash/zsh or similar *nix shell.
        - b. `test_docker_local.ps1`, if you are running `Powershell` on `Windows`.
