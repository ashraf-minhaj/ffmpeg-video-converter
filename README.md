# ffmpeg-video-converter
 Convert video files 

Auto detect and convert multiple file resolutions

1. Create an aws ec2 instance **ubuntu ami**
2. Update upgrade 
```
sudo apt-get update
sudo apt-get upgrade
```

3. Install **ffmpeg**
```
sudo apt-get install ffmpeg
```

4. create directories based on your needs
5. download sample video file from internet (rename/redirect also)
```
wget https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4 -O video2.mp4
```

6. now you can run the scripts

7. in case you want to rename files on the go
```
mv -u sample2.mp4 video2.mp4
```

8. connect from local machine via ssh

8.1. download ssh key pair

8.2. run this to ensure the key is not publicly viewable
```
chmod 400 mediaconverterkey.pem
```

8.3. connect -
```
ssh -i "key.pem" ubuntu@ip.region.compute.amazonaws.com
```

9. download file on local machine for testing 
```
scp -i "key.pem" ubuntu@ip.region.compute.amazonaws.com:mediaConverter/converted/h264_main_144p_3000.mp4 down.mp4
```

10. upload files to s3 automatically after job completion

10.1. Check if aws cli is installed
```
aws --version
```

`10.2. install aws cli if not found on 10.1 [aws doc](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
```
sudo apt-get install unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

10.3. Grant access using IAM role (recommended way)
Create and attach policy to a role -> ec2 service
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::bucket/*"
        }
    ]
}
```

Trusted entities will look like this -
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
```

10.4. Send files to s3 (cp to copy, mv to move)
```
aws s3 (cp/mv) file.txt s3://bucket/ --region us-east-1
```

11. Automate s3 move.
This creates a timestamp and moves the files into that path of s3.
run `bash media-transporter.sh s3_bucket_name`

#### to do
12. Job Queue [doc](https://hevodata.com/learn/python-sqs/#:~:text=To%20receive%20a%20message%20from,from%20your%20specified%20SQS%20Queue.&text=Parameters%3A,wish%20to%20send%20a%20message.)
13. s3 - sns
14. archive src