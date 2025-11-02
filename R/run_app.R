#' Launch the Pokémon Shiny app
#'
#' Opens the interactive app that explores the `pokemon` dataset.
#'
#' @param ... Passed to [shiny::runApp()]
#'
#' @return No return value; called for side effects.
#' @export
#' @examples
#' \dontrun{
#'   run_pokeviz()
#' }
run_pokeviz <- function(...) {
  app_dir <- system.file("app", package = "pokevizSan2689")
  if (app_dir == "" || !dir.exists(app_dir)) {
    stop("Could not find app directory. Try reinstalling pokevizSan2689.", call. = FALSE)
  }
  shiny::runApp(app_dir, launch.browser = TRUE, ...)
}
