# Peters_Pipeline
workflow for steps taken to generate readcount data

# Workflow
1. Quality Control of Reads
    - Reads were trimmed using bbduk from bbtools https://jgi.doe.gov/data-and-tools/bbtools/
        - adapters were trimmed
        - quality trimmed at Q20
        - and a min length of 40 bp
    - Reads were then inspected with fastqc (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and multiqc (https://multiqc.info/)
2. Filtering of Reads
    - This was done with Kraken2 https://ccb.jhu.edu/software/kraken2/
        - A kraken database was created using all refseq genomes for bacteria, archea, and viruses, the human genome, Univec, and Quercus Rubra.
        - Krakenw was run in paired end mode with default parameters and only reads not mapping to anything in the database were kept.
3. Mapping of Reads
    - Reads were mapped to the peroxibase database using bwa http://bio-bwa.sourceforge.net/
        - mappign was done with bwa mem using default parameters
        - the resulting bam files were parsed into pileup files from bam files using bbmap (pileup.sh)
        - a gene count matrix combining all samples was created using a custom script
    - Reads were aligned to CAZY and the single copy genes database using diamond https://www.ncbi.nlm.nih.gov/pubmed/25402007
        - diamond was run on each of the paired reads using the parameters --evalue .0001 --K 5 --sensitive
        - 2 gene count matrices was made combining all sample read counts (one for each database) using a custom script
   NOTE: gene counts are an avaerage of the number of forward reads and reverse reads for both strategies.
   
   
