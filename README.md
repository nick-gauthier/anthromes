
<!-- README.md is generated from README.Rmd. Please edit that file -->

# anthromes: Tools for analyzing long-term population and land use in R

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/nick-gauthier/anthromes/branch/master/graph/badge.svg)](https://codecov.io/gh/nick-gauthier/anthromes?branch=master)
[![check-release](https://github.com/nick-gauthier/anthromes/workflows/check-release/badge.svg)](https://github.com/nick-gauthier/anthromes/actions)
<!-- badges: end -->

An R package for analyzing historical land use and population on a
regional to global scales. It includes functions to download HYDE 3.2
and Anthromes-12k data (from the Anthromes-12k-DGG repository at
<https://doi.org/10.7910/DVN/E3H3AK>), apply the anthromes
classification, extract raster data using an equal-area discrete global
grid system, and generate common summary tables and visualizations.

It is based on (and supersedes) the R research compendium used to
generate the analyses and figures for:

> Ellis, E.C., N. Gauthier, K. Klein Goldewijk, R. Bliege Bird, N.
> Boivin, S. Diaz, D. Fuller, J. Gill, J. Kaplan, N. Kingston, H. Locke,
> C. McMichael, D. Ranco, T. Rick, M.R. Shaw, L. Stephens, J.C.
> Svenning, J.E.M. Watson, (2021). *People have shaped most of
> terrestrial nature for at least 12,000 years*. PNAS.
> <https://doi.org/10.1073/pnas.2023483118>

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("nick-gauthier/anthromes")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(anthromes)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.

### How to cite

This package is currently in development, with submission to rOpenSci
planned shortly. In the interim, please cite the original R compendium
at:

> Gauthier, Nicolas (2021). *Anthromes 12K DGG (V1) analysis code and R
> research compendium*. Online at Harvard Dataverse,
> <https://doi.org/10.7910/DVN/6FWPZ9>
