# inst/app/app.R
# A small explorer for the `pokemon` dataset in the package

if (!requireNamespace("shiny", quietly = TRUE)) stop("Please install shiny")
if (!requireNamespace("ggplot2", quietly = TRUE)) stop("Please install ggplot2")
if (!requireNamespace("dplyr", quietly = TRUE)) stop("Please install dplyr")
if (!requireNamespace("DT", quietly = TRUE)) stop("Please install DT")
if (!requireNamespace("bslib", quietly = TRUE)) stop("Please install bslib")

library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(bslib)

ui <- page_fillable(
  theme = bs_theme(version = 5),
  titlePanel("Pokémon Base Stats Explorer"),
  sidebarLayout(
    sidebarPanel(
      selectInput("type1", "Primary type:", choices = c("All", sort(unique(pokemon$type1))), selected = "All"),
      selectInput("generation", "Generation:", choices = c("All", sort(unique(pokemon$generation))), selected = "All"),
      selectInput("xvar", "X variable:", choices = c("attack","defense","sp_attack","sp_defense","speed","hp")),
      selectInput("yvar", "Y variable:", choices = c("defense","attack","sp_attack","sp_defense","speed","hp"), selected = "defense"),
      width = 3
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("scatter", height = 420)),
        tabPanel("Table", DTOutput("tbl")),
        tabPanel("Summary", verbatimTextOutput("summary"))
      ),
      width = 9
    )
  )
)

server <- function(input, output, session) {
  data_f <- reactive({
    df <- pokemon
    if (input$type1 != "All") df <- df %>% filter(type1 == input$type1)
    if (input$generation != "All") df <- df %>% filter(generation == as.integer(input$generation))
    df
  })

  output$scatter <- renderPlot({
    ggplot(data_f(), aes(.data[[input$xvar]], .data[[input$yvar]], color = type1)) +
      geom_point(alpha = 0.7) +
      labs(x = input$xvar, y = input$yvar) +
      theme_minimal()
  })

  output$tbl <- renderDT({
    datatable(data_f(), options = list(pageLength = 10), rownames = FALSE)
  })

  output$summary <- renderPrint({
    dplyr::summarise(
      data_f(),
      n = dplyr::n(),
      across(c(hp, attack, defense, sp_attack, sp_defense, speed), list(min=min, mean=mean, max=max), .names="{.col}_{.fn}")
    )
  })
}

shinyApp(ui, server)
