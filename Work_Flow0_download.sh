#!/bin/bash

INPUT_VCF="data_for_LD/CHM13-APGp1-HPRCp1-HGSVCp3_MC.vcf.gz"
OUTPUT_DIR="data_for_LD/VCF_by_Chr"
CHROM_LIST="data_for_LD/Chr_List.txt"

# create main output_dir
mkdir -p "$OUTPUT_DIR"

# process all chr
for CHR in $CHROM_LIST; do
    echo "Processing: $CHR"
    # make sub dir
    CHR_DIR="${OUTPUT_DIR}/${CHR}"
    mkdir -p "$CHR_DIR"

    OUTPUT_VCF="${CHR_DIR}/${CHR}.vcf.gz"

    # get all data
    bcftools view -r "$CHR" "INPUT_VCF" -O z -o "$OUTPUT_VCF"

    bcftools index "$OUTPUT_VCF"
