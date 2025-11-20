# Workflow_of_RecombinationAnalysis
program you need to carry out:
1. LDhat/convert
2. LDhat/lkgen
3. LDhat/rhomap
4. vcftools
5. bcftools
___
**WorkFlow0_download**
Input: 
1. Chr_List: the list of all contig, which can be found in vcf ID column
2. INPUT_VCF: the total vcf file of your program

Output:
1. OUTPUT_VCF: the vcf file divided by chrom
This Program can make the vcf divided by the chrom.
The Chr_List is not necessary, because you can get it directly in vcf ID, but it is recommended.
___
**WorkFlow1_randomdivide**
Input:
1. INPUT_VCF: the total vcf file of your program

Output:
1. all_samples: all the query in INPUT_VCF
2. group_*: the random division by shuf
3. OUTPUT_VCF: the chrom vcf file divided by group file

It is not necessary if your vcf has query less than 320. You can make a likelihood in **WorkFlow2.5_lkgenerate**. Because the biggest likelihood I have only is n=320, the likelihood generation velocity is low.
___
**WorkFlow1.5_dividewindow**
Input:
1. WINDOW: the length of each query you want
2. INPUT_VCF_1: the vcf file divided by chrom
3. INPUT_VCF_2: the vcf file divided by chrom and group

Output: 
1. region: the chr:window text used to generate a smaller vcf
2. OUTPUT_VCF: smaller vcf

It is unnecessary if you have a short enough seq or you have a good cpu
You can get a smaller sequence.
___
**WorkFlow2_getSitesLocs**
Input: 
1. Chr_List: the list of all contig, which can be found in vcf ID column
2. Region: the chr:window text used to generate a smaller vcf
3. INPUT_VCF:

Output:
1. sites.txt
2. locs.txt

Generate sites and locs which can be used in later analysis.












