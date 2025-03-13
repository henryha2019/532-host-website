library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
library(plotly)

fifa_data <- read.csv("../data/raw/fifa_countries_audience.csv")

ui <- fluidPage(
  titlePanel(
    div(style = "background-color: #ADD8E6; padding: 20px; color: black;",
        "FIFA Audience Analysis Dashboard")
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput("confederation", "Select Confederation:",
                  choices = c("All", unique(fifa_data$confederation)), 
                  selected = "All"),
      
      sliderInput("population_share", "Population Share Range:",
                  min = min(fifa_data$population_share),
                  max = max(fifa_data$population_share),
                  value = c(min(fifa_data$population_share), max(fifa_data$population_share))),
      
      sliderInput("tv_audience_share", "TV Audience Share Range:",
                  min = min(fifa_data$tv_audience_share),
                  max = max(fifa_data$tv_audience_share),
                  value = c(min(fifa_data$tv_audience_share), max(fifa_data$tv_audience_share)))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Scatter Plot", plotlyOutput("scatter_plot")), # Use plotlyOutput here
        tabPanel("Data Table", DTOutput("data_table")),
        tabPanel("Summary Statistics", verbatimTextOutput("summary_stats"))
      )
    )
  )
)

server <- function(input, output) {
  
  # Filter data based on user inputs
  filtered_data <- reactive({
    data <- fifa_data %>%
      filter(population_share >= input$population_share[1] & population_share <= input$population_share[2],
             tv_audience_share >= input$tv_audience_share[1] & tv_audience_share <= input$tv_audience_share[2])
    if (input$confederation != "All") {
      data <- data %>%
        filter(confederation == input$confederation)
    }
    data
  })
  
  # Interactive scatter plot with plotly
  output$scatter_plot <- renderPlotly({
    plot_ly(filtered_data(), 
            x = ~population_share, 
            y = ~tv_audience_share, 
            type = 'scatter', 
            mode = 'markers',
            text = ~paste("Country: ", country, "<br>Population Share: ", population_share, "%<br>TV Audience Share: ", tv_audience_share, "%"),
            hoverinfo = 'text') %>%
      layout(title = "Population Share vs. TV Audience Share",
             xaxis = list(title = "Population Share (%)"),
             yaxis = list(title = "TV Audience Share (%)"))
  })
  
  # Data table
  output$data_table <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10))
  })
  
  # Summary statistics
  output$summary_stats <- renderPrint({
    summary(filtered_data()[, c("population_share", "tv_audience_share", "gdp_weighted_share")])
  })
}

shinyApp(ui = ui, server = server)
