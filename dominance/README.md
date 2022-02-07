# Simulations of populations with advantageous mutations of varying dominance

We created a framework to simulate haplodiploid populations in the SLiM simulation framework. Here, we run simulations of populations with advantageous mutations under a range of dominance coefficients. The scripts used are the [`slim_scripts`](slim_scripts/) directory, and the results of the simulation run in the [`results`](results/) directory.

## Parse simulation results

We parsed the simulation results:

```sh

ls results/outputs | cut -f 1 -d "-" \
| parallel "grep -A50000 -m1 -e 'Generation, FixedMutations, NucleotideHeterozygosity' \
  results/outputs/{}*/* | grep -v 'Generation' \
  | grep -v '^--'| cut -f 4- -d '/' > results/{}_tmp"

```

And combine them into a single data frame.

```r

parse_df <- function(path) {
  df <- read.table(file.path("results", path))
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
parsed_df$selection[parsed_df$selection == "s001"] <- "0.001"

parsed_df$dominance  <- as.character(parsed_df$dominance)

parsed_df$dominance[parsed_df$dominance == "h00"]  <- "0.00"
parsed_df$dominance[parsed_df$dominance == "h25"]  <- "0.25"
parsed_df$dominance[parsed_df$dominance == "h50"]  <- "0.50"
parsed_df$dominance[parsed_df$dominance == "h75"]  <- "0.75"
parsed_df$dominance[parsed_df$dominance == "h100"]  <- "1.00"

write.csv(parsed_df,
          file="results/dominance_mutations_s001.csv",
          row.names=FALSE, quote=FALSE)

```
