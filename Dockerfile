# Use Debian Bullseye slim as the base image
FROM debian:bullseye-slim

# Set default environment variables
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_REPLICA_USER=replicauser
ENV MYSQL_REPLICA_PASSWORD=replicapassword
ENV MYSQL_MASTER_HOST=masterhost
ENV MYSQL_DATABASE=mydatabase

# Install MySQL server and other necessary packages
RUN apt-get update && \
    apt-get install -y mysql-server && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Set up the volume where MySQL data will be stored
VOLUME ["/var/lib/mysql"]

# Copy custom configuration and scripts
COPY my.cnf /etc/mysql/conf.d/my.cnf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the MySQL port
EXPOSE 3306

# Set the entrypoint script to initialize the database and replica
ENTRYPOINT ["/entrypoint.sh"]
