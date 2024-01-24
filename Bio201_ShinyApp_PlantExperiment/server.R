# # # # # # # # # # # # # # # # # # # # # # # # # 
# PlantExperiment Shiny App - server.R ----------
# # # # # # # # # # # # # # # # # # # # # # # # # 
#
# packages
#
library(shiny)
library(ggplot2)
library(shinythemes)
library(shinyjs)
library(icesTAF)
library(sendmailR)
#
shinyServer(function(input, output, session) {
    # variables used in multiple functions
    #
    # output directory to use when saving locally


  
  outputPath <- "/apps-data"
  appName <- "Plant"
  output.dir <-  paste(outputPath, "/", appName, sep="")
  mkdir(output.dir)
    # save file name here so that the file can update as new questions are answered
    fileName <- sprintf("%s_%s.csv", format(Sys.time(), "%Y%m%d-%H%M%OS"), digest::digest(runif(1)))
    rmarkdown::output_metadata$set("rsc_output_files" = list(fileName))
    updateTextInput(session, "name", label = NULL, value =session$user,placeholder = NULL)
     # figure parameters
    fig.lwd <- 1.5
    point.size <- 2.5
    max.time <- 12
    line.color <- "#2987D9"
    error.bar.color <- "#2987D9"
    text.color <- "#ff7518"
    fig.theme <- theme(title = element_text(size = 18), axis.title = element_text(size = 18), 
                        axis.text = element_text(size = 16), axis.line = element_line(size = fig.lwd),
                        legend.title = element_blank(), legend.text = element_text(size = 16), 
                        legend.position = c(0.15, 0.9), legend.background = element_blank(),
                        strip.text = element_text(size = 18), strip.background = element_blank(), 
                        panel.spacing = unit(0, units = "cm"))
    box.volume <- 500 * 1000  # mL
    # student inputs to be saved
    fields <- c("name", "PB1A", "PB1B", "PB1C", "PB2A", "PB2B", "PB2C", "PB2D", "1A", "1B", "1C", "1D", "1E", "1F", "2A", "2B", "2C", "2D", "2E")
    timestamp_fields <- c("name", "nameDate", "nameTime", "PB1A", "PB1B", "PB1C", "PB2A", "PB2B", "PB2C", "PB2D", "1A", "1B", "1C", "1D", "1E", "1F", "2A", "2BC", "2D", "2E")
    #
    # functions
    
    sendEmail <- function(subject,email,body) {
      from <- sprintf("<noreply@stonybrook.edu>") # the sender’s name is an optional value
      to <- sprintf( paste("", email, "", sep = ""))
      sendmail(from,to,subject,body,control=list(smtpServer= "localhost"))
      
    }

    checkAnswer <- function(correct.vec, input) {
        output <- pmax((sum(correct.vec %in% input) - length(which(input %in% correct.vec == FALSE))) / length(correct.vec), 0)   
    }
    saveData <- function(data) {
        # write student inputs to file
        data <- t(data)
        # save locally
        write.table(x = data, file = paste(output.dir, "/responses_", fileName, sep = ""), sep = ",", row.names = FALSE)
    }
    saveCorrect <- function(correct) {
        # write student inputs to file
        correct <- t(correct)
        colnames(correct) <- fields[1:length(correct)]
        # save locally
        write.table(x = correct, file = paste(output.dir, "/correct_", fileName, sep = ""), sep = ",", row.names = FALSE)
    }
    saveTimestamps <- function(timestamps) {
        # write student inputs to file
        timestamps <- t(timestamps)
        colnames(timestamps) <- timestamp_fields[1:length(timestamps)]
        # save locally
        write.table(x = timestamps, file = paste(output.dir, "/timestamps_", fileName, sep = ""), sep = ",", row.names = FALSE)
    }
    ClosedBox <- function(max.time) {
        # simulate data for experiment 2: mass of entire closed cage
        closed.cage.mass <- numeric(length = max.time)
        closed.cage.mass[1] <- 1000  # g
        for (t in 2:max.time) {
            # small fluctuations because of measurement error
            closed.cage.mass[t] <- closed.cage.mass[1] + rnorm(n = 1, mean = 0, sd = 0.01)
        }
        closed.cage.mass.df <- data.frame(Time = 1:max.time, Mass = closed.cage.mass)
        return(closed.cage.mass.df)
    }
    AirMass <- function(max.time) {
        # simulate data for experiment 2: mass of air
        #
        # mass of O2 and CO2 depends on the sunflower mass
        sunflower.mass <- numeric(length = max.time)
        sunflower.mass[1] <- 0.45  # g
        sunflower.leaf.area <- numeric(length = max.time)
        sunflower.leaf.area[1] <- 0.07564 / 20  # m2
        # gas percentages in air
        percent.CO2 <- 0.000407
        percent.O2 <- 0.20946
        percent.N2 <- 0.78084
        percent.Ar <- 0.00934
        # density of gases at STP, g/mL
        density.CO2 <- 0.001977
        density.O2 <- 0.001429
        density.N2 <- 0.0012506
        density.Ar <- 0.001784
        # assume N2 and argon do not change, assume other gases are negligible
        N2.mass <- box.volume * percent.N2 * density.N2
        Ar.mass <- box.volume * percent.Ar * density.Ar
        #
        # sunflower metabolism of CO2 and O2
        # sunflower relative growth rate about equal for leaf area or mass
        sunflower.growth.rate <- 0.004167  # m2 / (m2 * hr) OR g / (g * hr)
        sunflower.CO2.rate <- -1.84  # in g / (m2 * hr)
        sunflower.O2.rate <- 0.178 # in g / (m2 * hr)
        CO2.mass <- numeric(length = max.time)
        CO2.mass[1] <- box.volume * percent.CO2 * density.CO2
        O2.mass <- numeric(length = max.time)
        O2.mass[1] <- box.volume * percent.O2 * density.O2
        for (t in 2:max.time) {
            CO2.mass[t] <- CO2.mass[t - 1] + sunflower.CO2.rate * sunflower.leaf.area[t - 1]
            O2.mass[t] <- O2.mass[t - 1] + sunflower.O2.rate * sunflower.leaf.area[t - 1]
            sunflower.leaf.area[t] <- sunflower.leaf.area[t - 1] + sunflower.growth.rate * sunflower.leaf.area[t - 1]
            sunflower.mass[t] <- sunflower.mass[t - 1] + sunflower.growth.rate * sunflower.mass[t - 1]
        }
        air.mass.df <- data.frame(Time = 1:max.time, CO2Mass = CO2.mass, O2Mass = O2.mass, 
            AirMass = N2.mass + Ar.mass + CO2.mass + O2.mass)
        return(air.mass.df)
    }
    #
    # elements controlling reactive user interface
    #
    # rules
    # 1. after answers are selected, question is disabled
    # 2. follow up questions are hidden until answer is selected (questions shown sequentially)
    #
    answerTimestamps <- reactiveVal(NULL)
    answerCorrect <- reactiveVal(NULL)
    formData <- reactive({
        # whenever a field is filled, aggregate all form data
        data <- sapply(fields, function(x) paste(input[[x]], sep = "", collapse = ""))
        data
    })
    observeEvent(input$NameButton, {
        if (input$name != "Enter email address here before beginning Plant Basics 1.") {
            shinyjs::show("FeedbackNames")
            shinyjs::enable("PB1A")
            saveData(formData())
            answerTimestamps(input$name)
            saveTimestamps(answerTimestamps())
            answerCorrect(input$name)
            saveCorrect(answerCorrect())
            new_val <- append(answerTimestamps(), format(Sys.time(), "%Y/%m/%d"))
            answerTimestamps(new_val)
            saveTimestamps(answerTimestamps())
            new_val <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
            answerTimestamps(new_val)
            saveTimestamps(answerTimestamps())
            }
    })
    # plant basics
    #
    observeEvent(input$PB1A, {
        if (length(input$PB1A) > 0 & input$PB1A[1] != "None selected") {
            shinyjs::enable("SubmitPB1A")
        }
    })
    observeEvent(input$SubmitPB1A, {
        shinyjs::disable("PB1A")
        shinyjs::disable("SubmitPB1A")
        saveData(formData())
        shinyjs::show("FeedbackPB1A")
        time_PB1A <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_PB1A)
        saveTimestamps(answerTimestamps())
        PB1A <- checkAnswer(correct.vec = c("A", "B", "C", "D"), input = input$PB1A)
        cor_PB1A <- append(answerCorrect(), PB1A)
        answerCorrect(cor_PB1A)
        saveCorrect(answerCorrect())
    })
    observeEvent(input$NextWetDryMass, {
        shinyjs::disable("NextWetDryMass")
        shinyjs::show("WetDryMass")
    })
    observeEvent(input$NextAtomConcentration, {
        shinyjs::disable("NextAtomConcentration")
        shinyjs::show("AtomConcentration")
    })
    observeEvent(input$AtomConcentrationButton, {
        shinyjs::disable("AtomConcentrationButton")
        shinyjs::show("PB1B")
        shinyjs::show("SubmitPB1B")
    })
    observeEvent(input$PB1B, {
        if (length(input$PB1B) > 0 & input$PB1B[1] != "None selected") {
            shinyjs::enable("SubmitPB1B")
        }
    })
    observeEvent(input$SubmitPB1B, {
        shinyjs::disable("PB1B")
        shinyjs::disable("SubmitPB1B")
        saveData(formData())
        time_PB1B <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_PB1B)
        saveTimestamps(answerTimestamps())
        PB1B <- checkAnswer(correct.vec = c("A", "C"), input = input$PB1B)
        cor_PB1B <- append(answerCorrect(), PB1B)
        answerCorrect(cor_PB1B)
        saveCorrect(answerCorrect())
        shinyjs::show("FeedbackPB1B")
    })
    observeEvent(input$NextCellulose, {
        shinyjs::disable("NextCellulose")
        shinyjs::show("Cellulose")
    })
    
    
    observeEvent(input$NutrientCompositionButton, {
        shinyjs::disable("NutrientCompositionButton")
        shinyjs::show("PB1C")
        shinyjs::show("SubmitPB1C")
    })
    observeEvent(input$PB1C, {
        if (length(input$PB1C) > 0 & input$PB1C[1] != "None selected") {
            shinyjs::enable("SubmitPB1C")
        }
    })
    observeEvent(input$SubmitPB1C, {
        shinyjs::disable("PB1C")
        shinyjs::disable("SubmitPB1C")
        saveData(formData())
        time_PB1C <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_PB1C)
        saveTimestamps(answerTimestamps())
        PB1C <- checkAnswer(correct.vec = c("A", "B", "C"), input = input$PB1C)
        cor_PB1C <- append(answerCorrect(), PB1C)
        answerCorrect(cor_PB1C)
        saveCorrect(answerCorrect())
        shinyjs::show("FeedbackPB1C")
        shinyjs::show("PlantMass")
    })
    
    
    observeEvent(input$AtomMassesButton, {
        shinyjs::disable("AtomMassesButton")
        shinyjs::show("AtomMassesCaption")
        shinyjs::show("PB2A")
        shinyjs::show("SubmitPB2A")
    })
    observeEvent(input$PB2A, {
        if (length(input$PB2A) > 0 & input$PB2A[1] != "None selected") {
            shinyjs::enable("SubmitPB2A")
        }
    })
    observeEvent(input$SubmitPB2A, {
        shinyjs::disable("PB2A")
        shinyjs::disable("SubmitPB2A")
        saveData(formData())
        time_PB2A <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_PB2A)
        saveTimestamps(answerTimestamps())
        PB2A <- checkAnswer(correct.vec = c("A", "C"), input = input$PB2A)
        cor_PB2A <- append(answerCorrect(), PB2A)
        answerCorrect(cor_PB2A)
        saveCorrect(answerCorrect())
        shinyjs::show("FeedbackPB2A")
    })
    observeEvent(input$NextGasCanisters, {
        shinyjs::disable("NextGasCanisters")
        shinyjs::show("GasCanistersIntro")
        shinyjs::show("PB2B")
        shinyjs::show("SubmitPB2B")
    })
    observeEvent(input$PB2B, {
        if (input$PB2B[1] != "None selected") {
            shinyjs::enable("SubmitPB2B")
        }
    })
    observeEvent(input$SubmitPB2B, {
        shinyjs::disable("PB2B")
        shinyjs::disable("SubmitPB2B")
        saveData(formData())
        time_PB2B <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_PB2B)
        saveTimestamps(answerTimestamps())
        cor_PB2B <- append(answerCorrect(), ifelse(identical(input$PB2B, "C"), 1, 0))
        answerCorrect(cor_PB2B)
        saveCorrect(answerCorrect())
        shinyjs::show("FeedbackPB2B")
    })
    observeEvent(input$NextMoleculeMasses, {
        shinyjs::disable("NextMoleculeMasses")
        shinyjs::show("MoleculeMasses")
        shinyjs::show("PB2C")
        shinyjs::show("SubmitPB2C")
    })
    observeEvent(input$PB2C, {
        if (input$PB2C[1] != "None selected") {
            shinyjs::enable("SubmitPB2C")
        }
    })
    observeEvent(input$SubmitPB2C, {
        shinyjs::disable("PB2C")
        shinyjs::disable("SubmitPB2C")
        saveData(formData())
        time_PB2C <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_PB2C)
        saveTimestamps(answerTimestamps())
        cor_PB2C <- append(answerCorrect(), ifelse(identical(input$PB2C, "C"), 1, 0))
        answerCorrect(cor_PB2C)
        saveCorrect(answerCorrect())
        shinyjs::show("FeedbackPB2C")
        shinyjs::show("CelluloseMasses")
    })
    observeEvent(input$CelluloseMassesButton, {
        shinyjs::disable("CelluloseMassesButton")
        shinyjs::show("CelluloseMassesCaption")
    })
    observeEvent(input$NextPhotosynthesis, {
        shinyjs::disable("NextPhotosynthesis")
        shinyjs::show("Photosynthesis")
    })
    observeEvent(input$NextRespiration, {
        shinyjs::disable("NextRespiration")
        shinyjs::show("Respiration")
        shinyjs::show("PB2D")
        shinyjs::show("SubmitPB2D")
    })
    observeEvent(input$PB2D, {
        if (length(input$PB2D) > 0 & input$PB2D[1] != "None selected") {
            shinyjs::enable("SubmitPB2D")
        }
    })
    observeEvent(input$SubmitPB2D, {
        shinyjs::disable("PB2D")
        shinyjs::disable("SubmitPB2D")
        saveData(formData())
        time_PB2D <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_PB2D)
        saveTimestamps(answerTimestamps())
        PB2D <- checkAnswer(correct.vec = c("A", "B", "C"), input = input$PB2D)
        cor_PB2D <- append(answerCorrect(), PB2D)
        answerCorrect(cor_PB2D)
        saveCorrect(answerCorrect())
        shinyjs::show("FeedbackPB2D")
    })
    observeEvent(input$NextGrowth, {
        shinyjs::disable("NextGrowth")
        shinyjs::show("Growth")
        shinyjs::show("Experiment1Intro")
        shinyjs::show("1A")
        shinyjs::enable("1A")
        shinyjs::show("Submit1A")
    })
    # experiment 1
    #
    observeEvent(input$`1A`, {
        if (length(input$`1A`) > 0 & input$`1A`[1] != "None selected") {
            shinyjs::enable("Submit1A")
        }
    })
    observeEvent(input$Submit1A, {
        shinyjs::disable("1A")
        shinyjs::disable("Submit1A")
        saveData(formData())
        time_1A <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1A)
        saveTimestamps(answerTimestamps())
        res1A <- checkAnswer(correct.vec = c("B", "C", "D"), input = input$`1A`)
        cor_1A <- append(answerCorrect(), res1A)
        answerCorrect(cor_1A)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback1A")
    })
    observeEvent(input$Next1B, {
        shinyjs::disable("Next1B")
        shinyjs::show("PlantInitialFinal")
        shinyjs::show("1B")
        shinyjs::show("Submit1B")
        shinyjs::show("Experiment1PlantData")
    })
    observeEvent(input$`1B`, {
        if (input$`1B` != "None selected") {
            shinyjs::enable("Submit1B")
        }
    })
    observeEvent(input$Submit1B, {
        shinyjs::disable("1B")
        shinyjs::disable("Submit1B")
        shinyjs::enable("Experiment1PlantData")
        saveData(formData())
        time_1B <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1B)
        saveTimestamps(answerTimestamps())
        cor_1B <- append(answerCorrect(), ifelse(identical(input$`1B`, "B"), 1, 0))
        answerCorrect(cor_1B)
        saveCorrect(answerCorrect())
    })
    observeEvent(input$Experiment1PlantData, {
        shinyjs::disable("Experiment1PlantData")
        shinyjs::show("Feedback1B")
    })
    observeEvent(input$Next1C, {
        shinyjs::disable("Next1C")
        shinyjs::show("1C")
        shinyjs::show("Submit1C")
        shinyjs::show("PlantWetMass")
    })
    observeEvent(input$`1C`, {
        if (input$`1C` != "None selected") {
            shinyjs::enable("Submit1C")
        }
    })
    observeEvent(input$Submit1C, {
        shinyjs::disable("1C")
        shinyjs::disable("Submit1C")
        saveData(formData())
        time_1C <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1C)
        saveTimestamps(answerTimestamps())
        cor_1C <- append(answerCorrect(), ifelse(identical(input$`1C`, "A"), 1, 0))
        answerCorrect(cor_1C)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback1C")
    })
    observeEvent(input$Next1D, {
        shinyjs::disable("Next1D")
        shinyjs::show("1D")
        shinyjs::show("Submit1D")
        shinyjs::show("PlantDryMass")
    })
    observeEvent(input$`1D`, {
        if (length(input$`1D`) > 0 & input$`1D`[1] != "None selected") {
            shinyjs::enable("Submit1D")
        }
    })
    observeEvent(input$Submit1D, {
        shinyjs::disable("1D")
        shinyjs::disable("Submit1D")
        saveData(formData())
        time_1D <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1D)
        saveTimestamps(answerTimestamps())
        res1D <- checkAnswer(correct.vec = c("B", "D"), input = input$`1D`)
        cor_1D <- append(answerCorrect(), res1D)
        answerCorrect(cor_1D)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback1D")
    })
    observeEvent(input$Next1E, {
        shinyjs::show("MeasureSoil")
        shinyjs::disable("Next1E")
        shinyjs::show("1E")
        shinyjs::show("Submit1E")
        shinyjs::show("Experiment1SoilData")
    })
    observeEvent(input$`1E`, {
        if (length(input$`1E`) > 0 & input$`1E`[1] != "None selected") {
            shinyjs::enable("Submit1E")
        }
    })
    observeEvent(input$Submit1E, {
        shinyjs::disable("1E")
        shinyjs::disable("Submit1E")
        saveData(formData())
        time_1E <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1E)
        saveTimestamps(answerTimestamps())
        cor_1E <- append(answerCorrect(), ifelse(identical(input$`1E`, "A"), 1, 0))
        answerCorrect(cor_1E)
        saveCorrect(answerCorrect())
        shinyjs::enable("Experiment1SoilData")
    })
    observeEvent(input$Experiment1SoilData, {
        shinyjs::disable("Experiment1SoilData")
        shinyjs::show("Feedback1E")
    })
    observeEvent(input$Next1F, {
        shinyjs::disable("Next1F")
        shinyjs::show("1F")
        shinyjs::show("Submit1F")
        shinyjs::show("PlantMassDryOnlyPlot")
    })
    observeEvent(input$`1F`, {
        if (input$`1F` != "None selected") {
            shinyjs::enable("Submit1F")
        }
    })
    observeEvent(input$Submit1F, {
        shinyjs::disable("1F")
        shinyjs::disable("Submit1F")
        saveData(formData())
        time_1F <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1F)
        saveTimestamps(answerTimestamps())
        cor_1F <- append(answerCorrect(), ifelse(identical(input$`1F`, "D"), 1, 0))
        answerCorrect(cor_1F)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback1F")
        shinyjs::show("Experiment2IntroA")
        shinyjs::show("Experiment2IntroB")
        shinyjs::show("2A")
        shinyjs::show("Submit2A")
        shinyjs::show("Experiment2")
        shinyjs::enable("2A")
    })
    # experiment 2
    #
    observeEvent(input$`2A`, {
        if (input$`2A` != "None selected") {
            shinyjs::enable("Submit2A")
        }
    })
    observeEvent(input$Submit2A, {
        shinyjs::disable("2A")
        shinyjs::disable("Submit2A")
        saveData(formData())
        time_2A <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2A)
        saveTimestamps(answerTimestamps())
        cor_2A <- append(answerCorrect(), ifelse(identical(input$`2A`, "C"), 1, 0))
        answerCorrect(cor_2A)
        saveCorrect(answerCorrect())
        shinyjs::enable("Experiment2")
    })
    observeEvent(input$Experiment2, {
        shinyjs::disable("Experiment2")
        shinyjs::show("Feedback2A")
    })
    observeEvent(input$NextGasIntro, {
        shinyjs::disable("NextGasIntro")
        shinyjs::show("Experiment2GasIntro")
        shinyjs::show("Experiment2GasIntroPlot")
        shinyjs::show("2B")
        shinyjs::show("2C")
        shinyjs::show("Submit2BC")
        shinyjs::show("Experiment2Air")
    })
    observeEvent(input$`2C`, {
        if ((input$`2B` != "None selected") & (input$`2C` != "None selected")) {
            shinyjs::enable("Submit2BC")
        }
    })
    observeEvent(input$Submit2BC, {
        shinyjs::disable("2B")
        shinyjs::disable("2C")
        shinyjs::disable("Submit2BC")
        saveData(formData())
        time_2BC <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2BC)
        saveTimestamps(answerTimestamps())
        cor_2B <- append(answerCorrect(), ifelse(identical(input$`2B`, "A"), 1, 0))
        answerCorrect(cor_2B)
        saveCorrect(answerCorrect())
        cor_2C <- append(answerCorrect(), ifelse(identical(input$`2C`, "B"), 1, 0))
        answerCorrect(cor_2C)
        saveCorrect(answerCorrect())
        shinyjs::enable("Experiment2Air")
    })
    observeEvent(input$Experiment2Air, {
        shinyjs::disable("Experiment2Air")
        shinyjs::show("2D")
        shinyjs::show("Submit2D")
    })
    observeEvent(input$`2D`, {
        if (input$`2D` != "None selected") {
            shinyjs::enable("Submit2D")
        }
    })
    observeEvent(input$Submit2D, {
        shinyjs::disable("2D")
        shinyjs::disable("Submit2D")
        shinyjs::show("Feedback2D")
        saveData(formData())
        time_2D <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2D)
        saveTimestamps(answerTimestamps())
        cor_2D <- append(answerCorrect(), ifelse(identical(input$`2D`, "A"), 1, 0))
        answerCorrect(cor_2D)
        saveCorrect(answerCorrect())
    })
    observeEvent(input$Next2E, {
        shinyjs::disable("Next2E")
        shinyjs::show("2E")
        shinyjs::show("Submit2E")
    })
    observeEvent(input$`2E`, {
        if (input$`2E` != "None selected") {
            shinyjs::enable("Submit2E")
        }
    })
    observeEvent(input$Submit2E, {
        shinyjs::disable("2E")
        shinyjs::disable("Submit2E")
        shinyjs::show("Feedback2E")
        saveData(formData())
        time_2E <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2E)
        saveTimestamps(answerTimestamps())
        cor_2E <- append(answerCorrect(), ifelse(identical(input$`2E`, "B"), 1, 0))
        answerCorrect(cor_2E)
        saveCorrect(answerCorrect())
        sendEmail("BIO 201 Plant Experiment Completed",session$user,"BIO 201 Plant Experiment Completed")  
    })
    #
    # plant basics 1 figures
    #
    AtomConcentrationOutput <- eventReactive(input$AtomConcentrationButton, {
        element.df <- data.frame(Element = c("Carbon", "Oxygen", "Hydrogen", "Nitrogen", "Potassium", "Calcium", "Magnesium", "Phosphorus", "Sulfur"), 
                            Concentration = c(450, 450, 60, 15, 10, 5, 2, 2, 1))
    })
    output$AtomConcentrationPlot <- renderPlot({
        element.df <- AtomConcentrationOutput()
        ggplot(data = element.df, aes(x = Element, y = Concentration)) + 
            geom_col(width = 0.5, fill = "#ff7518") + 
            scale_y_continuous(expand = c(0, 0), limits = c(0, 500)) +
            coord_flip() +
            labs(x = "Atoms", y = "Concentration (g/kg dry mass)", title = "Concentration of atoms in plant tissues") + 
            theme_bw() + fig.theme
    })
    NutrientCompositionOutput <- eventReactive(input$NutrientCompositionButton, {
        plants.vec <- c("Potato", "Strawberry", "Chickpea", "Walnut")
        nutrient.vec <- c("Protein", "Lipid", "Fructose", "Starch", "Other carbs", "Minerals")
        nutrient.df <- data.frame(Plant = rep(plants.vec, each = 6), 
                                    Nutrient = rep(nutrient.vec, 4),
                                    Concentration = c(2, 0.1, NA, 15.44, 6.919, 0.541,
                                        0.67, 0.3, 2.44, NA, 5.24, 0.4,
                                        2.364, 0.648, NA, 1.764, 3.015, 0.372,
                                        18.1, 67.2, NA, 1.5, 4.9, 2.1))
    })
    output$NutrientCompositionPlot <- renderPlot({
        plants.vec <- c("Potato", "Strawberry", "Chickpea", "Walnut")
        nutrient.vec <- c("Protein", "Lipid", "Fructose", "Starch", "Other carbs", "Minerals")
        nutrient.df <- NutrientCompositionOutput()
        nutrient.df$Plant <- factor(nutrient.df$Plant, levels = plants.vec)
        nutrient.df$Nutrient <- factor(nutrient.df$Nutrient, levels = nutrient.vec)
        ggplot(nutrient.df, aes(fill = Nutrient, y = Concentration, x = Plant)) + 
            geom_bar(position = "fill", stat = "identity", width = 0.5, na.rm = TRUE) +
            scale_fill_manual(values = c("#82cf68", "#ff597e", "#afcced", "#72aced", "#2780e3", "#7c7e80")) +
            labs(y = "Nutrient percentage", x = "") +
            theme_bw() + fig.theme + theme(axis.text.y = element_blank(), legend.position = "right")
    })
    #
    # plant basics 2 figures
    #
    AtomMoleculeMassesOutput <- eventReactive(input$AtomMassesButton, {
        masses.df <- data.frame(Molecule = c("Hydrogen", "Carbon", "Oxygen", "Water", "Carbon\ndioxide", "Glucose", "Cellulose"), 
                        Mass = c(1.008, 12.011, 15.999, 18.015, 44.009, 180.156, 162.1406 * 800), Group = c("Atoms", "Atoms", "Atoms", "Molecules", "Molecules", "Molecules", "Molecules"))
    })
    output$AtomMassesPlot <- renderPlot({
        masses.df <- AtomMoleculeMassesOutput()
        masses.df$Molecule <- factor(masses.df$Molecule, levels = c("Hydrogen", "Carbon", "Oxygen", "Water", "Carbon\ndioxide", "Glucose", "Cellulose"))
        ggplot(data = masses.df[1:3, ], aes(x = Molecule, y = Mass)) + 
            geom_col(width = 0.5, fill = error.bar.color) + scale_y_continuous(expand = c(0, 0)) +
            labs(x = NULL, y = "Mass", title = "Relative masses of atoms") + 
            theme_bw() + fig.theme + theme(axis.text.y = element_blank())
    })
    output$MoleculeMassesPlot <- renderPlot({
        masses.df <- AtomMoleculeMassesOutput()
        masses.df$Molecule <- factor(masses.df$Molecule, levels = c("Hydrogen", "Carbon", "Oxygen", "Water", "Carbon\ndioxide", "Glucose", "Cellulose"))
        ggplot(data = masses.df[-7, ], aes(x = Molecule, y = Mass)) + 
            facet_grid(. ~ Group, scales = "free_x", space = "free_x") +
            geom_col(width = 0.5, fill = error.bar.color) + scale_y_continuous(expand = c(0, 0)) + 
            labs(x = NULL, y = "Mass", title = "Relative masses of atoms and molecules") + 
            theme_bw() + fig.theme + theme(axis.text.y = element_blank())
    })
    output$CelluloseMassesPlot <- renderPlot({
        masses.df <- AtomMoleculeMassesOutput()
        masses.df$Molecule <- factor(masses.df$Molecule, levels = c("Hydrogen", "Carbon", "Oxygen", "Water", "Carbon\ndioxide", "Glucose", "Cellulose"))
        ggplot(data = masses.df, aes(x = Molecule, y = Mass)) + 
            facet_grid(. ~ Group, scales = "free_x", space = "free_x") +
            geom_col(width = 0.5, fill = error.bar.color) + scale_y_continuous(expand = c(0, 0)) + 
            labs(x = NULL, y = "Mass", title = "Relative masses of atoms and molecules") + 
            theme_bw() + fig.theme + theme(axis.text.y = element_blank())
    })
    #
    # experiment 1 figures
    #
    Experiment1PlantOutput <- eventReactive(input$Experiment1PlantData, {
        plant.mass <- data.frame(Time = c("Day 1", "Day 1", "Day 10", "Day 10"), 
                                MassType = c("Dry mass", "Wet mass", "Dry mass", "Wet mass"), 
                                Mass = c(0.05, 0.45, 1, 9))
    })
    output$PlantMass <- renderPlot({
        plant.mass <- Experiment1PlantOutput()
        ggplot(data = plant.mass, aes(x = Time, y = Mass, group = MassType, fill = MassType)) + 
            annotate(geom = "text", x = "Day 1", y = 1.5, color = "#ff7518",
                        label = paste("Initial dry mass =\n", plant.mass$Mass[1], "g"), size = 6) +
            geom_col(position = position_dodge(width = 0.5), width = 0.5) + 
            scale_fill_manual(values = c("#ff7518", "#2987D9")) + 
            scale_y_continuous(expand = c(0, 0), limits = c(0, 10), breaks = 0:10) +
            labs(x = "Time", y = "Mass of plant (in g)", title = "1B") + 
            theme_bw() + fig.theme
    })
    output$PlantMassDryOnly <- renderPlot({
        plant.mass <- Experiment1PlantOutput()
        ggplot(data = subset(plant.mass, MassType == "Dry mass"), aes(x = Time, y = Mass)) + 
            geom_col(position = position_dodge(width = 0.5), width = 0.5, fill = "#ff7518") + 
            scale_y_continuous(expand = c(0, 0), limits = c(0, 1.5)) +
            labs(x = "Time", y = "Dry mass of plant (in g)", title = "1F") + 
            theme_bw() + fig.theme
    })
    Experiment1SoilOutput <- eventReactive(input$Experiment1SoilData, {
        soil.mass <- data.frame(Time = c("Day 1", "Day 1", "Day 10", "Day 10"), 
                                MassType = c("Dry mass", "Wet mass", "Dry mass", "Wet mass"), 
                                Mass = c(200, 470, 200, 350))
    })
    output$SoilMass <- renderPlot({
        soil.mass <- Experiment1SoilOutput()
        ggplot(data = soil.mass, aes(x = Time, y = Mass, group = MassType, fill = MassType)) + 
            geom_col(position = position_dodge(width = 0.5), width = 0.5) + 
            scale_fill_manual(values = c("#ff7518", "#2987D9")) + 
            scale_y_continuous(expand = c(0, 0), limits = c(0, 500)) +
            labs(x = "Time", y = "Mass of soil (in g)", title = "1E") + 
            theme_bw() + fig.theme
    })
    #
    # experiment 2 figures
    #
    Experiment2Output <- eventReactive(input$Experiment2,{
        closed.box.df <- ClosedBox(max.time)
    })
    output$ClosedBox <- renderPlot({
        ggplot(Experiment2Output(), aes(x = Time, y = Mass)) + geom_point(size = point.size) + 
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, se = FALSE) +
            labs(x = "Time (in hours)", y = "Mass of box and contents (in g)", title = "2A") +
            scale_x_continuous(breaks = 1:max.time) +
            coord_cartesian(ylim = c(995, 1005)) +
            theme_classic() + fig.theme
    })
    output$GasesBarChart <- renderPlot({
    N2.mass <- box.volume * 0.78084 * 0.0012506
    Ar.mass <- box.volume * 0.00934 * 0.001784
    CO2.mass <- box.volume * 0.000407 * 0.001977
    O2.mass <- box.volume * 0.20946 * 0.001429
    gases.masses <- data.frame(Molecule = c("Nitrogen gas", "Oxygen gas", "Argon", "Carbon dioxide"), 
                            Mass = c(N2.mass, O2.mass, Ar.mass, CO2.mass))
    gases.masses$Molecule <- factor(gases.masses$Molecule, levels = c("Nitrogen gas", "Oxygen gas", "Argon", "Carbon dioxide"))
    ggplot(data = gases.masses, aes(x = Molecule, y = Mass)) + 
            geom_col(position = position_dodge(width = 0.5), width = 0.5, fill = "#2987D9") + 
            scale_y_continuous(expand = c(0, 0), limits = c(0, 500)) +
            labs(x = "Gas molecule", y = "Mass (in g)", title = "2BC", subtitle = "Mass of gases in the air at the start of Experiment 2") + 
            theme_bw() + fig.theme
    })
    AirMassOutput <- eventReactive(input$Experiment2Air,{
        air.mass.df <- AirMass(max.time)
    })
    output$CO2Mass <- renderPlot({
        ggplot(AirMassOutput(), aes(x = Time, y = CO2Mass)) + geom_point(size = point.size) +
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, fill = error.bar.color, se = FALSE) +
            labs(x = "Time (in hours)", y = bquote(~CO[2]~ "mass (in g)"), title = "2B") +
            annotate("text", x = 6, y = 0.45, label = "CO[2]~decreases", parse = TRUE, size = 6, color = text.color) +
            scale_x_continuous(breaks = 1:max.time) +
            theme_classic() + fig.theme
    })
    output$O2Mass <- renderPlot({
        ggplot(AirMassOutput(), aes(x = Time, y = O2Mass)) + geom_point(size = point.size) +
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, fill = error.bar.color, se = FALSE) +
            labs(x = "Time (in hours)", y = bquote(~O[2]~ "mass (in g)"), title = "2C") +
            annotate("text", x = 6, y = 149.7, label = "O[2]~increases", parse = TRUE, size = 6, color = text.color) +
            scale_x_continuous(breaks = 1:max.time) +
            theme_classic() + fig.theme
    })
}
)