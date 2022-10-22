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
8.1 download ssh key pair
8.1 run this to ensure the key is not publicly viewable
```
chmod 400 mediaconverterkey.pem
```
8.2 connect -
```
ssh -i "key.pem" ubuntu@ip.region.compute.amazonaws.com
```

9. download file on local machine for testing 
```
scp -i "key.pem" ubuntu@ip.region.compute.amazonaws.com:mediaConverter/converted/h264_main_144p_3000.mp4 down.mp4
```

#### to do
10. upload files to s3 automatically after job completion
11. s3 - sns