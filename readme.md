#  NodeStat User Manager

**NodeStat User Manager** is a lightweight Node.js application designed to manage users and monitor server status in real time.

It features a clean frontend, RESTful API, and MySQL backend all fully containerised with Docker and deployed to AWS using a **modular Terraform** setup. While the app is simple by design, it’s backed by a **production-grade cloud architecture**, including automated database seeding via Lambda, secure secret injection  and plans for CI/CD integration.

 ![demo of app ](https://github.com/user-attachments/assets/7ffc0012-59f6-4fb9-9e53-bd6bfa213f0a)


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
- **Containerisation**: Docker + docker-compose (for local)
- **Deployment**: ECS (Fargate), RDS, Lambda
- **Infrastructure**: Terraform (modularised)
- **Cloud Services**: AWS (ECS, RDS, Lambda, S3, Route53, ACM, IAM)

## Architecture diagram

![Image](https://github.com/user-attachments/assets/b47290a2-3ccd-45d4-b8b5-569594ed3570)

<sub>The diagram shows how the app runs on AWS: frontend + API on ECS (Fargate), MySQL on RDS, with Lambda auto-seeding via S3. All infrastructure is managed using modular Terraform.</sub>
<br>


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

<br>

> [!IMPORTANT] <br>
> **CloudWatch Logs** provided full-stack observability, from S3 event triggers to Lambda execution to ECS task behavior. <br>
> Logs also confirmed environment variables and secrets were being injected correctly, and made silent failures (like missing IAM permissions) visible and actionable.

---


## Interact with the Application

<img width="563" alt="Image" src="https://github.com/user-attachments/assets/bcf429b7-bd80-4a89-98e2-7a409f7d5865" />

The application is publicly accessible at:

https://users.yzeynab.com

This domain is configured using Amazon Route 53 and served securely via an HTTPS-enabled Application Load Balancer with an AWS ACM certificate.

### What Happens When the Buttons Are Pressed?

- **Check Status**: When the "Check Status" button is pressed, it triggers a request to the /api/status endpoint. The response is displayed on the page, indicating whether the application is running correctly.

- **Get Users**: When the "Get Users" button is pressed, it triggers a request to the /api/users endpoint. The response, which includes a list of users from the MySQL database, is displayed on the page.
<img width="885" alt="Screenshot 2024-10-06 at 14 44 56" src="https://github.com/user-attachments/assets/2b10ebbf-73b2-4507-89ce-d7bf9a99fbca">


## "Error Fetching Users"

During initial testing, the frontend returned an `"Error fetching users"` message when attempting to retrieve data from the `/api/users` endpoint:

![Image](https://github.com/user-attachments/assets/51a37501-3c6f-42e0-9134-316d16123007)

This error occurred because the database was successfully provisioned, but had not yet been seeded — the `users` table didn't exist, resulting in a backend failure when queried.



### How It Was Resolved

To fix this, I simply seeded the database by uploading a SQL file to the project's configured S3 bucket. This is part of the infrastructure's serverless automation pipeline:

```bash
aws s3 cp ./init-users.sql s3://your-s3-bucket/init-users.sql
```
---
## Conclusion

NodeStat User Manager started as a simple app,   but this version is the result of a **full architectural revamp**.

I took the opportunity to restructure the project around real-world cloud patterns: containerised the backend, modularised the Terraform setup, integrated secure credential management and automated database seeding using serverless triggers.

Every service,from ECS to Lambda to RDS was configured to follow **best practices**.

This isn't just a working demo, it's a scalable, production-ready foundation **built with real infrastructure experience**.
