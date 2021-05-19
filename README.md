# Simulations of haplodiploid populations

We created a framework to simulate haplodiploid populations in the SLiM simulation framework. An example script is presented in [haplodiploid.slim](haplodiploid.slim).

We tested the script in a number of evolutionary scenarios comparing haplodiploid and diploid populations. The scripts used for simulations of recessive advantageous mutations are in [`advantageous`](advantageous/), those for neutral and recessive deleterious mutations are in [`neutral_and_deleterious`](neutral_and_deleterious/), and those for advantageous mutations over a range of dominance coefficients are in [`dominance`](dominance/). The results of these simulations were analysed with the scripts in [`stats`](stats/).
