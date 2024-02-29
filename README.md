# MySQL Read Replica Docker Setup

This repository contains the necessary files to set up a MySQL read replica using Docker and Docker Compose based on Debian Bullseye slim. This setup is intended for development and testing environments. Please ensure you follow security best practices when adapting for production use.

## Prerequisites

Before starting, ensure you have the following installed:
- Docker
- Docker Compose

## Configuration

Before deploying the replica, you should configure the environment variables to match your MySQL master server and replica settings. You can do this in the `docker-compose.yml` file or by setting environment variables in your shell.

Variables include:
- `MYSQL_ROOT_PASSWORD`: The root password for your MySQL instance.
- `MYSQL_REPLICA_USER`: The username for the replication user on the master.
- `MYSQL_REPLICA_PASSWORD`: The password for the replication user.
- `MYSQL_MASTER_HOST`: The hostname or IP address of the master MySQL server.
- `MYSQL_DATABASE`: The database to replicate.

Additionally, you may want to customize the `my.cnf` file for your specific MySQL configuration needs.

## Deployment

To deploy the MySQL read replica, follow these steps:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/mysql-replica-docker.git
   cd mysql-replica-docker
