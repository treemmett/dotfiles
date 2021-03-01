#!/bin/bash
# echo "$(nvidia-smi -q -x | grep gpu_util | sed -e 's/<gpu_util>//g' -e 's/ %<\/gpu_util>//g' -e 's/^[[:space:]]*//')"
#echo "$(nvidia-smi -q -x | grep gpu_temp | sed -e 's/<gpu_temp>//g' -e 's/%<\/gpu_temp>//g' -e 's/^[[:space:]]*//')"
#echo "$(nvidia-smi -q -x | grep gpu_temp | sed -e 's/<gpu_temp>//g' -e 's/<\/gpu_temp>//g' -e 's/^[[:space:]]*//')"
echo "$(nvidia-smi -q -x | grep \<gpu_temp\> | sed -e 's/<gpu_temp>//' -e 's/<\/gpu_temp>//' -e 's/^[[:space:]]*//')"
#echo 43C
