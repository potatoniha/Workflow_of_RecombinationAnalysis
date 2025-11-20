WINDOW=100000

while read CHR; do
    OUTPUT_DIR="data_for_LD/VCF_by_Chr/${CHR}"
    OUTPUT_FILE="${OUTPUT_DIR}/${CHR}_region.txt"
    INPUT_VCF="${OUTPUT_DIR}/${CHR}.vcf.gz"
    CHROM_LINE=$(bcftools view "$INPUT_VCF" | head -n 50 | grep "ID=${CHR}," | head -n 1)
    echo "$CHROM_LINE"
    CHROM_ID="${CHR}"
    CHROM_LENGTH=$(echo "$CHROM_LINE" | sed -n 's/.*length=\([^,>]*\).*/\1/p')
    echo "检测到染色体 ID: $CHROM_ID"
    echo "检测到染色体长度: $CHROM_LENGTH bp"
    echo "分段窗口大小: $WINDOW bp"
    echo "-----------------------------------"

    >"$OUTPUT_FILE"
    START_POS=1
    SEGMENT_COUNT=0
    while [ $START_POS -le $CHROM_LENGTH ]; do
        END_POS=$((START_POS + WINDOW_SIZE - 1))
        if [ $END_POS -gt $CHROM_LENGTH ]; then
            END_POS=$CHROM_LENGTH
        fi
        CURRENT_REGION="${CHROM_ID}:${START_POS}-${END_POS}"
        echo "$CURRENT_REGION" >> "$OUTPUT_FILE"
        SEGMENT_COUNT=$((SEGMENT_COUNT + 1))
        START_POS=$((START_POS + WINDOW_SIZE))
    done
    echo "--- 区域文件 ${OUTPUT_FILE} 已生成！共 ${SEGMENT_COUNT} 个片段。 ---"

done < "data_for_LD/Chr_List.txt"

while read CHR; do
    for SAMPLE_FILE in group_*; do
        INPUT_DIR="data_for_LD/VCF_by_Chr/${CHR}"    
        INPUT_VCF="${INPUT_DIR}/${CHR}_${SAMPLE_FILE}.vcf.gz"
        while read REGION; do
            OUTPUT_DIR="${INPUT_DIR}/${CHR}_${SAMPLE_FILE}"
            OUTPUT_FILE="${OUTPUT_DIR}/${REGION}_${SAMPLE_FILE}.vcf.gz"
            echo "提取区域: $REGION -> $OUTPUT_FILE"
            mkdir "${OUTPUT_DIR}"
            bcftools view -r "$REGION" "$INPUT_VCF" -o "$OUTPUT_FILE"
        done < "${INPUT_DIR}/${CHR}_region.txt"
    done
done < "data_for_LD/Chr_List.txt"










