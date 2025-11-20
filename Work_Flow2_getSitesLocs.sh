#!/bin/bash
CHROM_LIST="data_for_LD/Chr_List.txt"
OUTPUT_DIR="LD_Analysis"

while read CHR; do
    OUTPUT_PATH_1="${OUTPUT_DIR}/${CHR}"
    mkdir "${OUTPUT_PATH_1}"
    for SAMPLE_FILE in group_*; do
        while read REGION; do
            OUTPUT_PATH_2="${OUTPUT_DIR}/${CHR}/${REGION}_${SAMPLE_FILE}"
            mkdir "${OUTPUT_PATH_2}"
            vcftools --ldhat --gzvcf "data_for_LD/VCF_by_Chr/${CHR}/${CHR}_${SAMPLE_FILE}/${REGION}_${SAMPLE_FILE}.vcf.gz" --chr "${CHR}" --out "${REGION}_${SAMPLE_FILE}"
            echo "${REGION} ${SAMPLE_FILE} .sites & .locs's construction succeed"
            tools/convert -seq "${REGION}_${SAMPLE_FILE}.ldhat.sites"
            echo "${REGION} ${SAMPLE_FILE} sites.txt & locs.txt's construction succeed"
            mv sites.txt "${OUTPUT_PATH_2}"
            mv locs.txt "${OUTPUT_PATH_2}"
            rm "${REGION}_${SAMPLE_FILE}"*
        done < "data_for_LD/VCF_by_Chr/${CHR}/${CHR}_region.txt"
    done
done < "${CHROM_LIST}"
