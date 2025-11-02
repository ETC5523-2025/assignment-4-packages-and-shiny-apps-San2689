
# pokevizSan2689

<!-- badges: start -->
<!-- badges: end -->

pokevizSan2689 is a small teaching package for ETC5523. It provides a
cleaned Pokémon dataset (pokemon) and a Shiny app to explore base stats
by type and generation.

## Installation

Install the package from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-San2689")
```

## Quick start

Launch the Shiny app:

``` r
library(pokevizSan2689)
run_pokeviz()
```

Work with the bundled dataset:

``` r
library(dplyr)
library(ggplot2)

pokemon %>%
  count(type1, sort = TRUE) %>%
  head(10)
```

``` r
pokemon %>%
  filter(type1 %in% c("fire","water","grass")) %>%
  ggplot(aes(attack, defense, colour = type1)) +
  geom_point(alpha = 0.6) +
  theme_minimal()
```

## Development

During development you can load the package without installing:

``` r
if (requireNamespace("devtools", quietly = TRUE)) devtools::load_all(quiet = TRUE)
```

Rendered from README.Rmd - rebuild with devtools::build_readme().

## Package website

<https://etc5523-2025.github.io/assignment-4-packages-and-shiny-apps-San2689/>
