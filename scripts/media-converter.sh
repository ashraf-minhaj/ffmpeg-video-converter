# ! /bin/bash
exec >> log_converter 2>&1
# set -x  # show commands before running
set -e   # exit on first error
started=`date +%s`

input_path=../media_res/video2.mp4
output_path=../converted/

# to log with date
dt=$(date)
printf "\n** New Execution $dt ___________________________________________________________\n"

# array of possible standard heights; order: top2bottom
declare -a HeightList=("2160" "1080" "720" "480" "360" "240" "144")


# get height of input video file
input_height=$(ffprobe -v error -select_streams v:0 -show_entries \
            stream=height -of csv=p=0 \
            $input_path \
            )

echo "Input= $input_path, height= $input_height"

# iterate and match
for indx in ${!HeightList[@]};
do  
    height=${HeightList[indx]}
    # echo $indx $height

    if [ $height == $input_height ];
        then
            echo "Input $input_height matches with height $height"
            break
        # else
        #     echo "Input $input_height does not with height $height"
    fi 
done

echo "Matched at index $indx"

# arr_len=${#HeightList[@]}
# echo $arr_len

printf "delete larger resolution values from array\n"
val=0
while [[ $val -lt $indx ]];
do
    echo "val is $val"
    unset HeightList[$val]
    # let val++              # error here
    val=$(expr $val + 1)
done


printf "create output files for every other height\n"
echo "Need to convert for height(s): ${HeightList[@]}"

for height in ${HeightList[@]};
do
    printf "\n* Converting for "$height"p \n"
    ffmpeg -i $input_path -c:a copy \
    -vf scale=-2:$height \
    -c:v libx264 -profile:v main -level:v 4.0 \
    -x264-params scenecut=0:open_gop=0:min-keyint=72:keyint=72 \
    -minrate 3000k -maxrate 3000k -bufsize 3000k -b:v 3000k \
    -y $output_path/h264_main_"$height"p_3000.mp4
    # ffmpeg -y -i $input_path -vf scale=-2:$height $output_path/$height.mp4 #basic
done

end=`date +%s`
duration=$(($end - $started))
printf "\nprocess took $duration seconds."
printf "\n** Execution complete for $dt ____________________________________________\n\n"
