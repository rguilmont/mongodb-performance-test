#!/bin/sh

set -eu

echo "updating mongo url with user and password"
MONGO_URL=$(echo "$MONGO_URL" | sed "s/USERPASS_PLACEHOLDER/$MONGODB_USER:$MONGODB_PASSWORD/")

echo "running benchmark"
java -jar /app/mongodb-performance-test.jar -m INSERT -t 10 -d 30 --url "$MONGO_URL" -db "$MONGO_DB" -c "$MONGO_COLLECTION" -u "$MONGODB_USER" -p "$MONGODB_PASSWORD"
java -jar /app/mongodb-performance-test.jar -m UPDATE_ONE ITERATE_MANY -t 10 10 -d 30 --url "$MONGO_URL" -db "$MONGO_DB" -c "$MONGO_COLLECTION" -u "$MONGODB_USER" -p "$MONGODB_PASSWORD"

cd /app/
echo " === RESULTS === "
for result in $(ls *.csv); do
    echo "=== $result ==="
    cat $result
done
