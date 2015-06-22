library(shiny)
library(DT)

shinyServer(
   
    function(input, output) {
        
        Category <- c("Underweight", "Normal Weight", "Overweight", "Obesity")
        values_range <-c("<=18.5", "18.5 - 24.9", "25.0 - 29.9", ">= 30.0")
        
        df<-data.frame(values_range, Category )
        
        output$choose_unit <- renderUI({
            radioButtons("unit_type", "Unit:", choice = c("Standard"= "s", "Metric" = "m" ), selected = "s" )
        })
        
        output$input_form_Height <- renderUI({
            if(is.null(input$unit_type)) return()
            helpText("Your Height:")
            if( input$unit_type == "s"){
                wellPanel(
                div(style="display:inline-block",textInput(inputId="feet_val", label = "")),
                div(style="display:inline-block",helpText("feet")),
                div(style="display:inline-block",textInput(inputId="inch_val",label = "")),
                div(style="display:inline-block",helpText("inch"))
                )
            }
            else{
               wellPanel(
                div(style="display:inline-block",textInput(inputId="cen_val",label = "")),
                div(style="display:inline-block",helpText("centimeters"))
               )
            }
            
            
        })
        
        output$input_form_Weight <- renderUI({
            
            
            if(is.null(input$unit_type)) return()
           
            if( input$unit_type == "s"){
                wellPanel(
                div(style="display:inline-block",textInput(inputId="pound_val",label = "")),
                div(style="display:inline-block",helpText("pounds"))
                )
              
            }
            else{
                wellPanel(
                div(style="display:inline-block",textInput(inputId="kilo_val",label = "")),
                div(style="display:inline-block",helpText("kilograms"))
                )
            }
            
            
        })
        
        output$text1 <- renderText({
            input$goButton
            if(is.null(input$unit_type)) return()
            if( input$unit_type == "s"){
                height <- 12*as.numeric(input$feet_val) + as.numeric(input$inch_val) 
                weight <- as.numeric(input$pound_val)
                bmi <- round( weight * 703/ ((height) * (height)), digit = 1) 
                
                isolate(paste0(as.numeric(bmi)))
            }
            else{
                height <- as.numeric(input$cen_val)
                weight <- as.numeric(input$kilo_val)
                bmi <- round( weight/ ((height/100) * (height/100)), digit = 1) 
                isolate(paste0(as.numeric(bmi)))
            }
            
            if(is.na (bmi)){
                
                bmi<- "Result Is Not Avaliable"
            }
            isolate(paste(bmi))
        
        })
        
        
        output$text2 <- renderText({
            #input$goButton
            if(is.null(input$unit_type)){}
         
            if( input$unit_type == "s"){
                height <- 12*as.numeric(input$feet_val) + as.numeric(input$inch_val) 
                weight <- as.numeric(input$pound_val)
                bmi <- round( weight * 703/ ((height) * (height)), digit = 1) 
                
           
            }
            else{
                height <- as.numeric(input$cen_val)
                weight <- as.numeric(input$kilo_val)
                bmi <- round( weight/ ((height/100) * (height/100)), digit = 1) 
                
              
            }
            
            if(is.na (bmi)){
                
                category<- "Result Is Not Avaliable"
            }
            else if(bmi< 18.5){
                
                category<-  Category[1]
               
            }
            else if (bmi>=18.5 & bmi<= 24.9){
                
                category<-  Category[2]
                
            }
            else if( bmi >= 25 & bmi <= 29.9){
                
                category<-  Category[3]
                
            }
            else{
                
                category<-  Category[4]
                
            }
            
            isolate(paste0(category))
           
        })
        
        output$Table1 <- renderDataTable({
         
            names(df) <- c("BMI Range", "Weight Category")
        datatable(df,
                  caption = htmltools::tags$caption(
                      style = 'caption-side: top; text-align: center;',
                      htmltools::strong('Table : BMI Weight Categories ')
                  ))
        })
        
        output$text3 <- renderText({
            
            paste0("First ")
        })
        
        
        
        
    })
        


