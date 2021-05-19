# Simulations of populations with neutral and deleterious mutations

We created a framework to simulate haplodiploid populations in the SLiM simulation framework. Here, we run simulations of populations with neutral mutations, as well as recessive deleterious mutations with a range of selective coefficients. The scripts used are the `slim_scripts` directory.  

## Parse simulation results

We parsed the simulation results:

```sh

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/diploid_h0_s000*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/diploid_h0_s000_tmp

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/diploid_h0_s-0005*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/diploid_h0_s-0005_tmp

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/diploid_h0_s-001*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/diploid_h0_s-001_tmp

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/diploid_h0_s-003*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/diploid_h0_s-003_tmp

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/diploid_h0_s-010*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/diploid_h0_s-010_tmp


grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/haplodiploid_h0_s000*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/haplodiploid_h0_s000_tmp

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/haplodiploid_h0_s-0005*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/haplodiploid_h0_s-0005_tmp

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/haplodiploid_h0_s-001*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/haplodiploid_h0_s-001_tmp

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/haplodiploid_h0_s-003*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/haplodiploid_h0_s-003_tmp

grep -A5000 -m1 -e "Generation, FixedMutations, NucleotideHeterozygosity" \
  results/outputs/haplodiploid_h0_s-010*/* | grep -v "Generation" \
  | grep -v "^--"| cut -f 4- -d "/" > results/haplodiploid_h0_s-010_tmp

```

```r

parse_df <- function(path) {
  df <- read.table(file.path("results",path))
  id <- as.character(df$V1)
  split_id <- strsplit(id, split = "_")

  ploidy    <- sapply(split_id, function(x) x[1])
  dominance <-  sapply(split_id, function(x) x[2])

  id <- sapply(split_id, function(x) x[3])
  split_id <- strsplit(id, split = "\\.")

  selection <- sapply(split_id, function(x) x[1])

  simulation_id <- sapply(split_id, function(x) paste(x[2], gsub("-.*", "", x[3]), sep = "_"))
  generation    <- sapply(split_id, function(x) gsub(".*-", "", x[3]))

  to_return <- data.frame(
    ploidy = ploidy,
    dominance = dominance,
    selection = selection,
    simulation_id = simulation_id,
    generation = generation,
    number_fixed = df$V2,
    nucleotide_diversity = df$V3
  )

  return(to_return)

}

to_parse <- list.files("results")
to_parse <- to_parse[grepl("_tmp", to_parse)]

parsed_df <- lapply(to_parse, function(path) parse_df(path))
parsed_df <- do.call(rbind, parsed_df)

parsed_df$selection <- as.character(parsed_df$selection)
parsed_df$selection[parsed_df$selection == "s000"]   <- "0"
parsed_df$selection[parsed_df$selection == "s-0005"] <- "-0.0005"
parsed_df$selection[parsed_df$selection == "s-001"]  <- "-0.001"
parsed_df$selection[parsed_df$selection == "s-003"]  <- "-0.003"
parsed_df$selection[parsed_df$selection == "s-010"]  <- "-0.010"

write.csv(parsed_df[parsed_df$selection!= "0", ] ,
          file="results/deleterious_mutations_h0.csv",
          row.names=FALSE, quote=FALSE)

write.csv(parsed_df[parsed_df$selection== "0", ] ,
          file="results/neutral_mutations_h0.csv",
          row.names=FALSE, quote=FALSE)

```

```sh

mkdir -p results/outputs
mv *output results/outputs

grep "50000 " results/outputs/diploid_h0_s000*/* > results/diploid_h0_s000
grep "50000 " results/outputs/diploid_h0_s-001*/* > results/diploid_h0_s-001
grep "50000 " results/outputs/diploid_h0_s-003*/* > results/diploid_h0_s-003
grep "50000 " results/outputs/diploid_h0_s-010*/* > results/diploid_h0_s-010

grep "50000 " results/outputs/haplodiploid_h0_s000*/* > results/haplodiploid_h0_s000
grep "50000 " results/outputs/haplodiploid_h0_s-001*/* > results/haplodiploid_h0_s-001
grep "50000 " results/outputs/haplodiploid_h0_s-003*/* > results/haplodiploid_h0_s-003
grep "50000 " results/outputs/haplodiploid_h0_s-010*/* > results/haplodiploid_h0_s-010

```


```r

hapdip <- function(sim) {

  hp <- read.table(paste0("results/haplodiploid_h0_s", sim))$V2
  dp <- read.table(paste0("results/diploid_h0_s", sim))$V2

  sims <- data.frame(
    sim_id = 1:length(hp),
    hp = hp,
    dp = dp
  )

  library(tidyverse)

  sims %>%
    pivot_longer(-sim_id) %>%
    ggplot(aes(x = name, y = value)) + geom_boxplot() + geom_point() -> p

  ggsave(p, file = paste0("results/s", sim, ".pdf"))


  dp <- sims$dp
  hp <- sims$hp

  sims$difference     <- sims$hp - sims$dp
  sims$difference_per <- 100 * sims$difference / sims$hp

  sims <- rbind(sims,
  c(11, mean(hp), mean(dp), mean(hp) - mean(dp), 100*(mean(hp) - mean(dp))/mean(hp)))

  sims$sim_id <- as.character(sims$sim_id)

  sims$sim_id[length(sims$sim_id)] <- "total"
  outpath <- paste0("results/s", sim, "_summary.csv")
  write.csv(sims, file = outpath, quote=FALSE, row.names=FALSE)
}

hapdip("000")
hapdip("-001")
hapdip("-003")
hapdip("-010")

```
