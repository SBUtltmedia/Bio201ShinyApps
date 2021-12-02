# # # # # # # # # # # # # # # # # # # # # # # # # 
# MouseExperiment Shiny App - server.R ----------
# # # # # # # # # # # # # # # # # # # # # # # # # 
#
# packages
#
library(shiny)
library(ggplot2)
library(shinythemes)
library(shinyjs)
#
shinyServer(function(input, output, session) {
    # variables used in multiple functions
    #
    # output directory to use when saving locally
    output.dir <- getwd()
    # save file name here so that the file can update as new questions are answered
    fileName <- sprintf("%s_%s.csv", format(Sys.time(), "%Y%m%d-%H%M%OS"), digest::digest(runif(1)))
    rmarkdown::output_metadata$set("rsc_output_files" = list(fileName))
    updateTextInput(session, "name", label = NULL, value = paste(session$user,"@stonybrook.edu", sep = ""),placeholder = NULL)
     # figure parameters
    fig.lwd <- 1.5
    point.size <- 2.5
    line.color <- "#60AEE6"
    error.bar.color <- "#80D4FF"
    text.color <- "#ff7518"
    fig.theme <- theme(axis.title = element_text(size = 20), axis.text = element_text(size = 16),  
                       axis.line = element_line(size = fig.lwd), legend.title = element_blank(),
                       legend.text = element_text(size = 14), title = element_text(size = 20))
    max.time <- 12  # hours
    cage.volume <- 500 * 1000  # mL
    # student inputs to be saved
    fields <- c("name", "1A", "1B", "1C", "1D", "1E", "1F", "2A", "2B", "2C", "2D", "2E", "2F", "3A", "3B")
    timestamp_fields <- c("name", "nameDate", "nameTime", "1ABC","1D", "1E", "1F", "2A", "2BC", "2D", "2E", "2F", "3A", "3B")
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
    Experiment1 <- function(max.time) {
        # simulate data for experiment 1: change in food, water, and mouse mass
        food.mass <- numeric(length = max.time)
        food.mass[1] <- 20  # g
        food.rate <- -0.44  # g eaten per hour
        food.rate <- food.rate * 2  # assume all eating happens in the first 6 hours
        water.mass <- numeric(length = max.time)
        water.mass[1] <- 100  # g
        water.rate <- -0.7  # g drank per hour
        mouse.mass <- numeric(length = max.time)
        mouse.mass[1] <- 30  # g
        mouse.rate <- 0.008  # g increase in mass per hour
        for (t in 2:max.time) {
            # slopes of mass change are random draws
            if (t < (max.time / 2)) {
                # mouse only eats in the first 6 hours
                food.mass[t] <- food.mass[1] + food.rate * t - abs(rnorm(n = 1, mean = 0, sd = 0.03))
            } else {
                food.mass[t] <- food.mass[t - 1] - abs(rnorm(n = 1, mean = 0, sd = 0.03))
            }
            water.mass[t] <- water.mass[1] + water.rate * t - abs(rnorm(n = 1, mean = 0, sd = 0.05))
            mouse.mass[t] <- mouse.mass[1] + mouse.rate * t - abs(rnorm(n = 1, mean = 0, sd = 0.002))
        } 
        experiment1.df <- data.frame(Time = 1:max.time, FoodMass = food.mass, WaterMass = water.mass,
                                        MouseMass = mouse.mass)
        return(experiment1.df)
    }
    ClosedCage <- function(max.time) {
        # simulate data for experiment 2: mass of entire closed cage
        closed.cage.mass <- numeric(length = max.time)
        closed.cage.mass[1] <- 2500  # g
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
        # mass of O2 and CO2 depends on the mouse mass
        mouse.mass <- numeric(length = max.time)
        mouse.mass[1] <- 30  # g
        mouse.rate <- 0.008  # g increase mass per hour
        for (t in 2:max.time) {
            mouse.mass[t] <- mouse.mass[1] + rnorm(n = 1, mean = mouse.rate, sd = 0.001) * t
        }
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
        N2.mass <- cage.volume * percent.N2 * density.N2
        Ar.mass <- cage.volume * percent.Ar * density.Ar
        # mouse metabolism of CO2 breathed out and O2 breathed in (borrowed from rat)
        mouse.CO2.rate <- 0.001977  # in g / (g * hr)
        mouse.O2.rate <- -0.0015719
        CO2.mass <- numeric(length = max.time)
        CO2.mass[1] <- cage.volume * percent.CO2 * density.CO2
        O2.mass <- numeric(length = max.time)
        O2.mass[1] <- cage.volume * percent.O2 * density.O2
        for (t in 2:max.time) {
            # error is correlated
            error <- abs(rnorm(n = 1, mean = 0, sd = 0.05))
            CO2.mass[t] <- CO2.mass[t - 1] + mouse.CO2.rate * mouse.mass[t - 1] + error
            O2.mass[t] <- O2.mass[t - 1] + mouse.O2.rate * mouse.mass[t - 1] - error
        }
        air.mass.df <- data.frame(Time = 1:max.time, CO2Mass = CO2.mass, O2Mass = O2.mass, 
            AirMass = N2.mass + Ar.mass + CO2.mass + O2.mass)
        return(air.mass.df)
    }
    OpenCage <- function(max.time) {
        # simulate data for experiment 3: mass of entire open cage
        open.cage.mass <- numeric(length = max.time)
        open.cage.mass[1] <- 2750
        # estimated from change in mouse mass, mouse waste, and mouse food intake
        cage.loss <- -0.333  # g lost per hour
        for (t in 2:max.time) {
            open.cage.mass[t] <- open.cage.mass[t - 1] + rnorm(n = 1, mean = cage.loss, sd = 0.1)
        }
        open.cage.df <- data.frame(Time = 1:max.time, Mass = open.cage.mass)
        return(open.cage.df)
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
        if (input$name != "Enter email address here before beginning Experiment 1.") {
            shinyjs::show("FeedbackNames")
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
            shinyjs::enable("1A")
            shinyjs::enable("1B")
            shinyjs::enable("1C")
        }
    })
    # experiment 1
    #
    # first three questions are shown first
    observeEvent(input$`1C`, {
        if (input$`1A` != "None selected" & input$`1B` != "None selected" & input$`1C` != "None selected") {
            shinyjs::enable("Submit1ABC")
        }
    })
    observeEvent(input$Submit1ABC, {
        shinyjs::disable("1A")
        shinyjs::disable("1B")
        shinyjs::disable("1C")
        shinyjs::disable("Submit1ABC")
        saveData(formData())
        time_1ABC <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1ABC)
        saveTimestamps(answerTimestamps())
        cor_1A <- append(answerCorrect(), ifelse(identical(input$`1A`, "A"), 1, 0))
        answerCorrect(cor_1A)
        saveCorrect(answerCorrect())
        cor_1B <- append(answerCorrect(), ifelse(identical(input$`1B`, "A"), 1, 0))
        answerCorrect(cor_1B)
        saveCorrect(answerCorrect())
        cor_1C <- append(answerCorrect(), ifelse(identical(input$`1C`, "B"), 1, 0))
        answerCorrect(cor_1C)
        saveCorrect(answerCorrect())
        shinyjs::enable("Experiment1")
    })

    observeEvent(input$Experiment1, {
        shinyjs::show("Next1D")
    })
    Experiment1Output <- eventReactive(input$Experiment1,{
        # simulate experiment 1
        experiment1.df <- Experiment1(max.time)
    })
    output$FoodMass <- renderPlot({
        # experiment 1: food mass
        ggplot(Experiment1Output(), aes(x = Time, y = FoodMass)) + geom_point(size = point.size) +
            geom_smooth(method = "loess", formula = "y ~ x", color = line.color, fill = error.bar.color, se = FALSE) +
            labs(x = "Time (in hours)", y = "Mass of food (in g)", title = "1A") +
            annotate("text", x = 6, y = 5, label = "Food decreases\n(mouse eats)", size = 6, color = text.color) +
            scale_x_continuous(breaks = 1:max.time) +
            coord_cartesian(ylim = c(0, 20)) + 
            theme_classic() + fig.theme
      })
    output$WaterMass <- renderPlot({
        # experiment 1: water mass
        ggplot(Experiment1Output(), aes(x = Time, y = WaterMass)) + geom_point(size = point.size) +
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, fill = error.bar.color, se = FALSE) +
            labs(x = "Time (in hours)", y = "Mass of water (in g)", title = "1B") +
            annotate("text", x = 6, y = 25, label = "Water decreases\n(mouse drinks)", size = 6, color = text.color) +
            scale_x_continuous(breaks = 1:max.time) +
            coord_cartesian(ylim = c(0, 100)) + 
            theme_classic() + fig.theme
      })
    output$MouseMass <- renderPlot({
        # experiment 1: mouse mass
        ggplot(Experiment1Output(), aes(x = Time, y = MouseMass)) + geom_point(size = point.size) +
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, fill = error.bar.color, se = FALSE) +
            labs(x = "Time (in hours)", y = "Mass of mouse (in g)", title = "1C") +
            annotate("text", x = 6, y = 29.75, label = "Mouse gets\n(slightly) bigger", size = 6, color = text.color) +
            scale_x_continuous(breaks = 1:max.time) +
            coord_cartesian(ylim = c(29.5, 30.5)) + 
            theme_classic() + fig.theme
      })
    observeEvent(input$Next1D, {
        shinyjs::disable("Next1D")
        shinyjs::show("1D")
        shinyjs::show("Submit1D")
        shinyjs::disable("Experiment1")
    })
    observeEvent(input$`1D`, {
        if (input$`1D` != "None selected") {
            shinyjs::enable("Submit1D")
        }
    })
    observeEvent(input$Submit1D, {
        shinyjs::disable("Submit1D")
        shinyjs::disable("1D")
        saveData(formData())
        time_1D <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1D)
        saveTimestamps(answerTimestamps())
        cor_1D <- append(answerCorrect(), ifelse(identical(input$`1D`, "D"), 1, 0))
        answerCorrect(cor_1D)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback1D")
        shinyjs::show("Next1E")
    })

    observeEvent(input$Next1E, {
        shinyjs::disable("Next1E")
        shinyjs::show("Introduction1EF")
        shinyjs::show("MassBreakdown")
        shinyjs::show("1E")
        shinyjs::show("Submit1E")
    })
    output$MassBreakdown <- renderPlot({
        # experiment 1: accounting for the mass from food eaten
        experiment1.df <- Experiment1Output()
        # calculate food eaten, estimate mass of poop (about 1/5 of food eaten), and the mass gained by the mouse
        food.eaten <- 20 - experiment1.df[max.time, "FoodMass"]
        poop.mass <- (20 - experiment1.df[max.time, "FoodMass"]) / 5
        mouse.mass.change <- experiment1.df[max.time, "MouseMass"] - 30
        mass.change <- c(FoodEaten = food.eaten, PoopMass = poop.mass, MouseMassChange = mouse.mass.change)
        par(mgp = c(3, 1.5, 1))
        x <- barplot(height = mass.change, names.arg = c("Food eaten", "Poop", "Mouse mass\ngained"), 
            col = c("#6BC1FF", "#FFA278", "#FFDE5E"), ylab = "Mass (in g)", ylim = c(0, 6), 
            cex.axis = 1.5, cex.names = 1.5, cex.lab = 1.5)
        text(x, mass.change + 0.2, labels = paste(as.character(round(mass.change, digits = 2)), "g"), cex = 1.3)
        title(main = "Mass of food eaten, poop produced, and mouse\nbody mass gained at end of experiment", cex.main = 1.5, font.main = 1)
    })
    observeEvent(input$`1E`, {
        if (length(input$`1E`) > 0 & input$`1E`[1] != "None selected") {
            shinyjs::enable("Submit1E")
        }
    })
    observeEvent(input$Submit1E, {
        shinyjs::disable("Submit1E")
        shinyjs::disable("1E")
        saveData(formData())
        time_1E <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1E)
        saveTimestamps(answerTimestamps())
        res1E <- checkAnswer(correct.vec = c("B", "D"), input = input$`1E`)
        cor_1E <- append(answerCorrect(), res1E)
        answerCorrect(cor_1E)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback1E")
    })
    observeEvent(input$Next1F, {
        shinyjs::disable("Next1F")
        shinyjs::show("1F")
        shinyjs::show("Submit1F")
    })
    observeEvent(input$`1F`, {
        if (input$`1F` != "None selected") {
            shinyjs::enable("Submit1F")
        }
    })
    observeEvent(input$Submit1F, {
        shinyjs::disable("Submit1F")
        shinyjs::disable("1F")
        saveData(formData())
        time_1F <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_1F)
        saveTimestamps(answerTimestamps())
        cor_1F <- append(answerCorrect(), ifelse(identical(input$`1F`, "C"), 1, 0))
        answerCorrect(cor_1F)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback1F")
        shinyjs::enable("2A")
    })
    #
    # experiment 2
    #
    # show the first question first (entire closed cage)
    # then show breakdown of masses of gas inside the cage
    Experiment2Output <- eventReactive(input$Experiment2,{
        closed.cage.df <- ClosedCage(max.time)
    })
    output$ClosedCage <- renderPlot({
        ggplot(Experiment2Output(), aes(x = Time, y = Mass)) + geom_point(size = point.size) + 
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, se = FALSE) +
            labs(x = "Time (in hours)", y = "Mass of closed cage and contents (in g)", title = "2A") +
            scale_x_continuous(breaks = 1:max.time) +
            coord_cartesian(ylim = c(2495, 2505)) +
            theme_classic() + fig.theme
    })
    observeEvent(input$`2A`, {
        if (input$`2A` != "None selected") {
            shinyjs::enable("Submit2A")
        }
    })
    observeEvent(input$Submit2A, {
        shinyjs::disable("Submit2A")
        shinyjs::disable("2A")
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
        shinyjs::show("Feedback2A")
        shinyjs::disable("Experiment2")
    })
    observeEvent(input$Next2BC, {
        shinyjs::disable("Next2BC")
        shinyjs::show("Experiment2GasIntro")
        shinyjs::show("2B")
        shinyjs::show("2C")
        shinyjs::show("Submit2BC")
        shinyjs::show("Experiment2Air")
    })
    output$GasesBarChart <- renderPlot({
        N2.mass <- cage.volume * 0.78084 * 0.0012506
        Ar.mass <- cage.volume * 0.00934 * 0.001784
        CO2.mass <- cage.volume * 0.000407 * 0.001977
        O2.mass <- cage.volume * 0.20946 * 0.001429
        y.lim.max <- ceiling(max(N2.mass))
        par(mgp = c(3, 1.5, 1))
        barplot(height = c(N2.mass, O2.mass, Ar.mass, CO2.mass), 
            names.arg = c("Nitrogen\ngas", "Oxygen\ngas", "Argon\ngas", "Carbon\ndioxide gas"),
            col = c("#6BC1FF", "#FFA278", "#FFDE5E", "#000000"), ylab = "Mass (in g)", xpd = FALSE,
            ylim = c(0, y.lim.max), cex.axis = 1, cex.names = 1.2, cex.lab = 1.5)
        title(main = "Mass of gases in the air at\nthe start of Experiment 2", cex.main = 1.5, font.main = 1)
    })
    AirMassOutput <- eventReactive(input$Experiment2Air,{
        air.mass.df <- AirMass(max.time)
    })
    output$CO2Mass <- renderPlot({
        text.placement <- max(AirMassOutput()$CO2Mass)
        ggplot(AirMassOutput(), aes(x = Time, y = CO2Mass)) + geom_point(size = point.size) +
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, fill = error.bar.color, se = FALSE) +
            labs(x = "Time (in hours)", y = "Carbon dioxide mass (in g)", title = "2B") +
            annotate("text", x = 3, y = text.placement - 0.1, label = "Carbon dioxide gas\nmass increases", size = 6, color = text.color) +
            scale_x_continuous(breaks = 1:max.time) +
            theme_classic() + fig.theme
    })
    output$O2Mass <- renderPlot({
        text.placement <- max(AirMassOutput()$O2Mass)
        ggplot(AirMassOutput(), aes(x = Time, y = O2Mass)) + geom_point(size = point.size) +
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, fill = error.bar.color, se = FALSE) +
            labs(x = "Time (in hours)", y = "Oxygen mass (in g)", title = "2C") +
            annotate("text", x = 10, y = text.placement - 0.1, label = "Oxygen gas\nmass decreases", size = 6, color = text.color) +
            scale_x_continuous(breaks = 1:max.time) +
            theme_classic() + fig.theme
    })
    observeEvent(input$`2C`, {
        if (input$`2B` != "None selected" & input$`2C` != "None selected") {
            shinyjs::enable("Submit2BC")
        }
    })
    observeEvent(input$Submit2BC, {
        shinyjs::disable("Submit2BC")
        shinyjs::disable("2B")
        shinyjs::disable("2C")
        saveData(formData())
        time_2BC <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2BC)
        saveTimestamps(answerTimestamps())
        cor_2B <- append(answerCorrect(), ifelse(identical(input$`2B`, "B"), 1, 0))
        answerCorrect(cor_2B)
        saveCorrect(answerCorrect())
        cor_2C <- append(answerCorrect(), ifelse(identical(input$`2C`, "A"), 1, 0))
        answerCorrect(cor_2C)
        saveCorrect(answerCorrect())
        shinyjs::enable("Experiment2Air")
        shinyjs::show("Next2D")
    })
    observeEvent(input$Next2D, {
        shinyjs::disable("Next2D")
        shinyjs::show("2D")
        shinyjs::show("Submit2D")
        shinyjs::disable("Experiment2Air")
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
        cor_2D <- append(answerCorrect(), ifelse(identical(input$`2D`, "C"), 1, 0))
        answerCorrect(cor_2D)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback2D")
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
        saveData(formData())
        time_2E <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2E)
        saveTimestamps(answerTimestamps())
        cor_2E <- append(answerCorrect(), ifelse(identical(input$`2E`, "B"), 1, 0))
        answerCorrect(cor_2E)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback2E")
    })
    observeEvent(input$Next2F, {
        shinyjs::disable("Next2F")
        shinyjs::show("2F")
        shinyjs::show("Submit2F")
    })
    output$AirMass <- renderPlot({
        air.mass.df <- AirMassOutput()
        text.placement <- max(air.mass.df$AirMass)
        ggplot(AirMassOutput(), aes(x = Time, y = AirMass)) + geom_point(size = point.size) +
        geom_smooth(method = "lm", formula = y ~ x, color = line.color, fill = error.bar.color, se = FALSE) +
        labs(x = "Time (in hours)", y = "Mass of air (in g)", title = "2E") +
        annotate("text", x = 6, y = text.placement - 0.05, label = "Mass of air\nincreases", size = 6, color = text.color) +
        scale_x_continuous(breaks = 1:max.time) +
        theme_classic() + fig.theme
    })
    observeEvent(input$`2F`, {
        if (input$`2F` != "None selected") {
            shinyjs::enable("Submit2F")
        }
    })
    observeEvent(input$Submit2F, {
        shinyjs::disable("2F")
        shinyjs::disable("Submit2F")
        saveData(formData())
        time_2F <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_2F)
        saveTimestamps(answerTimestamps())
        cor_2F <- append(answerCorrect(), ifelse(identical(input$`2F`, "C"), 1, 0))
        answerCorrect(cor_2F)
        saveCorrect(answerCorrect())
        shinyjs::show("Feedback2F")
        shinyjs::enable("3A")
    })
    #
    # experiment 3
    observeEvent(input$`3A`, {
        if (input$`3A` != "None selected") {
            shinyjs::enable("Submit3A")
        }
    })
    observeEvent(input$Submit3A, {
        shinyjs::disable("3A")
        saveData(formData())
        time_3A <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_3A)
        saveTimestamps(answerTimestamps())
        cor_3A <- append(answerCorrect(), ifelse(identical(input$`3A`, "A"), 1, 0))
        answerCorrect(cor_3A)
        saveCorrect(answerCorrect())
        shinyjs::disable("Submit3A")
        shinyjs::enable("Experiment3")
    })
    observeEvent(input$Experiment3, {
        shinyjs::show("Next3B")
        shinyjs::disable("Experiment3")
    })
    observeEvent(input$Next3B, {
        shinyjs::disable("Next3B")
        shinyjs::show("3B")
        shinyjs::show("Submit3B")
    })
    observeEvent(input$`3B`, {
        if (input$`3B` != "None selected") {
            shinyjs::enable("Submit3B")
        }
    })
    observeEvent(input$Submit3B, {
        shinyjs::disable("3B")
        saveData(formData())
        time_3B <- append(answerTimestamps(), format(Sys.time(), "%H:%M:%OS"))
        answerTimestamps(time_3B)
        saveTimestamps(answerTimestamps())
        cor_3B <- append(answerCorrect(), ifelse(identical(input$`3B`, "C"), 1, 0))
        answerCorrect(cor_3B)
        saveCorrect(answerCorrect())
        shinyjs::disable("Submit3B")
        shinyjs::show("Feedback3B")
    })
    OpenCageOutput <- eventReactive(input$Experiment3, {
        open.cage.df <- OpenCage(max.time)
    })
    output$OpenCage <- renderPlot({
        text.placement <- max(OpenCageOutput()$Mass)
        ggplot(OpenCageOutput(), aes(x = Time, y = Mass)) + geom_point(size = point.size) +
            geom_smooth(method = "lm", formula = y ~ x, color = line.color, fill = error.bar.color, se = FALSE) +
            annotate("text", x = 6, y = text.placement - 0.3, label = "Mass of cage and contents decreases", size = 6, color = text.color) +
            labs(x = "Time (in hours)", y = "Mass of open cage and contents (in g)", title = "3A") +
            scale_x_continuous(breaks = 1:max.time) +
            theme_classic() + fig.theme
    })
}
)