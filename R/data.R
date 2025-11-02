#' Pokémon base stats dataset
#'
#' A cleaned Pokémon dataset used by the Shiny app.
#'
#' @format A tibble with one row per Pokémon and columns:
#' \describe{
#'   \item{name}{Pokémon name}
#'   \item{generation}{Game generation (integer)}
#'   \item{type1}{Primary type}
#'   \item{type2}{Secondary type (may be NA)}
#'   \item{hp}{Base HP}
#'   \item{attack}{Base Attack}
#'   \item{defense}{Base Defense}
#'   \item{sp_attack}{Base Special Attack}
#'   \item{sp_defense}{Base Special Defense}
#'   \item{speed}{Base Speed}
#' }
#' @source Student-collected dataset for ETC5523 Assignment 4.
"pokemon"
