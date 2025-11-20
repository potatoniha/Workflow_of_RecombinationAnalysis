bcftools query -l data_for_LD/CHM13-APGp1-HPRCp1-HGSVCp3_MC.vcf.gz > data_for_LD/all_samples.txt
shuf data_for_LD/all_samples.txt > data_for_LD/shuffled_samples.txt
split -l 100 -d -a 2 data_for_LD/shuffled_samples.txt group_

while read CHR; do
    for SAMPLE_FILE in group_*; do
        OUTPUT_VCF="${CHR}_${SAMPLE_FILE}.vcf.gz"
        bcftools view -S "${SAMPLE_FILE}" "data_for_LD/VCF_by_Chr/${CHR}/${CHR}.vcf.gz" -O z -o "data_for_LD/VCF_by_Chr/${CHR}/${OUTPUT_VCF}"
    done
done < "data_for_LD/Chr_List.txt"



