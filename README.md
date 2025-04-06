# Azure DevOps Dashboard

This solution enhance Azure DevOps with advanced project management tools, including cross-project Kanban boards and streamlined story tracking.

## Key features:

### Unified Kanban Boards
> Visualize work items across multiple projects and statuses in a single view.

### End-to-End Workflow Management
> Track stories, tasks, and dependencies seamlessly within your organization.


## How to run it locally
- Prerequisites
    - 1. `.NET 8` -> [Get it](https://dotnet.microsoft.com/en-us/download/dotnet/8.0).
    - 2. `Node v22 (LTS)` -> [Get it](https://nodejs.org/download/release/latest-v22.x/).
    - 3. `Docker` **OPTIONAL** [Get it](https://docs.docker.com/get-started/get-docker/).

- Due to Azure DevOps work with Microsoft login,it needs to be configured
    - 1. Navigate to the folder `AzureDevOpsDashboard.Web/ClientApp` and copy `.env` to `.env.local`.
    - 2. Update the keys in `.env.local`:
        ```
        NG_APP_PUBLIC_ORGANIZATION=
        NG_APP_PUBLIC_CLIENT_ID=
        ```
    - 3. Navigate to the folder `AzureDevOpsDashboard.Web/ClientApp`, install the dependencies with the following command:
        ```
        npm install --legacy-peer-deps
        ```
    - 4. Run the `.NET` project, navigate to the folder `AzureDevOpsDashboard.Web`, and execute the following command:
        ```
        dotnet run
        ```

- Alternatively you can run it using `Docker`
    - 1. Navigate to the root folder `/` and copy `.env.docker.template` to `.env.docker`.
    - 2. Update the keys in `.env.docker`:
        ```
        NG_APP_PUBLIC_ORGANIZATION=
        NG_APP_PUBLIC_CLIENT_ID=
        ```
    - 3. Execute the command:
        - a. Linux/MacOs
        ```bash
        ./test_docker_local.sh
        ```
        - b. Windows
        ```powershell
        .\test_docker_local.ps1
        ```
