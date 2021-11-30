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

Recover_taxonomy_list <- function(Primer.pair) {
  
  Primer.pair$taxonomy %>%
    left_join(Primer.pair$BLAST_result,by="gi")  %>%
    distinct(order, genus, species, accession,taxId, mismatch_forward, mismatch_reverse) %>%
    arrange(desc(genus))
}

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
  mutate(taxonomy.list = map(primer.output, Recover_taxonomy_list)) -> Taxa.list

Taxa.list %>%
  select(Locus, data, taxonomy.list) %>% 
  unnest(data) %>% 
  unnest(taxonomy.list) %>% 
  write_csv(file.path(outputfolder, "taxonomy.recovered.csv"))
