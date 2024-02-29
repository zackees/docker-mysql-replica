#!/bin/bash
# MySQL service start
service mysql start

# Wait for MySQL to fully start
echo "Waiting for MySQL to start..."
while ! mysqladmin ping -h"localhost" --silent; do
    sleep 1
done
echo "MySQL started."

# Attempt to connect to the master server to ensure settings are correct
echo "Checking connection to the master server..."
if mysql -h"$MYSQL_MASTER_HOST" -u"$MYSQL_REPLICA_USER" -p"$MYSQL_REPLICA_PASSWORD" -e "QUIT"
then
    echo "Successfully connected to the master server."
else
    echo "Failed to connect to the master server. Check the master host, replica user, and replica password."
    exit 1
fi

# Proceed with replication setup if the connection check is successful
if [ ! -f "/var/lib/mysql/replication_set" ]; then
    echo "Setting up replication..."
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CHANGE MASTER TO MASTER_HOST='$MYSQL_MASTER_HOST', MASTER_USER='$MYSQL_REPLICA_USER', MASTER_PASSWORD='$MYSQL_REPLICA_PASSWORD', MASTER_AUTO_POSITION=1; START SLAVE;"
    touch /var/lib/mysql/replication_set
else
    echo "Replication already set up."
fi

# Keep the container running
tail -f /dev/null
