
####################################
# Pre-work                         #
####################################
#RFmodel <- randomForest(Outcome ~ ., data=train.MLdata, ntree=1001, mtry=1, proximity=TRUE)
#saveRDS(RFmodel, "model.rds")

# Import libraries
library(shiny)
library(data.table)
library(caret)
library(shinythemes)
library(markdown)
library(xgboost)
library(ipred)
library(lattice)
library(ggplot2)
library(V8)
library(randomForest)

#read model
model <- readRDS("model.rds")
####################################
# User interface                   #
####################################

ui <- fluidPage(theme = shinytheme("united"),
                navbarPage("Machine learning classification tool: predict puberty onset",
                           
                           tabPanel("Home",
                                    
                                    # Input values         
                                        HTML("<h3>Input parameters</h3>"),
                                        sidebarPanel(p('Enter patient hormone levels'),  
                                        #tags$label(h3('Input parameters')),
                                        numericInput("Hormone1", 
                                                     label = "Estrone (E1), pmol/L", 
                                                     value = 5),
                                        numericInput("Hormone2", 
                                                     label = "Estradiol (E2), pmol/L", 
                                                     value = 5),
                                        numericInput("Hormone3", 
                                                     label = "Luteinizing hormone (LH), IU/L",
                                                     value = 2),
                                        numericInput("Hormone4", 
                                                     label =  "Follicle-stimulating hormone (FSH), IU/L", 
                                                     value = 1),
                                        numericInput("Hormone5", 
                                                     label = "Sex hormone-binding globulin (SHBG), nmol/L", 
                                                     value = 120),
                                        
                                        actionButton("submitbutton", "Submit", 
                                                     class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                        tags$label(h3('Puberty prediction')), 
                                        verbatimTextOutput('contents'),
                                        tableOutput('tabledata') 
                                    ) 
                                    
                           ), 
                           
                           tabPanel("About", 
                                    titlePanel("About"), 
                                    div(includeMarkdown("about.md"), 
                                        align="justify")
                           ) 
                           
                ) 
) 


