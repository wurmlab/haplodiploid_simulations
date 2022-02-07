# Simulations of haplodiploid populations

We created a framework to simulate haplodiploid populations in the SLiM simulation framework. An example script, updated to run un SLiM v3.7 is presented in [haplodiploid.slim](haplodiploid.slim).

We tested the script in a number of evolutionary scenarios comparing haplodiploid and diploid populations. The scripts used for simulations of recessive advantageous mutations are in [`advantageous`](advantageous/), those recessive deleterious mutations are in [`deleterious`](deleterious/), those for neutral mutations are in [`neutral`](neutral) and those for advantageous mutations over a range of dominance coefficients are in [`dominance`](dominance/).

The results of these simulations are given in each of the respective directories. The results were analysed with the scripts in [`stats`](stats/).
