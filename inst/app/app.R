# inst/app/app.R

if (!requireNamespace("shiny", quietly = TRUE)) stop("Please install shiny")
if (!requireNamespace("ggplot2", quietly = TRUE)) stop("Please install ggplot2")
if (!requireNamespace("dplyr", quietly = TRUE)) stop("Please install dplyr")
if (!requireNamespace("DT", quietly = TRUE)) stop("Please install DT")
if (!requireNamespace("bslib", quietly = TRUE)) stop("Please install bslib")

library(shiny); library(ggplot2); library(dplyr); library(DT); library(bslib)

# use the dataset from your package
df <- pokevizSan2689::pokemon

ui <- page_fillable(
  theme = bs_theme(
    version   = 5,
    bootswatch = "flatly",
    primary    = "#6C63FF",
    base_font  = font_google("Inter")
  ),
  # place your css file at inst/app/www/styles.css
  tags$head(tags$link(rel = "stylesheet", href = "styles.css")),

  titlePanel("Pokémon Base Stats Explorer"),
  sidebarLayout(
    sidebarPanel(
      selectInput("type1", "Primary type:", choices = c("All", sort(unique(df$type1))), selected = "All"),
      selectInput("generation", "Generation:", choices = c("All", sort(unique(df$generation))), selected = "All"),
      selectInput("xvar", "X variable:", choices = c("attack","defense","sp_attack","sp_defense","speed","hp")),
      selectInput("yvar", "Y variable:", choices = c("defense","attack","sp_attack","sp_defense","speed","hp"), selected = "defense"),
      helpText(
        strong("Field meanings:"),
        tags$ul(
          tags$li(code("generation"), " – Game generation (1–8)"),
          tags$li(code("type1 / type2"), " – Primary / secondary type"),
          tags$li(code("hp, attack, defense, sp_attack, sp_defense, speed"),
                  " – Base battle stats used for comparisons")
        )
      ),
      width = 3
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Plot",
          plotOutput("scatter", height = 420),
          div(
            h4("How to interpret"),
            p("Each point represents a Pokémon."),
            p("Colour indicates its primary type (type1)."),
            p("A rising pattern suggests a positive relationship between the chosen X and Y stats."),
            p("Use the filters to explore how these relationships vary by type or generation.")
          )
        ),
        tabPanel("Table", DTOutput("tbl")),
        tabPanel("Summary", verbatimTextOutput("summary"))
      ),
      width = 9
    )
  )
)

server <- function(input, output, session) {
  data_f <- reactive({
    d <- df
    if (input$type1 != "All") d <- d %>% filter(type1 == input$type1)
    if (input$generation != "All") d <- d %>% filter(generation == as.integer(input$generation))
    d
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
