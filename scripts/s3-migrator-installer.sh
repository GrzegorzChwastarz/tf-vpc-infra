#!/bin/bash

echo "Copy, unprack and install postgresql client to for database operations"
aws s3 cp s3://${artifacts_bucket_name}/s3sync_2.26_Linux_x86_64.tar /usr/bin --region ${region}
cd bin && tar -xf s3sync_2.26_Linux_x86_64.tar && rm s3sync_2.26_Linux_x86_64.tar
