#!/bin/bash

# Copy, unprack and install postgresql clietn to for database operations
echo $PWD && echo $(ls) && echo " before copying from S3"
aws s3 cp s3://${artifacts_bucket_name}/s3sync_2.26_Linux_x86_64.tar /usr/bin --region ${region}
echo $PWD && echo $(ls) && echo " before unpacking"
tar -xf s3sync_2.26_Linux_x86_64.tar.gz && rm s3sync_2.26_Linux_x86_64.tar.gz
