# # # # # # # # # # # # # # # # # # # # # # # # # 
# MouseExperiment Shiny App - ui.R ----------
# # # # # # # # # # # # # # # # # # # # # # # # # 
#
# packages
#
library(shiny)
library(shinythemes)
library(shinyjs)
#
shinyUI(navbarPage(
    title = "Movement of matter in animals",
    tabPanel("Introduction", 
        fluidPage(theme = shinytheme("cosmo"),
        shinyjs::useShinyjs(),
            tags$h3("Your assignment"),
        p("In this activity, you will work through questions about three experiments with a mouse.",
        "You will predict what will happen to the mass of the mouse and other objects in the experiments.",
        "Over the course of the activity, you will shift perspectives from thinking about the parts of a system to thinking about the system as a whole."),
        p(class="text-warning",
           tags$strong("Instructions (read carefully!):")),
            p("Use the tabs at the top of the page to navigate through the experiments.",
            "Begin with Experiment 1.",
            "As you answer questions, new questions will appear below.",
            "Take time to think before selecting each answer.",
            tags$em("You will only have one chance to answer each question.")
            ),
        fluidRow(
            column(12,
                tags$h4("Enter your email"),
                p("Before beginning the activity, make sure that your ", tags$strong("stonybrook.edu"), " email has been recorded in the box below."),
                textInput(inputId = "name", label = '', "Enter email here before beginning Experiment 1.", width = "100%"),
                actionButton(label = "The email above is correct", inputId = "NameButton"),
                shinyjs::hidden(div(id = "FeedbackNames", 
                            p(class="text-warning", "email recorded, please begin Experiment 1 using the tabs at the top of the page.")))
                )
            ),
        fluidRow(
            column(12, style='padding-left:10px; padding-right:10px; padding-top:35px; padding-bottom:5px',
                p(strong("Sources used to create this activity:"), style = "font-size:12px;"),
                p("Greenbaum, A. L. 1953. Changes in Body Composition and Respiratory Quotient of Adult Female Rats Treated with Purified Growth Hormone.", tags$em("Biochemical Journal"), " 54 (3): 400–407.", style = "font-size:12px;"),
                p("Rosenmann, M, and P Morrison. 1974. Maximum Oxygen Consumption and Heat Loss Facilitation in Small Homeotherms by He-O2.", tags$em("American Journal of Physiology"), " 226 (3): 490–95.", style = "font-size:12px;")
                )
            )
        )
    ),
    tabPanel("Experiment 1", 
        fluidPage(
            fluidRow(
                column(12,
                    tags$h3("Experiment 1: within-system perspective"),
                    p(class="text-primary", "There are six questions in this section (1A-F).")
                )
            ),
            fluidRow(  
                column(6,
                    p("You decide that you want to conduct an experiment with a mouse in order to better understand changes in matter over time.",
                    "You measure out 20 grams (g) of food and 100 g of water and place it in an open cage (see the image to the right for the experimental set-up).",
                    "This is more food than the mouse normally eats.",
                    "You let the mouse eat as much food and drink as much water as it likes over the course of 12 hours.",
                    "Once every hour, you weigh the food, the water, and the mouse individually.",
                    "At the beginning of the experiment, the mouse weighs 30 g."),
                    p("This first set of questions are very basic; they are designed to help you become familiar with the experimental set up.")
                    ),
                column(6,
                    img(src='ExperimentOpenCage_WithScales.png', width = "600px")
                    )
            ),
            fluidRow(
                column(4,
                    img(src='Food.png')
                    ),
                column(4,
                    img(src='Water.png')
                    ),
                column(4,
                    img(src='Mouse.png')
                    )
            ),
            fluidRow(
                column(4,
                    shinyjs::disabled(radioButtons(inputId = "1A", label = "(A) What do you predict will happen to the mass of the food during Experiment 1?", 
                        choiceNames = list("None selected", "Decrease slightly", "Increase slightly", "Stay the same"), 
                        choiceValues = c("None selected", "A", "B", "C")))
                ),
                column(4,
                    shinyjs::disabled(radioButtons(inputId = "1B", label = "(B) What do you predict will happen to the mass of the water during Experiment 1?", 
                        choiceNames = list("None selected", "Decrease slightly", "Increase slightly", "Stay the same"), 
                        choiceValues = c("None selected", "A", "B", "C")))
                ),
                column(4,
                    shinyjs::disabled(radioButtons(inputId = "1C", label = "(C) What do you predict will happen to the mass of the mouse during Experiment 1?", 
                        choiceNames = list("None selected", "Decrease slightly", "Increase slightly", "Stay the same"), 
                        choiceValues = c("None selected", "A", "B", "C")))
                )
            ),
            fluidRow(  
                column(12, align="center",
                    p("If you are having trouble submitting your responses, make sure: 1) you filled in your name on the 'Introduction' tab, and 2) you have selected answers for 1 A-C."),
                    p(class="text-warning", tags$em("When you press the submit button, your responses will be recorded and you will no longer be able to change your answer.")),
                    shinyjs::disabled(actionButton(label = "Submit 1 A-C", inputId = "Submit1ABC")),
                    p(),
                    shinyjs::disabled(actionButton(label = "Conduct Experiment 1", inputId = "Experiment1"))
                    )
                ),
            fluidRow(
                column(4,
                    plotOutput("FoodMass")
                ),
                column(4,
                    plotOutput("WaterMass")
                ),
                column(4,
                    plotOutput("MouseMass")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:5px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(actionButton(label = "Move on to the next question", inputId = "Next1D"))
                )
            ),
            fluidRow(  
                column(12,
                    shinyjs::hidden(radioButtons(inputId = "1D", label = "(D) Choose the best explanation for the patterns observed in 1A-C.", 
                                    choiceNames =  c("None selected", 
                                    "The mouse ate some of the food and gained mass. All of the food that the mouse ate was added to its body.", 
                                    "The mouse ate some of the food and gained mass. Some of the food that the mouse ate was added to its body, the rest left the body as poop.",
                                    "The mouse ate some of the food and gained mass. Some of the food that the mouse ate was added to its body, and the rest left the body as carbon dioxide.",
                                    "The mouse ate some of the food and gained mass. Some of the food that the mouse ate was added to its body, some left the body as poop, and some left the body as carbon dioxide."), 
                                    choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 1D", inputId = "Submit1D"))),
                    shinyjs::hidden(div(id = "Feedback1D", tags$ul(tags$strong("Answer explanation:"), 
                                    p("When the mouse ate the food, the matter in the food was brought into the digestive tract of its body and broken down into smaller pieces of matter.", 
                                    "Some of the broken down matter could not be digested any further and left the body as waste (e.g., poop).", 
                                    "The rest of the matter was either added to tissues within the mouse’s body (i.e. contributed to growth) OR was used as inputs into cellular respiration (i.e., contributed to metabolism).", 
                                    "Molecules that undergo cellular respiration leave the body as gases (i.e., carbon dioxide).",
                                    "Therefore, some of the food left the mouse’s body as poop, some left as carbon dioxide, and some stayed inside the mouse’s body and contributed to growth.")),
                                    actionButton(label = "Move on to the next question", inputId = "Next1E")
                                    ))
                    )
                ),
            fluidRow(
                column(12, style='padding-left:10px; padding-right:10px; padding-top:10px; padding-bottom:10px',
                    shinyjs::hidden(div(id = "Introduction1EF", 
                                        p("Over the course of the 12-hour experiment, the mouse ate food, pooped, and gained body mass.", 
                                        "The mass of the food eaten, poop produced, and body mass gained was measured at the end of the experiment (i.e., at hour 12) and is shown on the bar graph below.",
                                        "You can assume that the experiment lasted long enough for all of the food that was eaten to have left the mouse's digestive tract and become incorporated into tissues.",
                                        "Note that the mouse also drank water and urinated, but this is not important to consider for the following questions.")))
                )
            ),
            fluidRow(
                column(6,
                    shinyjs::hidden(plotOutput("MassBreakdown"))
                    ),
                column(6,
                    shinyjs::hidden(checkboxGroupInput(inputId = "1E", 
                        label = "(E) According to the graph, which of the following statements are correct?", 
                        choiceNames = c("None selected", 
                                "The mass of the mouse's poop + the mass gained by the end of the experiment = nearly all of the mass that was in the food that the mouse ate.",
                                "The mass of the mouse's poop + the mass gained by the end of the experiment  = only some of the mass that was in the food that the mouse ate.",
                                "When considering the mass of the inputs (food eaten) and outputs (poop and body growth by the end of the experiment) of the mouse, approximately 1-2 g of mass are not included in this bar graph.", 
                                "When considering the mass of the inputs (food eaten) and outputs (poop and body growth by the end of the experiment) in the mouse experiment, approximately 3-4 g of mass are not included in this bar graph."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), selected = "None selected", width = "100%")),
                    shinyjs::hidden(div(id = "Submit1E", p("If you are having trouble submitting your response, make sure you have unchecked 'None selected.'"),
                    shinyjs::disabled(actionButton(label = "Submit 1E", inputId = "Submit1E"))))
                )
            ),
            fluidRow(
                column(12,
                    shinyjs::hidden(div(id = "Feedback1E", tags$ul(tags$strong("Answer explanation:"), 
                                    p("The mass of the food eaten by the mouse does NOT equal the mass of the mouse’s poop and the mass its body gained by the end of the experiment.",
                                    "Only SOME of the matter in the food a mouse eats can be found in its poop or in the mass its body gains by the end of the experiment.",
                                    "There is matter (and its associated mass) missing from this graph.",
                                    "How do we know that there is missing mass?",
                                    "When you add up the mass of the mouse’s poop and the mass it gained (growth), you find that only ~1 gram of mass is accounted for at the end of the experiment.",
                                    "Therefore, you can subtract the ~1 g of mass that is accounted for from the ~4.5 g of food that was eaten during the experiment and find that ~3.5 g of mass is missing.",
                                    "Note that the values may be slightly different each time you run this experiment, but the general pattern is the same.")),
                                    actionButton(label = "Move on to the next question", inputId = "Next1F")
                                    ))
                    )
                ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:5px; padding-top:15px; padding-bottom:5px',
                    shinyjs::hidden(radioButtons(inputId = "1F", 
                        label = "(F) Approximately 3-4 g of mass from the food that was eaten remains unaccounted for at the end of the experiment. Where did the mass go? Choose the best explanation.", 
                        choiceNames = c("None selected", 
                                        "The ~3-4 g of mass was released by the body as sweat.", 
                                        "The ~3-4 g of mass was burned during metabolism, and no longer exists.", 
                                        "The ~3-4 g of mass was exhaled as carbon dioxide.", 
                                        "The ~3-4 g of mass was converted into energy to be used by the body."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 1F", inputId = "Submit1F"))),
                    shinyjs::hidden(div(id = "Feedback1F", tags$ul(tags$strong("Answer explanation:"), 
                                    p("During digestion, the food was broken down into smaller bits.", 
                                    "Some of the small molecules were used as inputs for cellular respiration, which provided the mouse energy to perform important metabolic activities.",
                                    "Remember that in cellular respiration, most of the energy of the input molecules remains in the body, but the matter (and its associated mass) leaves the body as carbon dioxide."),
                                    p("While some of the matter in the food a mouse eats can be found in its sweat, this would constitute a very small amount of the mass that came from the food (< 0.01 g), and therefore would NOT be the best answer."),
                                    p("Matter (and its associated mass) cannot be created or destroyed and cannot be converted into energy in biological systems.",
                                    "Therefore, the ~3-4 g of missing mass must still exist somewhere (It CANNOT turn into energy in a biological system)."), 
                                    p("Therefore, the missing mass is explained by the carbon dioxide gas that was exhaled (Remember--carbon dioxide gas has mass!).")),
                                    p(class="text-warning", "End of Experiment 1, please move on to Experiment 2 using the tabs at the top of the page.")))
                    )
                )
            )
        ),
    tabPanel("Experiment 2",
        fluidPage(
            fluidRow(
                column(12,
                    tags$h3("Experiment 2: whole-system perspective, sealed cage"),
                    p(class="text-primary", "There are six questions in this section (2A-F).")
                )
            ),
            fluidRow(
                column(6,
                    p("The next day, you try a different experiment.",
                    "This time, you place a mouse (30 g) in a SEALED cage with a supply of food (20 g) and water (100 g) (see the image to the right for the experimental set-up).",
                    "No air can get in or out of this cage, but there is plenty of air inside for the mouse to breathe.",
                    "In Experiment 2, you measure the mass of the entire cage over time.",
                    "At the beginning of the experiment, you weigh the cage (containing the mouse, water and food). The cage and all of its contents weighs 2,500 g.")
                    ),
                column(6,
                    img(src='ExperimentClosedCage.png', width = "500px")
                )
            ),
            fluidRow(
                column(6, style='padding-left:5px; padding-right:5px; padding-top:5px; padding-bottom:15px',
                    shinyjs::disabled(radioButtons(inputId = "2A", 
                        label = "(A) You leave the entire sealed cage on the scale for 12 hours, and you measure its mass once every hour. The mouse’s waste (urine and feces) is also in the cage. What do you predict will happen to the mass of the cage and its contents during Experiment 2?", 
                        choiceNames = c("None selected", "Decrease slightly", "Increase slightly", "Stay the same"), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%")),
                    shinyjs::disabled(actionButton(label = "Submit 2A", inputId = "Submit2A")),
                    p(),
                    shinyjs::disabled(actionButton(label = "Conduct Experiment 2", inputId = "Experiment2")),
                    shinyjs::hidden(div(id = "Feedback2A", tags$ul(tags$strong("Answer explanation:"), 
                                    p("Mass cannot enter or leave the system so the overall mass of the cage and its contents does not change.")),
                                    actionButton(label = "Move on to the next question", inputId = "Next2BC")
                    ))
                ),
                column(6, style='padding-left:5px; padding-right:5px; padding-top:5px; padding-bottom:15px',
                    plotOutput("ClosedCage")
                )
            ),
            fluidRow(
                column(12,
                    shinyjs::hidden(div(id = "Experiment2GasIntro", 
                                    tags$h4("Gases in the sealed cage"),
                                    p("Even though the mass of the system as a whole (the cage and its contents) doesn't change over time, the mass of the components that make up the system can change.",
                        "Using a probe that can detect gases in the air, you measure the mass of the gases inside the cage before the experiment begins (shown in the figure to the right).",
                        "Notice that there is a lot more oxygen in the air than carbon dioxide, though both gases are important in biological systems."),
                        plotOutput("GasesBarChart", width = "60%"))
                    )
                )
            ),
            fluidRow(
                column(6,
                    shinyjs::hidden(radioButtons(inputId = "2B", 
                        label = "(B) What do you predict will happen to the mass of the carbon dioxide gas inside the cage during Experiment 2?", 
                        choiceNames = c("None selected", "Decrease slightly", "Increase slightly", "Stay the same"),
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%"))
                ),
                column(6,
                    shinyjs::hidden(radioButtons(inputId = "2C", 
                        label = "(C) What do you predict will happen to the mass of the oxygen gas inside the cage during Experiment 2?", 
                        choiceNames = c("None selected",  "Decrease slightly", "Increase slightly", "Stay the same"), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%"))
                )
            ),
            fluidRow(
                column(12, align="center",
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2BC", inputId = "Submit2BC"))),
                    p(),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "View data for gas mass", inputId = "Experiment2Air")))
                )
            ),
            fluidRow(
                column(6,
                    plotOutput("CO2Mass")
                ),
                column(6,
                    plotOutput("O2Mass")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:5px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(actionButton(label = "Move on to the next question", inputId = "Next2D"))
                )
            ),
            fluidRow(  
                column(12,
                    shinyjs::hidden(radioButtons(inputId = "2D", label = "(D) Choose the best causal explanation(s) for the patterns observed in 2B and 2C.", 
                            choiceNames = c("None selected",
                                            "The mass of carbon dioxide gas in the air increases because the mouse is adding more of this molecule to the air by exhaling.",
                                            "The mass of oxygen gas in the air decreases because the mouse is removing this molecule from the air by inhaling.",
                                            "All of the above",
                                            "None of the above"), 
                            choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2D", inputId = "Submit2D"))),
                    shinyjs::hidden(div(id = "Feedback2D", tags$ul(tags$strong("Answer explanation:"), 
                                    p("When the mouse breathes, it inhales oxygen gas and exhales carbon dioxide gas.", 
                                    "Therefore, the mass of oxygen gas in the air decreases because the mouse is removing this molecule from the air when it inhales.", 
                                    "Similarly, the mass of carbon dioxide gas in the air increases because the mouse is adding more of this molecule to the air when it exhales.")),
                                    actionButton(label = "Move on to the next question", inputId = "Next2E")
                        ))
                    )
                ),
                fluidRow(
                column(12, style='padding-left:5px; padding-right:5px; padding-top:15px; padding-bottom:5px',
                    shinyjs::hidden(radioButtons(inputId = "2E", 
                        label = "(E) In 2B and 2C, you measured the mass of carbon dioxide and oxygen gases inside the cage. What do you predict happened to the TOTAL mass of the air inside the cage during Experiment 2?", 
                        choiceNames = c("None selected", "Decrease slightly", "Increase slightly", "Stay the same"), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2E", inputId = "Submit2E"))),
                    shinyjs::hidden(div(id = "Feedback2E", tags$ul(tags$strong("Answer explanation:"), 
                                    p("The total mass of the air inside the cage increases during Experiment 2.")),
                                    plotOutput("AirMass", width = "60%"),
                                    actionButton(label = "Move on to the next question", inputId = "Next2F")))
                    )
            ),
            fluidRow(  
                column(12,
                    shinyjs::hidden(radioButtons(inputId = "2F", label = "(F) Choose the best causal explanation for the patterns observed in 2E.",
                        choiceNames = c("None selected",
                                        "The total mass of the air stayed about the same because the carbon dioxide gas that was exhaled left the cage.", 
                                        "The total mass of the air stayed about the same because carbon dioxide gas that was exhaled has a similar mass to the oxygen gas that was inhaled.",
                                        "The total mass of the air increased because the carbon dioxide gas that was exhaled has more mass than the oxygen gas that was inhaled.",
                                        "The total mass of the air increased because the molecules became more densely packed through time."),
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2F", inputId = "Submit2F"))),
                    shinyjs::hidden(div(id = "Feedback2F", tags$ul(tags$strong("Answer explanation:"), 
                                    p("Because the mouse is in a sealed cage, matter could not enter or leave the system.",
                                    "Carbon dioxide and oxygen molecules do NOT have similar masses.", 
                                    "Oxygen gas is composed of two oxygen atoms, whereas carbon dioxide gas is composed of two oxygen atoms AND a carbon atom.",
                                    "Therefore, each molecule of carbon dioxide gas is exactly one carbon atom heavier than each molecule of oxygen gas."),
                                    p("Both oxygen gas (as an input) and carbon dioxide gas (as an output) are involved in cellular respiration and they enter and exit the mouse’s body through breathing.",
                                    "The number of oxygen gas molecules that go into cellular respiration is the same as the number of carbon dioxide molecules that are released.",
                                    "Because carbon dioxide gas has MORE mass than oxygen gas, the total mass of the air increased as the mouse breathed."), 
                                    p("While the air of the sealed cage probably would become more densely packed as oxygen gas is replaced by carbon dioxide gas, the increase in density is not the best causal explanation of the air’s increase in mass.",
                                    "The cause of the increase in the mass of the air is that the carbon dioxide gas that was exhaled has more mass than the oxygen gas that was inhaled.")),
                        p(class="text-warning", "End of Experiment 2, please move on to Experiment 3 using the tabs at the top of the page."))
                    ))
                )
        )
    ),
    tabPanel("Experiment 3",
        fluidPage(
            fluidRow(
                column(12,
                    tags$h3("Experiment 3: whole-system perspective, open cage"),
                    p(class="text-primary", "There are two questions in this section (3A-B).")
                )
            ),
            fluidRow(
                column(6,
                    p("You conduct one final experiment.",
                    "You place a mouse (30 g) in an OPEN cage with a new supply of food (20 g) and water (100 g).",
                    "You let the mouse eat as much food and drink as much water as it likes over the course of 12 hours.",
                    "Just like in Experiment 1, the mouse will gain a little bit of mass as it eats the food and drinks the water.",
                    "Air can pass freely in or out of this cage.",
                    "In Experiment 3, you again want to measure the mass of the entire cage and its contents over time.",
                    "At the beginning of the experiment, you weigh the cage (containing the mouse, water and food).",
                    "The mouse’s waste (urine, feces) is also in the cage.",
                    "The cage and all of its contents initially weighs 2,500 g.")
                    ),
                column(6,
                        img(src='ExperimentOpenCage.png', width = "500px")
                    )
            ),
            fluidRow(
                column(6,
                    shinyjs::disabled(radioButtons(inputId = "3A", label = "(A) You leave the entire cage on the scale for one day, and you measure its mass once every hour. What do you predict will happen to the mass of the cage and its contents during Experiment 3?", 
                        choiceNames = list("None selected", "Decrease slightly", "Increase slightly", "Stay the same"), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%")),
                    shinyjs::disabled(actionButton(label = "Submit 3A", inputId = "Submit3A")),
                    p(),
                    shinyjs::disabled(actionButton(label = "Conduct Experiment 3", inputId = "Experiment3"))
                ),
                column(6,
                    plotOutput("OpenCage")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:5px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(actionButton(label = "Move on to the next question", inputId = "Next3B"))
                )
            ),
            fluidRow(  
                column(12,
                    shinyjs::hidden(radioButtons(inputId = "3B", label = "(B) Choose the best explanation for the pattern observed in 3A.",
                        choiceNames = list("None selected", 
                                        "The mass of the cage and its contents decreased because the mouse incorporated gases from the air into its body tissues, causing the air to become lighter.",
                                        "The mass of the cage and its contents decreased because the mouse incorporated matter from the food into its body, causing the food to become lighter.",
                                        "The mass of the cage and its contents decreased because as the mouse respired, mass left the system as carbon dioxide gas, causing it to become lighter.",
                                        "The mass of the cage and its contents decreased because the mouse’s water evaporated from the open system, causing it to become lighter."),
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 3B", inputId = "Submit3B"))),
                    shinyjs::hidden(div(id = "Feedback3B", 
                        tags$ul(tags$strong("Answer explanation:"), 
                                    p("Because the cage is open, the carbon dioxide gas that came from the mouse’s body dispersed into the surrounding air.", 
                                        "No other matter was added to the cage and its contents, so the mass of the overall system had to decrease.", 
                                        "The evaporation of the mouse’s water may contribute to a very small amount of mass loss, but the amount of mass lost from evaporation is much smaller than the amount of mass lost from exhaling carbon dioxide.")),
                        p(class="text-success", "End of the activity, all of your responses have been recorded.")))
                    )
                )
            )
        )
    )
)