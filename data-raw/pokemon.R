# data-raw/pokemon.R

library(readr)
library(dplyr)
library(usethis)

# 1) Read your Pokémon CSV
pokemon_raw <- read_csv("data-raw/pokemon_df.csv", show_col_types = FALSE)

# 2) Clean and standardise column names
pokemon <- pokemon_raw %>%
  rename(
    name       = pokemon,
    generation = generation_id,
    type1      = type_1,
    type2      = type_2,
    hp         = hp,
    attack     = attack,
    defense    = defense,
    sp_attack  = special_attack,
    sp_defense = special_defense,
    speed      = speed
  ) %>%
  mutate(
    generation = as.integer(generation),
    type1 = as.character(type1),
    type2 = as.character(type2)
  )

# 3) Save cleaned dataset into /data as an .rda file
usethis::use_data(pokemon, overwrite = TRUE)

