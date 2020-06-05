library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Risk Strategist"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: player selection
      selectInput(inputId = "player",
                  label = "Select your move:",
                  choices = c("Attack", "Defend")),
      
      # Input: number of friendly and enemy armies
      sliderInput(inputId = "num.armes.friendly",
                  label = "Number of friendly armies:",
                  min = 1,
                  max = 3,
                  value = 1),
      
      sliderInput(inputId = "num.armies.enemy",
                  label = "Number of enemy amries:",
                  min = 1,
                  max = 3,
                  value = 1)
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: strategy
      verbatimTextOutput(outputId = "strategy"),
      
      tableOutput("probabilities")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    
  })
  
}

shinyApp(ui, server)