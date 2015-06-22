library(shiny)
library(DT)

shinyUI(pageWithSidebar(
    headerPanel("BMI Calculator"),
    sidebarPanel(
        uiOutput("choose_unit"),
        tags$h4("Your Height:"),
        uiOutput("input_form_Height"),
        tags$h4("Your Weight:"),
        uiOutput("input_form_Weight"),
        actionButton("goButton", "Go!")
       
    ),
    mainPanel(
        
        tags$h4('Your BMI:'),
        verbatimTextOutput('text1'),
        tags$h4('Your BMI Category:'),
        verbatimTextOutput('text2'),      
        tags$h4('User Instruction:'),        
        p("This is an app to predict BMI ( Body Mass Index). It is an attempt to quantify the amount of 
            tissue mass (muscle, fat, and bone) in an individual, and then categorize that person as underweight,
          normal weight, overweight, or obese based on that value ( See the table below)."),
         dataTableOutput("Table1"),
        p("Here are the steps for how to use the app as follows:"),
        
        HTML("<ol><li>Select the unit for weight and height inputs. There are two choices: Standard and Metric. For Standard, Height uses feet and inch, and Weight uses pounds; for Metric, Height uses centimeters, and Weight uses kilograms</li>
             <li>Input the numerical values of Height and Weight fields</li>
             <li>Click Go! button (It is not necessay because it will update the output automatically). Then you can get your BMI value and Weight Category on the right panel.</li></ol>"
        ),
        p("Note: If you input invalid values, the outputs will be \"Result Is Not Avaliable\"." 
        )
    )
))