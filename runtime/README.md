# Measure script runtime with different parameters

```sh

# Link to slim

mkdir results

mkdir results/time_output
mkdir results/slim_output

for g in large_genome small_genome; do
  for m in high_mutation_rate low_mutation_rate; do
    for n in 2000 10000 50000; do

      output_file=${g}_${m}_${n}

      (time ./slim slim_scripts/$g/$m/haplodiploid_n${n}.slim) \
        1> results/slim_output/$output_file.slim.out \
        2> results/time_output/$output_file.time &

    done
  done
done

for g in small_genome; do
  for m in high_mutation_rate low_mutation_rate; do
    for n in 20000; do

      output_file=${g}_${m}_${n}

      (time ./slim slim_scripts/$g/$m/haplodiploid_n${n}.slim) \
        1> results/slim_output/$output_file.slim.out \
        2> results/time_output/$output_file.time &

    done
  done
done

for g in medium_genome; do
  for m in high_mutation_rate low_mutation_rate; do
    for n in 2000 10000 20000 50000; do

      output_file=${g}_${m}_${n}

      (time ./slim slim_scripts/$g/$m/haplodiploid_n${n}.slim) \
        1> results/slim_output/$output_file.slim.out \
        2> results/time_output/$output_file.time &

    done
  done
done

```

Remove entries for simulations that did not finish in time.

```sh

mkdir -p tmp
wc -l results/slim_output/* | grep 417  | cut -f 3 -d "/" | cut -f 1 -d "." > tmp/finished_runs

```

Get runtime for each simulation:

```sh

while read p; do
  echo $p \
  $(cat results/time_output/${p}.time | cut -f 10 -d " ") >> tmp/time_measurement
done < tmp/finished_runs

```

```R

meas <- read.table("tmp/time_measurement")

library(tidyverse)
library(lubridate)
# library(clock)

meas %>%
  separate(V1, into=c("genome_size", NA, "mutation_rate", NA, NA, "population_size", NA)) %>%
  mutate(population_size = fct_relevel(population_size, "2000")) -> meas

## Parse time
### Most are in the format HH:MM:SS.XX
### But those done under 1 hour and have the format MM:SS.XX
meas$time <- meas$V2
meas$time[!grepl(":[0-9][0-9]:", meas$time)] <- paste0("00:",
  meas$time[!grepl(":[0-9][0-9]:", meas$time)])

meas$time = lubridate::hms(meas$time)
meas$hours = as.numeric(meas$time, "hours")

meas %>%
  filter(population_size != "50000") %>%
  filter(genome_size != "large") %>%
  mutate(genome_size = fct_recode(genome_size,
    "Genome size = 5e6" = "medium",
    "Genome size = 1e6" = "small")) %>%
  mutate("Mutation rate" = fct_recode(mutation_rate,
         "Mutation rate = 1e-7" = "high",
         "Mutation rate = 1e-8" = "low")) %>%
  mutate("Mutation rate" = fct_relevel(`Mutation rate`,
         "Mutation rate = 1e-8")) %>%
  mutate(time_print = paste(sprintf("%02d", hour(time)),
  sprintf("%02d",minute(time)), sep = ":")) -> data_for_plot
  #mutate(population_size = as.numeric(as.character(population_size))) %>%

ggplot(data_for_plot, aes(x = population_size,
             y = hours)) +
    geom_bar(stat="identity",
             position = position_dodge(preserve = "single")) +
    geom_text(aes(label = time_print),
              nudge_y = 4, size = 3) +
    # geom_point() +
    facet_grid(rows = vars(genome_size),
               cols = vars(`Mutation rate`)) +
    xlab("Population size") +
    ylab("Runtime (hours)") +
  #  scale_y_continuous(trans = 'log2') +
  #  scale_x_continuous(limits = c(0, 22000), breaks = c(2000, 10000, 20000)) +
    theme_bw() -> my_plot

dir.create("results")
ggsave(my_plot, file = "results/simulation_time.pdf",
       height = 4.5, width =7)

```
