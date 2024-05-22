# Kong API Gateway Demo

This demo project demonstrates the usage of Kong API Gateway with multiple microservices.
## The project contains six services:
 
- Postgres (Kong): Database used by Kong in DB mode.
- Kong: API Gateway managing requests to the microservices.
- Reports Service: FastAPI-based microservice for reporting.
- Results Service: FastAPI-based microservice for results and requires auth
- Accounts Service: Django-based microservice for user registration and JWT management.
- Postgres (Accounts): Database used by the Accounts service

## Architecture

![Architecture Diagram](kong.jpg)


## Prerequisites
* Docker
* Docker Compose
* Kong Deck CLI

### Install Deck
```bash
brew tap kong/deck
brew install deck
```


## Project Structure
* config/: Kong configuration files.
* reports/: FastAPI-based report microservice.
* results/: FastAPI-based result microservice.
* accounts_service/: Django-based accounts service.


### Docker Setup
Each project contains its own Dockerfile for building the respective service containers. The project also contains a Docker Compose file for orchestrating the services.

## Setup
To use this demo, follow these steps:

Start Kong in DB mode with PostgreSQL:
```bash
make kong-postgres
```

Import the configurations:
```bash
make kong-import
```


## How to use?

### To access Kong admin
Go to http://localhost:8002/


### To Register user

```bash
curl -X POST -H "Content-Type: application/json" -d '{"email":"newuser@example.com", "password":"mysecretpassword"}' http://localhost:8000/api/auth/users/
```

### To login / Get token

```bash
curl -X POST -H "Content-Type: application/json" -d '{"email":"newuser@example.com", "password":"mysecretpassword"}' http://localhost:8000/api/auth/jwt/create/
```

### Make a get request to result service which requires auth

```bash
curl -H "Authorization: Bearer <your-token-goes-here>" http://localhost:8000/results/
```

### Make a get request to report service which doesn't requires auth

```bash
curl -X GET http://localhost:8000/reports/
```

## Kong Features
* JWT
* Proxy caching
* Request transformer
* Response transformer
* Request log
* Cors
* Ip restriction
* Rate limiting
* Request size limiting
* Lambda functions
* Log to file/http/Tcp
* Deck CLI
