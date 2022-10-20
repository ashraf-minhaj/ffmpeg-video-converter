#! /bin/bash
exec >> logs 2>&1
# set -x

input_path=../media_res/video2.mp4
output_path=../converted/

# to log with date
dt=$(date)
printf "** New Execution $dt ___________________________________________________________\n"

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
echo "$input_path res= $input_res"

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

echo "Matched at index $indx"

# arr_len=${#ResList[@]}
# echo $arr_len

# delete larger resolution values from array
val=0
while [[ $val -lt $indx || $val -eq $indx ]];
do
    # echo "val is $val"
    unset ResList[$val]
    let val++
done


# now create output files for every other res
echo "need to convert for res: ${ResList[@]}"

for res in ${ResList[@]};
do
    echo "Converting $res"
    ffmpeg -y -i $input_path -vf scale=$res -preset slow -crf 18 $output_path/$res.mp4
done

printf "** Execution complete for $dt ____________________________________________\n\n"
