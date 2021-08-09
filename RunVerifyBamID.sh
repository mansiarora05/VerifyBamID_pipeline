##!/bin/bash
##SBATCH --job-name=RunVerifyBamID
##BATCH --nodes=1
##SBATCH --ntasks=1
##SBATCH --cpus-per-task=1
##BATCH --time=10:00:00


for i in /home/mansi/projects/rrg-vmooser/dtaliun/BQC19/Initial_Internal_QC_Release/cram/BQC*.sorted.dup.recal.cram; do
        file_name="${i##*/}"
        file="${file_name%.*}"
        sbatch --job-name=${file}_VerifyBamID --account=rrg-vmooser --nodes=1  --ntasks-per-node=1 --cpus-per-task=1 --mem-per-cpu=4000 --time=10:00:00 --wrap="/home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID.Linux.x86-64 --UDPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.UD --BedPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.bed --MeanPath /home/mansi/projects/rrg-vmooser/shared/tools/verifyBamID_2.0.1/VerifyBamID/resource/1000g.phase3.100k.b38.vcf.gz.dat.mu --Reference /lustre03/project/6060121/dtaliun/BCQ19/Reference/Homo_sapiens.GRCh38.fa --BamFile ${i} --Output ${file}.prefix"  -o slurm_${file}.log
done
