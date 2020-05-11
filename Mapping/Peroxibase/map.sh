arrayid=$(($1+1))

#get r1 file path from job.conf and create r2 path
# from it
path_r1=$(sed "${arrayid}q;d" job.conf)
path_r2=$(echo $path_r1 | sed 's/__1/__2/')

sample_num=$(echo $path_r1 | cut -f4 -d "/")

bwa mem -M -t 36 ../../databases/Peroxibase/Peroxibase_combined.fa ${path_r1} ${path_r2} > ${sample_num}.sam

singularity exec /nfs/turbo/lsa-dudelabs/containers/Bioinformatics_Python3/checkm-bbtools.sif pileup.sh in=${sample_num}.sam out=${sample_num}.pileup

samtools view -S -b ${sample_num}.sam > ${sample_num}.bam
rm ${sample_num}.sam
