arrayid=$(($1+1))

#get r1 file path from job.conf and create r2 path
# from it
path_r1=$(sed "${arrayid}q;d" job.conf)

sample_num=$(echo $path_r1 | cut -f4 -d "/" | cut -f1 -d ".")

~/Software/diamond blastx --threads 36 --evalue .0001 --K 5 --sensitive --db /scratch/vdenef_root/vdenef/jtevans/peter/databases/cazy/CAZy --out ${sample_num}.m8 --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore nident mismatch qcovhsp scovhsp --header --query ${path_r1}

