import glob
import pandas

COUNT_DICT = dict()
BLAST_TABLES = glob.glob("cazy/*m8")
CUTOFF = float("1e-4")
for table in BLAST_TABLES:
    sample = table.split("/")[1].split(".")[0]
    with open(table) as reader:
        for line in reader:
            if not line.startswith("#"):
                split_line = line.split("\t")
                gene = split_line[1]
                evalue = float(split_line[10])
                if evalue < CUTOFF:
                    if sample in COUNT_DICT:
                        curr_dict = COUNT_DICT[sample]
                        if gene in curr_dict:
                            curr_dict[gene] += 1
                        else:
                            curr_dict[gene] = 1
                    else:
                        COUNT_DICT[sample] = dict() 
                        curr_dict = COUNT_DICT[sample]
                        curr_dict[gene] = 1

df = pandas.DataFrame.from_dict(COUNT_DICT,orient='index')
df = df/2

df.to_csv("cazy_read_counts_k5_sensitive.csv")
