#  NodeStat User Manager

**NodeStat User Manager** is a lightweight Node.js application for managing users and checking server status in real-time. It features a simple HTML frontend, REST API backend, and a MySQL database, all fully containerised with Docker. Infrastructure is provisioned using Terraform and deployed to AWS ECS, with optional database seeding using Lambda or ECS tasks.


![Image](https://github.com/user-attachments/assets/b08b4b82-2170-4f52-bfd6-011210ba5870)

## Features
- Fetch and display a list of users with a single click.
- Check the current status of your server in real time.
- Modern and clean UI for easy navigation.
- Fully containerised with Docker for seamless setup.
- MySQL database integration for robust data management.

## Tech Stack

- **Frontend**: Static HTML + native JavaScript
- **Backend**: Node.js + Express
- **Database**: Amazon RDS (MySQL)
- **Containerization**: Docker + docker-compose (for local)
- **Deployment**: ECS (Fargate), RDS, Lambda
- **Infrastructure**: Terraform (modularized)
- **Cloud Services**: AWS (ECS, RDS, Lambda, S3, Route53, ACM, IAM)




## Structure

```
.
├── app/
│   ├── index.html
│   ├── index.js
│   └── init.sql
├── lambda/
│   └── lambda_build/
│       ├── lambda_function.py
│       └── lambda.zip
├── terraform/
│   ├── backend.hcl
│   ├── main.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   ├── variables.tf
│   └── modules/
│       ├── acm/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── alb/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── ecs/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── iam/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── lambda/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   ├── variables.tf
│       │   └── init-users-final-test.sql
│       ├── rds/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── route53/
│       │   ├── main.tf
│       │   └── variables.tf
│       ├── s3/
│       │   └── main.tf
│       ├── security/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       └── vpc/
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
├── docker-compose.yml
├── Dockerfile
├── dockerfile.seeder
└── README.md

```



## Interact with the Application

Once the containers are running, the application will be available on `http://localhost:3000`.

### Access the HTML Frontend

Navigate to `http://localhost:3000` in your browser.

- **Check Status:** Sends a request to /api/status.
- **Get Users:** Sends a request to /api/users.

- ![demo of app ](https://github.com/user-attachments/assets/a6225c79-f35d-4661-ba18-c437f1e76e24)


### What Happens When the Buttons Are Pressed?

- **Check Status**: When the "Check Status" button is pressed, it triggers a request to the /api/status endpoint. The response is displayed on the page, indicating whether the application is running correctly.

- **Get Users**: When the "Get Users" button is pressed, it triggers a request to the /api/users endpoint. The response, which includes a list of users from the MySQL database, is displayed on the page.
-
<img width="885" alt="Screenshot 2024-10-06 at 14 44 56" src="https://github.com/user-attachments/assets/2b10ebbf-73b2-4507-89ce-d7bf9a99fbca">


## What's expected:

### 1. Functionality
The setup works as expected:
- **API Status Check:** The `/api/status` endpoint confirms the application is running.
- **User Retrieval:** The `/api/users` endpoint successfully retrieves and displays users from the MySQL database.
- **UI Functionality:** The web interface correctly shows users when the buttons "Fetch Users" or "Check Status & Show Users" are clicked.

### 2. Containerisation best Practices
The Docker setup follows best practices:
- **Separate Containers:** The Node.js application and MySQL database run in separate containers as defined in the `docker-compose.yml`.
- **Environment Variables:** Sensitive data is managed using environment variables in a `.env` file.
- **Optimised Dockerfile:** The Dockerfile is streamlined to ensure a small image size and quick build times.
- **Port Mapping:** The application is accessible via `http://localhost` with proper port mapping.
- **Volume Management:** Volume management is considered for potential data persistence.

### 3. Documentation
The setup is straightforward and easy to deploy:
- **Clear Instructions:** This README provides step-by-step instructions to build and run the application using Docker.
- **Simple Deployment:** `docker-compose` makes the deployment process simple with just a few commands.
- **Commented Code:** The codebase, including `Dockerfile` and `docker-compose.yml`, is well-commented for clarity.
