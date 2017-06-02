library(shiny)
 
shinyUI(pageWithSidebar(
  headerPanel("Fitting Linear Models Selecting Independent Variables"),
  
  sidebarPanel(
    selectInput("DepVar", "Dependent Variable:", c("rating")),
    uiOutput("independent"),
    p(strong("Explanation :",style="color:blue"), "After loading the dataset `attitude` from the package `datasets`, with this app, the user can fit different
      linear models selecting from the checkbox the independent variables related to the outcome variable `rating`. 
      The output of the variable selection is the estimation of the coefficients and corresponding
      p-values for each model. In the middle section, the correspondig R-squared of the selected model is calculated. Finally, 
a scatterplot showing the Outcome Variable Rating (x-axis)
      vs. the fitted values of Rating (y-axis) is presented. 
      For further explanation of the dataset, check the presentation at http://rpubs.com/davlira82/shinyapp")
  ), 
 
   mainPanel(
    h3("Coefficients and P-values"),
    verbatimTextOutput(outputId = "RegSum"),
    h3("R-squared of selected model"),
    verbatimTextOutput(outputId = "R2"),
    plotOutput("plot")
  )
))

