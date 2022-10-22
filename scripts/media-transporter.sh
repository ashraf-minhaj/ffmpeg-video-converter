# ! /bin/bash
exec >> log_transporter 2>&1
# set -x  # show commands before running
set -e   # exit on first error

echo "arg: $1"
bucket="$1"

cd ../
dt=$(date)
# mkdir "$dt"
# mv -v converted/* "$dt"
aws s3 mv converted/ s3://"$bucket"/"$dt" --recursive --region ap-south-1
# rm -r "$dt"