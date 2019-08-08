library(shiny)
library(nivowaffle)

ui <- fluidPage(
  titlePanel("reactR HTMLWidget Example"),
  nivowaffleOutput('widgetOutput')
)

server <- function(input, output, session){
  df <- data.frame(
   id = c("men", "women", "children"),
   label = c("men", "women", "children"),
   value = c(20, 13, 16),
   color = c("#468df3", "#ba72ff", "#a1cfff")
  )
  output$widgetOutput <- renderNivowaffle({
      nivowaffle(df,
             total = 100,
             rows = 10,
             columns = 18,
             colors="set2",
             borderColor="inherit:darker(0.3)",
             fillDirection = "left")
    })
}

shinyApp(ui, server)