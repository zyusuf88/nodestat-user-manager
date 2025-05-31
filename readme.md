#  NodeStat User Manager

**NodeStat User Manager** is a lightweight Node.js application designed to manage users and monitor server status in real time.

It features a clean frontend, RESTful API, and MySQL backend all fully containerised with Docker and deployed to AWS using a **modular Terraform** setup. While the app is simple by design, it’s backed by a **production-grade cloud architecture**, including automated database seeding via Lambda, secure secret injection  and plans for CI/CD integration.


- ![demo of app ](https://github.com/user-attachments/assets/a6225c79-f35d-4661-ba18-c437f1e76e24)

## Features
- Fetch and display a list of users with a single click.
- Check the current status of your server in real time.
- Modern and clean UI for easy navigation.
- Fully containerised with Docker for seamless setup.
- MySQL database integration for robust data management.

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

## Tech Stack

- **Frontend**: Static HTML + native JavaScript
- **Backend**: Node.js + Express
- **Database**: Amazon RDS (MySQL)
- **Containerization**: Docker + docker-compose (for local)
- **Deployment**: ECS (Fargate), RDS, Lambda
- **Infrastructure**: Terraform (modularized)
- **Cloud Services**: AWS (ECS, RDS, Lambda, S3, Route53, ACM, IAM)

- The app is deployed  locally then Dockerised and pushed to Amazon ECR (Elastic Container Registry).
- From there, it is deployed to Amazon ECS (Fargate) as part of a scalable service.
- Terraform was used to provision and configure all AWS resources, including:
    - VPC, subnets, routing, NAT gatewayand internet gatewayECS cluster and services
    - secrets Manager for securely injecting DB credentials
    -  S3 bucket for SQL seed file uploads
    - Lambda function triggered on S3 init-*.sql uploads to seed the database
    - Application Load Balancer (ALB) with HTTPS (via ACM)
    - Domain setup via Route 53 with alias record targeting the ALB
- Deployment is fully automated using CI/CD pipelines via GitHub Actions (to be integrated).

## Data Seeding Process
- Upload any file matching the pattern init-*.sql to the configured S3 bucket.
- This triggers a Lambda function which connects to Amazon RDS and executes the SQL statements.
- Once seeded, users are instantly available in the frontend app.

## Lambda Seeding: Design & Flow

The application includes an optional automated database initialisation pipeline using AWS Lambda and S3.

###  Workflow

1. A `.sql` seed file is uploaded to a designated S3 bucket.
2. The upload event triggers a Lambda function via an S3 event notification.
3. The Lambda function downloads the SQL file and establishes a secure connection to the RDS MySQL instance (using credentials securely injected via environment variables or AWS Secrets Manager).
4. The Lambda executes the SQL commands against the RDS database to seed or reset data.

> [! IMPORTANT]
> CloudWatch Logs provided full-stack observability, from S3 event triggers to Lambda execution to ECS task behavior. <br>
> CloudWatch also helped validate that ECS tasks were running correctly, environment variables were being passed as expected and application errors were surfaced in real time.


## Interact with the Application

<img width="601" alt="Image" src="https://github.com/user-attachments/assets/670b1461-6cc1-47c2-a88a-3b78d14ce694" />

The application is publicly accessible at:

https://coder.yzeynab.com

This domain is configured using Amazon Route 53 and served securely via an HTTPS-enabled Application Load Balancer with an AWS ACM certificate.

### What Happens When the Buttons Are Pressed?

- **Check Status**: When the "Check Status" button is pressed, it triggers a request to the /api/status endpoint. The response is displayed on the page, indicating whether the application is running correctly.

- **Get Users**: When the "Get Users" button is pressed, it triggers a request to the /api/users endpoint. The response, which includes a list of users from the MySQL database, is displayed on the page.
-
<img width="885" alt="Screenshot 2024-10-06 at 14 44 56" src="https://github.com/user-attachments/assets/2b10ebbf-73b2-4507-89ce-d7bf9a99fbca">

## Conclusion

NodeStat User Manager started as a simple app,   but this version is the result of a **full architectural revamp**.

I took the opportunity to restructure the project around real-world cloud patterns: containerised the backend, modularised the Terraform setup, integrated secure credential management and automated database seeding using serverless triggers.

Every service,from ECS to Lambda to RDS was configured to follow **best practices**.

This isn't just a working demo, it's a scalable, production-ready foundation **built with real infrastructure experience**.
