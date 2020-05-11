arrayid=$(($1+1))

#get r1 file path from job.conf and create r2 path
# from it
path_r1=$(sed "${arrayid}q;d" job.conf)
path_r2=$(echo $path_r1 | sed 's/R1/R2/')

sample_num=$(echo $path_r1 | cut -f8 -d "/")
ref="/nfs/turbo/seas-soils-turbo/zak/working/read_classification_filtering/ref/Refseq_bact_arch_vir_humn_univec/"

/nfs/turbo/seas-soils-turbo/zak/working/software/kraken2-2.0.8-beta/kraken2/kraken2 --db ${ref} --threads 36 --unclassified-out ${sample_num}_unclassified#.fastq --paired --output - $path_r1 $path_r2
