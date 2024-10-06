# User Management and Status Check App

Welcome to the **User Management and Status Check App**! This project is a simple, intuitive way to manage users and monitor server status, built with Node.js, Docker, and MySQL.

## Features
- Fetch and display a list of users with a single click.
- Check the current status of your server in real time.
- Modern and clean UI for easy navigation.
- Fully containerized with Docker for seamless setup.
- MySQL database integration for robust data management.

## Demo

Check out the app in action:
https://github.com/user-attachments/assets/d2e63ae9-5dc6-4e17-9094-e658f504162e


## Interact with the Application

Once the containers are running, the application will be available on `http://localhost:80`.

### Access the HTML Frontend

Navigate to `http://localhost:80` in your browser.

- **Check Status:** Sends a request to /api/status.
- **Get Users:** Sends a request to /api/users.


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

