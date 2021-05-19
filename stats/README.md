# Stats

We created a framework to simulate haplodiploid populations in the SLiM simulation framework. We have ran simulations of haplodiploid and of diploid populations affected by mutations of varying coefficients of selection and dominance. Here, we test whether there are significant differences between haplodiploid and diploid populations for each group of simulations.

## Input

```sh

mkdir -p input

cd input
ln -sf ../../advantageous/results/*csv .
ln -sf ../../neutral_and_deleterious/results/*csv .
ln -sf ../../dominance/results/*csv .

```

## Stats

We ran the `stats.rmd` script.
