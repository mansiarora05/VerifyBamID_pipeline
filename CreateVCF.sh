

##!/bin/bash
##SBATCH --job-name=create_vcf
##BATCH --nodes=1
##SBATCH --ntasks=1
##SBATCH --cpus-per-task=1
##BATCH --time=2:00:00

##module load bcftools


for i in {1..22}; do
	sbatch --job-name=${i}_create_vcf --account=rrg-vmooser --nodes=1 --wrap="bcftools view -V indels -G -S /home/mansi/projects/rrg-vmooser/shared/1000G_GRCh38_30X/Samples/EUR.txt /home/mansi/projects/rrg-vmooser/shared/1000G_GRCh38_30X/VCFs/Cleaned/CCDG_13607_B01_GRM_WGS_2019-02-19_chr${i}.recalibrated_variants.PASS.cleaned.bcf | bcftools annotate -e AC=0 | bcftools annotate -x INFO/AF | bcftools view -o /home/mansi/projects/rrg-vmooser/mansi/CCDG_13607_B01_GRM_WGS_2019-02-19_chr${i}_UPDATED_test.vcf.gz -O z"  -o slurm_${i}.log
done


#bcftools view -V indels -G -S /home/mansi/projects/rrg-vmooser/shared/1000G_GRCh38_30X/Samples/EUR.txt /home/mansi/projects/rrg-vmooser/shared/1000G_GRCh38_30X/VCFs/Cleaned/CCDG_13607_B01_GRM_WGS_2019-02-19_chr10.recalibrated_variants.PASS.cleaned.bcf -o /home/mansi/projects/rrg-vmooser/mansi/CCDG_13607_B01_GRM_WGS_2019-02-19_chr10_UPDATED_test.vcf -O z
#bcftools annotate -e AC=0 /home/mansi/projects/rrg-vmooser/mansi/CCDG_13607_B01_GRM_WGS_2019-02-19_chr10_UPDATED_test.vcf | bcftools annotate -x INFO/AF
