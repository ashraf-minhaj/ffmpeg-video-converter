input_path=../media_res/video1.mp4

#get input file resolution
# ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 $file_path
input_res=$(ffprobe -v error -select_streams v:0 -show_entries \
            stream=width,height -of csv=s=x:p=0 \
            $input_path \
        )
echo $input_res

IFS='x'

# split
read -a starr << $input_res

echo "${starr[0]}"

echo sit