arrayid=$(($1+1))

#get r1 file path from job.conf and create r2 path
# from it
path_r1=$(sed "${arrayid}q;d" job.conf)
path_r2=$(echo $path_r1 | sed 's/R1/R2/')
#trim all teh extra stuff in the name down to just sample
# number
sampleNum=$(echo $path_r1 | cut -f3 -d "/")
echo $sampleNum
#create a directory for the sample in the working
# directory
mkdir $sampleNum
#determine adapters
singularity exec ../container/Omics_Container.sif bbmerge.sh in1=${path_r1} in2=${path_r2} outa=${sampleNum}/adapters.fa reads=1m
#trim and put trimmed files in working directory
singularity exec ../container/Omics_Container.sif bbduk.sh in1=$path_r1 in2=$path_r2 out1=${sampleNum}/${sampleNum}_R1_trimmed.fastq  out2=${sampleNum}/${sampleNum}_R2_trimmed.fastq  ref=${sampleNum}/adapters.fa stats=${sampleNum}/trim_stats.sh ktrim=r k=23 mink=11 hdist=1 tpe tbo
#Run fastqc on trimmed reads
cd $sampleNum
singularity exec ../../container/Omics_Container.sif fastqc *.fastq
