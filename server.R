#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

data(mtcars)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   model1 <-lm(hp ~ disp, data = mtcars)
   model1pred <- reactive({
     dispInput <- input$sliderDisplacement
     predict(model1, newdata = data.frame(disp = dispInput))
})

   output$plot1 <- renderPlot({
     dispInput <- input$sliderDisplacement
     
     plot(mtcars$disp, mtcars$hp, xlab = "Displacement", 
          ylab = "Horsepower", bty = "n", pch = 50,
          xlim = c(0, 500), ylim = c(0, 350),
          abline(model1, col = "red", lwd = 2))
    legend(25, 250,"Model 1 Prediction", pch = 16, 
          col = "red", bty = "n", cex = 1.2)
    points(dispInput, model1pred(), col = "red", pch = 16, cex = 2)
    
})     

  
   output$pred1 <- renderText({
     model1pred()
})
   

})


   



     
  
     
       