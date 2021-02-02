
####################################
# Server-side                      #
####################################

server<- function(input, output, session) {
    
    # Input Data
    datasetInput <- reactive({  
        
        df <- data.frame(
            Name = c("Hormone1",
                     "Hormone2",
                     "Hormone3",
                     "Hormone4",
                     "Hormone5"),
            Value = as.character(c(input$Hormone1,
                                   input$Hormone2,
                                   input$Hormone3,
                                   input$Hormone4,
                                   input$Hormone5)),
            stringsAsFactors = FALSE)
        
        Outcome <- 0
        df <- rbind(df, Outcome)
        input <- transpose(df)
        write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
        
        test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
        
        model <- readRDS("model.rds")
        
        Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
        Output$Status <- ifelse(Output$Prediction == 1, "Prepubertal", ifelse(Output$Prediction == 0, "Pubertal", NA))
        colnames(Output) <- c("discard", "pubertal_vote","prepubertal_vote", "Prediction")
        df2 <- Output[,c(4,2,3)]
        print(df2)
        
    })
    
    # Status/Output Text Box
    output$contents <- renderPrint({
        if (input$submitbutton>0) { 
            isolate("Calculation complete.") 
        } else {
            return("Server is ready for calculation.")
        }
    })
    
    # Prediction results table
    output$tabledata <- renderTable({
        if (input$submitbutton>0) { 
            isolate(datasetInput()) 
        } 
    })
    
}

