#!/bin/bash
# Start MySQL service
service mysql start

# Wait for MySQL to start up
echo "Waiting for MySQL to start..."
while ! mysqladmin ping -h"localhost" --silent; do
    sleep 1
done
echo "MySQL started."

# Setting up the MySQL Replication
if [ ! -f "/var/lib/mysql/replication_set" ]; then
    echo "Setting up replication..."
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CHANGE MASTER TO MASTER_HOST='$MYSQL_MASTER_HOST', MASTER_USER='$MYSQL_REPLICA_USER', MASTER_PASSWORD='$MYSQL_REPLICA_PASSWORD', MASTER_AUTO_POSITION=1; START SLAVE;"
    touch /var/lib/mysql/replication_set
fi

# Keep the container running
tail -f /dev/null
