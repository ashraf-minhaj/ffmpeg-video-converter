# ! /bin/bash
exec >> log_getter 2>&1
# set -x  # show commands before running
set -e   # exit on first error

object="s3://---/men_matter.mp4"

cd ../
echo "getting object $object"
aws s3 cp $object ./media_res/video3.mp4
echo "download complete"