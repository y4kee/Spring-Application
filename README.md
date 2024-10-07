# Spring Boot Application with MySQL and Docker

## Overview
This project is a Spring Boot web application with MySQL as the database, containerized using Docker. The setup is automated to ensure smooth deployment and scalability.

## Prerequisites
Before running the project, ensure you have the following installed:

- **Java 17** or higher
- **Terraform**
- **Bash** (for executing shell scripts)

## Installation

### 1. Setup Docker and Docker Compose
After the server is launched via Terraform, you need to run the `installDocker.sh` script. This script will:
- Install Docker
- Install Docker Compose
- Assign all necessary permissions for Docker

_Note: After running the installDocker.sh script, execute the following command to set the necessary permissions on the Docker socket:_
<br>
`sudo chmod 666 /var/run/docker.sock`

### 2. Deploying Containers
Once Docker is installed and properly configured, deploy the application and its services by running the start-docker-compose.sh script:<br>
`bash start-docker-compose.sh`

### Accessing Jenkins
_After the containers are up, you can view the logs of the Jenkins container to obtain the initial admin password for Jenkins. Use the following command to view the Jenkins container logs:_

`docker logs <jenkins_container_id>`
(you can use `"docker ps"` command to watch containiers ids)

### 3. Jenkins Setup
#### 3.1 Log in to Jenkins:
Access Jenkins at _http://(your_ip):8080_  nd use the retrieved admin password to log in.

##### 3.2 Install Suggested Plugins:
After logging in, Jenkins will prompt you to install suggested plugins.
Follow the prompts to download and install these plugins.

#### 3.3 Create a User:
Once the plugins are installed, create a user account for Jenkins.

### 4 Adding GitHub Token
Go to Dashboard → Manage Jenkins → Credentials → Global → Add Credentials.
Choose Username with password.
Enter your GitHub username in the Username field.
Enter your GitHub token in the Password field.
#### Important!!!
In the ID field, enter "`git_token`". Without this ID, the setup will not work. You can provide any description in the Description field.

### 5 Running the Pipeline
After adding your GitHub token, follow these steps to set up and run the pipeline:

5.1 Go to Dashboard → New Item → enter a name → choose Pipeline.
5.2 Optionally, write a description for the pipeline.
5.3 Select GitHub project and enter the URL of your GitHub project.
5.4 Under Build Triggers, choose Poll SCM and enter * * * * * (Jenkins will check your repository every minute).
5.5 In Pipeline, select Pipeline script from SCM.
5.6 For SCM, choose Git.
5.7 In Repository URL, enter the URL of your repository.
5.8 In Credentials, select your token.
5.9 Change the branch from master to main.
5.10 Save the configuration.

## Congratulations!
Now After pushing updates to your GitHub repository, Jenkins will automatically update and restart the containers for the database and application.