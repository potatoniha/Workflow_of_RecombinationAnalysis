#!/bin/bash
OUTPUT_DIR="LD_Analysis"

while read CHR; do
    for SAMPLE_FILE in group_*; do
        OUTPUT_PATH_2="${OUTPUT_DIR}/${CHR}/${CHR}_${SAMPLE_FILE}"
        tools/rhomap -seq "${OUTPUT_PATH_2}/sites.txt" -loc "${OUTPUT_PATH_2}/locs.txt" -lk "tools/new_lk.txt" -exact -its 150000 -burn 100000 -samp 1000 -prefix "${CHR}_${SAMPLE_FILE}"
        echo "${CHR} ${SAMPLE_FILE}'s rhomap construct"
    done
done < "data_for_LD/Chr_List.txt"




