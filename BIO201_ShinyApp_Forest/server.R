# # # # # # # # # # # # # # # # # # # # # # # # # 
# ForestExperiment Shiny App - server.R ----------
# # # # # # # # # # # # # # # # # # # # # # # # # 
#
# packages
#
library(shiny)
library(ggplot2)
library(scales)
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
  appName <- "Forest"
  output.dir <-  paste(outputPath, "/", appName, sep="")
  mkdir(output.dir)

    
    # save file name here so that the file can update as new questions are answered
    fileName <- sprintf("%s_%s.csv", format(Sys.time(), "%Y%m%d-%H%M%OS"), digest::digest(runif(1)))
    rmarkdown::output_metadata$set("rsc_output_files" = list(fileName))
    updateTextInput(session, "name", label = NULL, value = session$user,placeholder = NULL)
    # figure parameters
    fig.lwd <- 1.5
    point.size <- 2.5
    max.time <- 12
    line.color <- "#2987D9"
    main.color <- "#2780e3"
    error.bar.color <- "#2987D9"
    text.color <- "#ff7518"
    fig.theme <- theme(title = element_text(size = 16), axis.title = element_text(size = 16), 
                        axis.text = element_text(size = 14), axis.line = element_line(size = fig.lwd),
                        legend.title = element_blank(), legend.text = element_text(size = 14), 
                        legend.position = c(0.15, 0.9), legend.background = element_blank(),
                        strip.text = element_text(size = 16), strip.background = element_blank(), 
                        panel.spacing = unit(0, units = "cm"))
    box.volume <- 500 * 1000  # mL
    # student inputs to be saved
    fields <- c("name", "1A", "1B", "2A", "2B", "2C", "2D", "3A", "3B", "3C", "4A", "4B", "4C", "4D")
    timestamp_fields <- c("name", "nameDate", "nameTime", "1A", "1B", "2A", "2B", "2C", "2D", "3A", "3B", "3C", "4A", "4B", "4C", "4D")
    #
    # functions
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
    sendEmail <- function(subject,email,body) {
      from <- sprintf("<noreply@stonybrook.edu>") # the sender’s name is an optional value
      to <- sprintf( paste("", email, "", sep = ""))
      sendmail(from,to,subject,body,control=list(smtpServer= "localhost"))
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
        if (input$name != "Enter NetID here before beginning Part 1.") {
            shinyjs::show("FeedbackNames")
            shinyjs::enable("1A")
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
    #
    # part 1
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
        shinyjs::show("Feedback1A")
        time_1A <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1A)
        saveTimestamps(answerTimestamps())
        res_1A <- checkAnswer(correct.vec = c("A", "E"), input = input$`1A`)
        cor_1A <- append(answerCorrect(), res_1A)
        answerCorrect(cor_1A)
        saveCorrect(answerCorrect())
    })
    observeEvent(input$Next1B, {
        shinyjs::disable("Next1B")
        shinyjs::show("Intro1B")
        shinyjs::show("1B")
        shinyjs::enable("1B")
        shinyjs::show("Submit1B")
    })
    observeEvent(input$`1B`, {
        if (input$`1B` != "None selected") {
            shinyjs::enable("Submit1B")
        }
    })
    observeEvent(input$Submit1B, {
        shinyjs::disable("1B")
        shinyjs::disable("Submit1B")
        saveData(formData())
        time_1B <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1B)
        saveTimestamps(answerTimestamps())
        res_1B <- 1  # no penalty
        cor_1B <- append(answerCorrect(), res_1B)
        answerCorrect(cor_1B)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback1B")
        shinyjs::show("IntroPart2")
    })
    #
    # part 2
    #
    observeEvent(input$LoggingButton, {
        shinyjs::disable("LoggingButton")
        shinyjs::show("2A")
        shinyjs::show("Submit2A")
    })
    observeEvent(input$`2A`, {
        if (length(input$`2A`) > 0 & input$`2A`[1] != "None selected") {
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
        res_2A <- checkAnswer(correct.vec = c("B", "C"), input = input$`2A`)
        cor_2A <- append(answerCorrect(), res_2A)
        answerCorrect(cor_2A)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback2A")
    })
    observeEvent(input$Next2B, {
        shinyjs::disable("Next2B")
        shinyjs::show("2B")
        shinyjs::show("Submit2B")
        shinyjs::show("LoggingBiomassButton")
    })
    observeEvent(input$`2B`, {
        if (input$`2B` != "None selected") {
            shinyjs::enable("Submit2B")
        }
    })
    observeEvent(input$Submit2B, {
        shinyjs::disable("2B")
        shinyjs::disable("Submit2B")
        saveData(formData())
        time_2B <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2B)
        saveTimestamps(answerTimestamps())
        res_2B <- checkAnswer(correct.vec = c("A"), input = input$`2B`)
        cor_2B <- append(answerCorrect(), res_2B)
        answerCorrect(cor_2B)
        saveCorrect(answerCorrect())
        shinyjs::enable("LoggingBiomassButton")
    })
    observeEvent(input$LoggingBiomassButton, {
        shinyjs::disable("LoggingBiomassButton")
        shinyjs::show("Feedback2B")
    })
    observeEvent(input$Next2C, {
        shinyjs::disable("Next2C")
        shinyjs::show("Intro2C")
        shinyjs::show("2C")
        shinyjs::show("Submit2C")
    })
    observeEvent(input$`2C`, {
        if (length(input$`2C`) > 0 & input$`2C`[1] != "None selected") {
            shinyjs::enable("Submit2C")
        }
    })
    observeEvent(input$Submit2C, {
        shinyjs::disable("2C")
        shinyjs::disable("Submit2C")
        saveData(formData())
        time_2C <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2C)
        saveTimestamps(answerTimestamps())
        res_2C <- checkAnswer(correct.vec = c("A", "B"), input = input$`2C`)
        cor_2C <- append(answerCorrect(), res_2C)
        answerCorrect(cor_2C)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback2C")
    })
    observeEvent(input$Next2D, {
        shinyjs::disable("Next2D")
        shinyjs::show("Intro2D")
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
        saveData(formData())
        time_2D <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2D)
        saveTimestamps(answerTimestamps())
        cor_2D <- append(answerCorrect(), ifelse(identical(input$`2D`, "D"), 1, 0))
        answerCorrect(cor_2D)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback2D")
        shinyjs::show("IntroPart3")
        shinyjs::show("3A")
        shinyjs::show("Submit3A")
        shinyjs::show("PhotosynthesisButton")
    })
    #
    # part 3
    #
    observeEvent(input$`3A`, {
        if (input$`3A` != "None selected") {
            shinyjs::enable("Submit3A")
        }
    })
    observeEvent(input$Submit3A, {
        shinyjs::disable("3A")
        shinyjs::disable("Submit3A")
        saveData(formData())
        time_3A <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_3A)
        saveTimestamps(answerTimestamps())
        res_3A <- checkAnswer(correct.vec = c("C"), input = input$`3A`)
        cor_3A <- append(answerCorrect(), res_3A)
        answerCorrect(cor_3A)
        saveCorrect(answerCorrect())
        shinyjs::enable("PhotosynthesisButton")
    })
    observeEvent(input$PhotosynthesisButton, {
        shinyjs::disable("PhotosynthesisButton")
        shinyjs::show("Feedback3A")
    })
    observeEvent(input$Next3B, {
        shinyjs::disable("Next3B")
        shinyjs::show("3B")
        shinyjs::enable("3B")
        shinyjs::show("Submit3B")
    })
    observeEvent(input$`3B`, {
        if (input$`3B` != "None selected") {
            shinyjs::enable("Submit3B")
        }
    })
    observeEvent(input$Submit3B, {
        shinyjs::disable("3B")
        shinyjs::disable("Submit3B")
        saveData(formData())
        time_3B <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_3B)
        saveTimestamps(answerTimestamps())
        res_3B <- checkAnswer(correct.vec = c("E"), input = input$`3B`)
        cor_3B <- append(answerCorrect(), res_3B)
        answerCorrect(cor_3B)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback3B")
    })
    observeEvent(input$Next3C, {
        shinyjs::disable("Next3C")
        shinyjs::show("3C")
        shinyjs::show("Submit3C")
    })
    observeEvent(input$`3C`, {
        if (input$`3C` != "None selected") {
            shinyjs::enable("Submit3C")
        }
    })
    observeEvent(input$Submit3C, {
        shinyjs::disable("3C")
        shinyjs::disable("Submit3C")
        saveData(formData())
        time_3C <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_3C)
        saveTimestamps(answerTimestamps())
        cor_3C <- append(answerCorrect(), ifelse(identical(input$`3C`, "A"), 1, 0))
        answerCorrect(cor_3C)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback3C")
        shinyjs::show("IntroPart4")
        shinyjs::show("CellularRespirationButton")
    })
    #
    # part 4
    #
    observeEvent(input$CellularRespirationButton, {
        shinyjs::disable("CellularRespirationButton")
        shinyjs::show("CellularRespirationPlotShow")
        shinyjs::show("4A")
        shinyjs::show("Submit4A")
    })
    observeEvent(input$`4A`, {
        if (input$`4A` != "None selected") {
            shinyjs::enable("Submit4A")
        }
    })
    observeEvent(input$Submit4A, {
        shinyjs::disable("4A")
        shinyjs::disable("Submit4A")
        saveData(formData())
        time_4A <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_4A)
        saveTimestamps(answerTimestamps())
        cor_4A <- append(answerCorrect(), ifelse(identical(input$`4A`, "D"), 1, 0))
        answerCorrect(cor_4A)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback4A")
    })
    observeEvent(input$Next4B, {
        shinyjs::disable("Next4B")
        shinyjs::show("4B")
        shinyjs::show("Submit4B")
    })
    observeEvent(input$`4B`, {
        if (input$`4B` != "None selected") {
            shinyjs::enable("Submit4B")
        }
    })
    observeEvent(input$Submit4B, {
        shinyjs::disable("4B")
        shinyjs::disable("Submit4B")
        saveData(formData())
        time_4B <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_4B)
        saveTimestamps(answerTimestamps())
        res_4B <- checkAnswer(correct.vec = c("A"), input = input$`4B`)
        cor_4B <- append(answerCorrect(), res_4B)
        answerCorrect(cor_4B)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback4B")
    })
    observeEvent(input$Next4C, {
        shinyjs::disable("Next4C")
        shinyjs::show("4C")
        shinyjs::show("Submit4C")
    })
    observeEvent(input$`4C`, {
        if (length(input$`4C`) > 0 & input$`4C`[1] != "None selected") {
            shinyjs::enable("Submit4C")
        }
    })
    observeEvent(input$Submit4C, {
        shinyjs::disable("4C")
        shinyjs::disable("Submit4C")
        saveData(formData())
        time_4C <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_4C)
        saveTimestamps(answerTimestamps())
        res_4C <- checkAnswer(correct.vec = c("B", "D"), input = input$`4C`)
        cor_4C <- append(answerCorrect(), res_4C)
        answerCorrect(cor_4C)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback4C")
    })
    observeEvent(input$NextIntro4D, {
        shinyjs::disable("NextIntro4D")
        shinyjs::show("Intro4D")
    })
    observeEvent(input$PhotoRespButton, {
        shinyjs::disable("PhotoRespButton")
        shinyjs::show("ComparePhotoRespPlotShow")
        shinyjs::show("4D")
        shinyjs::show("Submit4D")
    })
    observeEvent(input$`4D`, {
        if (length(input$`4D`) > 0 & input$`4D`[1] != "None selected") {
            shinyjs::enable("Submit4D")
        }
    })
    observeEvent(input$Submit4D, {
        shinyjs::disable("4D")
        shinyjs::disable("Submit4D")
        saveData(formData())
        time_4D <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_4D)
        saveTimestamps(answerTimestamps())
        res_4D <- checkAnswer(correct.vec = c("A", "B", "C"), input = input$`4D`)
        cor_4D <- append(answerCorrect(), res_4D)
        answerCorrect(cor_4D)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback4D")
        sendEmail("BIO 201 Forest Experiment Completed",session$user,"BIO 201 Forest Experiment Completed")
    })
    #
    # part 1 figures
    #
    LoggingOutput <- eventReactive(input$LoggingButton, {
        # Data from Mazzei et al. 2010
        # pre-logging aboveground biomass
        initial.agb <- 409.8  # Mg/ha
        # total aboveground biomass harvested or destroyed post-logging
        harvested.agb <- 69.3  # Mg/ha
        destroyed.agb <- 25.2  # Mg/ha
        logging.df <- data.frame(Group = c("Mass before\nlogging", "Mass after\nlogging", "Mass after\nlogging", "Mass after\nlogging"),
                                Label = c("Live trees", "Live trees", "Harvested trees", "Trees killed\nduring logging"), 
                                Biomass = 1000000 * 0.5 * c(initial.agb, initial.agb - harvested.agb - destroyed.agb, harvested.agb, destroyed.agb))
    })
    output$LoggingPlot <- renderPlot({
        logging.df <- LoggingOutput()
        logging.df$Group <- factor(logging.df$Group, levels = c("Mass before\nlogging", "Mass after\nlogging"))
        logging.df$Label <- factor(logging.df$Label, levels = c("Live trees", "Harvested trees", "Trees killed\nduring logging"))
        ggplot(data = logging.df, aes(x = Label, y = Biomass)) + 
            facet_grid(. ~ Group, scales = "free_x", space = "free_x", switch = "x") +
            geom_col(fill = main.color) + 
            scale_y_continuous(labels = comma, breaks = seq(0, 200000000, by = 50000000), 
                sec.axis = sec_axis(~ . / 1000000, breaks = seq(0, 200, by = 50), name = "Equivalent mass in cars")) +
            labs(y = "Carbon (g)", title = "2A", subtitle = "Carbon in trees in one hectare of forest\nbefore and after logging") + 
            theme_bw() + fig.theme + theme(strip.placement = "outside", axis.title.x = element_blank())
    })
    LoggingBiomassOutput <- eventReactive(input$LoggingBiomassButton, {
        time <- c(0, 1.247, 3.513, 6.233, 9.18, 12.353, 15.413, 19.607, 23.573, 28.22, 33.32, 38.533, 43.293, 47.373, 51.453)
        year <- time + 2004
        agb <- c(409.8, 315.3, 331.36, 341.44, 351.52, 355.84, 360.88, 365.92, 370.96, 378.16, 384.64, 391.84, 398.32, 403.36, 409.84)
        agb <- agb / 2  # biomass is 50% carbon
        agb <- agb * 1000000
        biomass.df <- data.frame(Year = year, AGB = agb)
    })
    output$LoggingBiomassPlot <- renderPlot({
        biomass.df <- LoggingBiomassOutput()
        ggplot(biomass.df, aes(x = Year, y = AGB, frame = Year, cumulative = TRUE)) + 
            geom_point(size = point.size, color = "#0571b0") + geom_line(size = fig.lwd, color = main.color) +
            geom_vline(xintercept = 2005, linetype = "dashed", color = "gray40") +
            annotate("text", label = "Logging", x = 2006, y = 190000000, size = 6, angle = 90, vjust = 0.5, color = "gray40") +
            scale_x_continuous(breaks = seq(2004, 2058, 4)) +
            scale_y_continuous(labels = comma, breaks = seq(0, 240000000, by = 5000000), 
                sec.axis = sec_axis(~ . / 1000000, breaks = seq(0, 300, by = 5), name = "Equivalent mass in cars")) +
            labs(x = "Year", y = "Carbon (in g)", subtitle = "Tree biomass in one hectare of forest over time") +
            theme_bw() + fig.theme
    })
    #
    # part 2 figures
    #
    PhysiologyOutput <- eventReactive(input$PhotosynthesisButton, {
        # whole forest physiology Chambers et al. 2004
        # estimates of photosynthesis and respiration of an entire forest
        # all units are Mg C per hectare per year
        # scale to fit Mazzei et al. example: factor of 6.878307
        scaling.factor <- 6.878307
        resp <- 21 / scaling.factor # ecosystem autotroph respiration from Chambers et al. 2004
        leaf.prod <- 3.3 / scaling.factor  # net primary production (leaves) from Chambers et al. 2001
        wood.prod <- 3.2 / scaling.factor  # net primary production (wood) from Chambers et al. 2001
        phot <- resp + leaf.prod + wood.prod  # total C taken in for photosynthesis
        year.vec <- 0:50
        resp.pred <- -(year.vec * resp + rnorm(n = length(year.vec), mean = 0, sd = 0.2 * resp))
        phot.pred <- year.vec * phot + rnorm(n = length(year.vec), mean = 0, sd = 0.2 * phot)
        net.pred <- phot.pred + resp.pred
        proc.labs <- c("C released (respiration)", "C taken in (photosynthesis)", "net C in trees")
        physiology.df <- data.frame(Year = 2004:2054, Value = 1000000 * c(resp.pred, phot.pred, net.pred), 
                              Process = c(rep(proc.labs[1], length(resp.pred)), rep(proc.labs[2], length(phot.pred)),
                                          rep(proc.labs[3], length(net.pred))))
    })
    output$PhotosynthesisPlot <- renderPlot({
        physiology.df <- PhysiologyOutput()
        proc.labs <- c("C released (respiration)", "C taken in (photosynthesis)", "net C in trees")
        physiology.df$Process <- factor(physiology.df$Process, levels = proc.labs[c(2, 1, 3)])
        year.seq <- seq(2004, 2054, 4)
        ggplot(subset(physiology.df, Process == proc.labs[2]), aes(x = Year, y = Value, frame = Year, cumulative = TRUE)) + 
            geom_point(size = point.size, color = "#82cf68") + 
            geom_line(size = fig.lwd, color = "#82cf68") +
            scale_x_continuous(breaks = year.seq) + 
            scale_y_continuous(labels = comma, breaks = seq(0, 1400000000, by = 50000000), 
                sec.axis = sec_axis(~ . / 1000000, breaks = seq(0, 2000, by = 50), name = "Equivalent mass in cars")) +
            labs(x = "Year", y = "Carbon (in g)", title = "Carbon taken in for photosynthesis by trees\nin one forest hectare") +
            theme_bw() + fig.theme
    })
    #
    # part 3 figures
    #
    output$CellularRespirationPlot <- renderPlot({
        physiology.df <- PhysiologyOutput()
        proc.labs <- c("C released (respiration)", "C taken in (photosynthesis)", "net C in trees")
        physiology.df$Process <- factor(physiology.df$Process, levels = proc.labs[c(2, 1, 3)])
        year.seq <- seq(2004, 2054, 4)
        ggplot(subset(physiology.df, Process == proc.labs[1]), aes(x = Year, y = -Value, frame = Year, cumulative = TRUE)) + 
            geom_point(size = point.size, color = main.color) + geom_line(size = fig.lwd, color = main.color) +
            scale_x_continuous(breaks = year.seq) +
            scale_y_continuous(labels = comma, breaks = seq(0, 1400000000, by = 50000000), 
                sec.axis = sec_axis(~ . / 1000000, breaks = seq(0, 2000, by = 50), name = "Equivalent mass in cars"),) +
            labs(x = "Year", y = "Carbon (in g)", title = "Carbon released for cellular respiration by trees\nin one forest hectare") +
            theme_bw() + fig.theme
    })
    #
    # part 4 figures
    #
    output$ComparePhotoRespPlot <- renderPlot({
        physiology.df <- PhysiologyOutput()
        proc.labs <- c("C released (respiration)", "C taken in (photosynthesis)", "net C in trees")
        physiology.df$Process <- factor(physiology.df$Process, levels = proc.labs[c(2, 1, 3)])
        year.seq <- seq(2004, 2054, 4)
        ggplot(physiology.df, aes(x = Year, y = Value, frame = Year, color = Process, cumulative = TRUE)) + 
            geom_point(size = point.size) + geom_line(size = fig.lwd) +
            scale_x_continuous(breaks = year.seq) +
            scale_y_continuous(labels = comma, breaks = seq(-1400000000, 1400000000, by = 50000000), 
                sec.axis = sec_axis(~ . / 1000000, breaks = seq(-2000, 2000, by = 50), name = "Equivalent mass in cars")) +
            scale_color_manual(name = "", values = c("#82cf68", main.color, "#ffa568")) +
            labs(x = "Year", y = "Carbon (in g)", title = "Movement of carbon in living trees in one forest hectare") +
            theme_bw() + fig.theme + theme(legend.position = c(0.25, 0.15))
    })
}
)