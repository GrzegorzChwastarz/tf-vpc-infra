#!/bin/bash

echo "Install postgresql"
amazon-linux-extras install postgresql10 -y

echo "Create given number of files locally"
mkdir ./dummy_files && cd dummy_files
for i in {1..${number_of_files}}; do dd if=/dev/urandom bs=1 count=1 of=file$i; done

echo "Upload files as a content of legecy bucket"
s3sync -tr ${region} . s3://${legacy_bucket_name}/image/

echo "Wait In case Aurora instance won't spin up on time"
aws rds wait \
    db-instance-available \
    --db-instance-identifier ${db_instance_id} \
    --region ${region}

echo "Create table and fill it with random s3 paths that can act as legacy entries"
psql postgresql://${db_username}:${db_password}@${db_endpoint_url}:5432/${db_name} << EOF
  CREATE TABLE IF NOT EXISTS avatars (
  id SERIAL PRIMARY KEY,
  path VARCHAR
);

INSERT INTO avatars(id,path)
SELECT generate_series(1,${number_of_db_records}) AS id, CONCAT('/image/avatar-',md5(RANDOM()::TEXT),'.png') AS path;
EOF
