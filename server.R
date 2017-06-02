library(shiny)

dat <- data.frame(attitude)

shinyServer(function(input, output) {
  
  
  lm1 <- reactive({lm(reformulate(input$IndVar, input$DepVar), data = dat)})
  
  output$independent <- renderUI({
    checkboxGroupInput("IndVar", "Selection of Independent Variables:",
                       names(dat)[!names(dat) %in% input$DepVar],names(dat)[!names(dat) %in% input$DepVar])
  })
  
  output$RegSum <- renderPrint({
    if(!is.null(input$IndVar)){
      round(summary(lm1())$coefficients[,c(1,4)],3)
      } else {
        print(data.frame(Warning="Select at least one independent variable"))
      }
      })
  
  output$R2 <- renderPrint({
    if(!is.null(input$IndVar)){
    round(summary(lm1())$r.squared,3)
    } else {
      print(data.frame(Warning="Not possible to calculate R-squared"))
  }
})

  output$plot <- renderPlot({
    plot(dat[,1], lm1()$fitted.values, xlab = "Rating",
         ylab = "Fitted Values (Rating_hat)", main = "Model Fit",
         cex = 1.5, pch = 18, bty = "n")
    if(!is.null(lm1())){
      abline(lm(lm1()$fitted.values ~ dat[,1], data=dat) , col = "blue", lwd = 2)
    }
  })  
  
  
  
})
