##!/bin/bash
##SBATCH --job-name=create_vcf
##BATCH --nodes=1
##SBATCH --ntasks=1
##SBATCH --cpus-per-task=1
##BATCH --time=2:00:00

##module load bcftools


for i in {1..5}; do
	sbatch --job-name=${i}_VerifyBamID --account=rrg-vmooser --nodes=1 --wrap="/home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID.Linux.x86-64 --UDPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.UD --BedPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.bed --MeanPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.mu --Reference /lustre03/project/6060121/dtaliun/BCQ19/Reference/Homo_sapiens.GRCh38.fa --BamFile /lustre03/project/6060121/dtaliun/BCQ19/CRAM_test/BQC*.sorted.dup.recal.cram"  -o slurm__${i}.log
done


#./VerifyBamID.Linux.x86-64 --UDPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.UD --BedPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.bed --MeanPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.mu --Reference /lustre03/project/6060121/dtaliun/BCQ19/Reference/Homo_sapiens.GRCh38.fa --BamFile /lustre03/project/6060121/dtaliun/BCQ19/CRAM_test/BQC10037.sorted.dup.recal.cram