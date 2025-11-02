
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pokevizSan2689

<!-- badges: start -->
<!-- badges: end -->

pokevizSan2689 is a small teaching package for ETC5523. It bundles a
cleaned Pokémon dataset and a Shiny app to explore base stats by type
and generation.

## Installation

You can install the development version of assignment4packagesSan2689
from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-San2689")
```

## Example

During development you can load the package from this project without
installing:

``` r
if (requireNamespace("devtools", quietly = TRUE)) devtools::load_all(quiet = TRUE)
library(pokevizSan2689)
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
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
