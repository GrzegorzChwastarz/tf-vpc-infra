#!/bin/bash
pwd
# Install postgresql
amazon-linux-extras install postgresql10 -y
pwd
# Create given number of files
pwd && echo " before making dir s3"
mkdir ./dummy_files && cd dummy_files
pwd && echo "before creating files"
for i in {1..${number_of_files}}; do dd if=/dev/urandom bs=1 count=1 of=file$i; done
pwd && echo " before uplod to s3"
# Upload files to legecy bucket
aws s3 sync . s3://${legacy_bucket_name}/image --region ${region}
pwd && echo " waiting for db"
# In case Aurora instance won't spin up on time
aws rds wait \
    db-instance-available \
    --db-instance-identifier ${db_instance_id} \
    --region ${db_region}
echo $pwd && echo " before call to db"
# Create table and fill it with random s3 paths
psql postgresql://${db_username}:${db_password}@${db_endpoint_url}:5432/${db_name} << EOF
  CREATE TABLE IF NOT EXISTS avatars (
  id SERIAL PRIMARY KEY,
  path VARCHAR
);

INSERT INTO avatars(id,path)
SELECT generate_series(1,${number_of_db_records}) AS id, CONCAT('/image/avatar-',md5(RANDOM()::TEXT),'.png') AS path;
EOF
