# Usage Rscript --vanilla path/to/skeleton_primer_pairR  "${1}" "${2}
# Usage in cluster:
# sbatch <path/to/submitRscript.sh>  <path/to/params.file> <outputfolder>

args = commandArgs(trailingOnly=TRUE)
library(tidyverse)
library(primerTree)
API_KEY <- "c7f054eeed8138a4c66f908db525226fb208"
params <- read_csv(args[1])

outputfolder <- args[2]
dir.create(args[2])

#####Checks
reqs <-  c("Locus","Sequence_PrimerF","Sequence_PrimerR","Name_PrimerF","Name_PrimerR" )

if (sum(reqs %in% colnames(metadata)) < length(reqs)  ){
  message <- cat(paste(reqs, collapse = '\n'))
  knitr::knit_exit(append = paste0(" ERROR: Initial metadata is missing some of the key column names:
                                     ",
                                   paste(reqs, collapse = '\n'),
                                   "
                                     Change the column names / add the infromation to your csv file",
                                   sep = '\n' ))
}

# Check there are unique values for Locus

metadata %>%
  group_by(Locus) %>%
  tally() %>%
  pull(n) -> counts
if (max(counts)>1 ){
  message <- cat(paste(reqs, collapse = '\n'))
  knitr::knit_exit(append = " ERROR: Initial metadata has repeated values for `Locus`
                                    Make sure file is formatted correctly")
}
######### End of Checks



Recover_taxonomy_list <- function(Primer.pair) {

  Primer.pair$taxonomy %>%
    left_join(Primer.pair$BLAST_result,by="gi")  %>%
    distinct(order, genus, species, accession,taxId, mismatch_forward, mismatch_reverse) %>%
    arrange(desc(genus))
}

recover.safely <- possibly(Recover_taxonomy_list, "No_taxonomy")
## Search
params %>%
  group_by(Locus) %>%
  nest() %>%
  mutate(primer.output = map2 (data,Locus,  ~search_primer_pair(forward = .x$Sequence_PrimerF,
                                                                reverse = .x$Sequence_PrimerR,
                                                                name = .y,
                                                                num_aligns = .x$Num_alignments,
                                                                num_permutations = 25,
                                                                simplify = TRUE,
                                                                clustal_options = list(exec = "clustalo",
                                                                                       quiet = TRUE, original.ordering = TRUE),
                                                                distance_options = list(model = "N", pairwise.deletion = T),
                                                                api_key = API_KEY,
                                                                PRIMER_PRODUCT_MAX=18000,
                                                                .parallel = FALSE,
                                                                .progress = "none"))
  ) -> primer.output

write_rds(primer.output, file = file.path(outputfolder, "primer_search.rds"))

# Taxonomy.list

primer.output %>%
  mutate(taxonomy.list = map(primer.output, recover.safely)) -> Taxa.list

Taxa.list %>%
  select(Locus, data, taxonomy.list) %>%
  unnest(data) %>%
  unnest(taxonomy.list) %>%
  write_csv(file.path(outputfolder, "taxonomy.recovered.csv"))
