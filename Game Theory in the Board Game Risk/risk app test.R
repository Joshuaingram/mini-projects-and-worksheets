library(shiny)
library(DT)
load("probdf.RData")
load("payofflist.RData")
load("indexlist.RData")

# UI for risk app
ui <- pageWithSidebar(
  
  # App title
  headerPanel("Payoff Matrices for a Single-move 'Attack Phase' in Risk"),
  
  # sidebar panel for inputs
  sidebarPanel(
    
    selectInput(inputId = "move",
                label = "Select your move:",
                choices = c("Attack" = 1, "Defend" = 2)),
    
    selectInput(inputId = "num.friendly",
                label = "Number of friendly armies:",
                choices = c("1 Army" = 1,
                            "2 Armies" = 2,
                            "3+ Armies" = 3)),
    
    selectInput(inputId = "num.enemy",
                label = "Number of enemy armies:",
                choices = c("1 Army" = 1,
                            "2 Armies" = 2,
                            "3+ Armies" = 3))
    
  ),
  
  # main panel for output display
  mainPanel(
    
    dataTableOutput("table"),
    
    h4(textOutput("text"))
  )
)

# server logic for risk app
server <- function(input, output){
  
  output$table <- renderDataTable(payoff.list[[index.list[[as.numeric(input$move)]][as.numeric(input$num.friendly), as.numeric(input$num.enemy)]]], 
                                  options = list(searching = FALSE, paging = FALSE))
  
  output$text <- renderText("In the payoff matrix above, the pair (A, D) represents the expected loss (lower is better) for the Attacker and Defender. The row dice choices are for the attacker 
                            and the column dice choices are for the defender")

}

shinyApp(ui, server)