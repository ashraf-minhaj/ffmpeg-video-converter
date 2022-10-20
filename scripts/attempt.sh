input_path=../media_res/video2.mp4
output_path=../converted/video1.mp4

# res array
declare -a ResList=("3840:2160" "1280:720" "640:480")
# declare -a HeightList=("2160" "720" "360")


# get input file resolution
# ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 $file_path
# input_res=$(ffprobe -v error -select_streams v:0 -show_entries \
#             stream=width,height -of csv=s=x:p=0 \
#             $input_path \
#         )

# get height and width seperately for using ';' delimeter
input_width=$(ffprobe -v error -select_streams v:0 -show_entries \
            stream=width -of csv=s=x:p=0 \
            $input_path \
        )

input_height=$(ffprobe -v error -select_streams v:0 -show_entries \
            stream=height -of csv=s=x:p=0 \
            $input_path \
            )

input_res="$input_width:$input_height"
echo $input_res

# iterate
for indx in ${!ResList[@]};
do  
    res=${ResList[indx]}
    # echo $indx $res

    if [ $res == $input_res ];
        then
            echo "Input $input_res matches with res $res"
            break
        else
            echo "Input $input_res does not with res $res"
    fi 
done

echo $indx
echo ${#ResList[@]}

# echo $(($indx+1))

# echo $((${#ResList[@]}+1))

while [ (($indx)) == ((${#ResList[@]})) ]
do
    echo less
done

# output
# ffmpeg -i $input_path -vf scale=$w:$h <encoding-parameters> $output_path