# # # # # # # # # # # # # # # # # # # # # # # # # 
# PlantExperiment Shiny App - ui.R ----------
# # # # # # # # # # # # # # # # # # # # # # # # # 
#
# packages
#
library(shiny)
library(shinythemes)
library(shinyjs)
#
shinyUI(navbarPage(
    title = "Movement of matter in a forest of trees",
    tabPanel("Introduction", 
        fluidPage(theme = shinytheme("cosmo"),
        shinyjs::useShinyjs(),
            tags$h3("Your assignment"),
        p("In this activity, you will work through a case study involving a forest of trees (plants).",
        "You will predict what will happen to the mass of the trees in the forest and other objects in the system."),
        p(class="text-warning",
           tags$strong("Instructions (read carefully!):")),
            p("Use the tabs at the top of the page to navigate through the experiments.",
            "As you answer questions, new questions will appear below.",
            "Take time to think before selecting each answer.",
            tags$em("You will only have one chance to answer each question.")
            ),
        fluidRow(
            column(12,
                tags$h4("Enter your email"),
                p("Before beginning the activity, make sure that your ", tags$strong("stonybrook.edu"), " email address has been recorded in the box below."),
                textInput(inputId = "name", label = '', "Enter email address here before beginning Part 1.", width = "100%"),
                actionButton(label = "The email address above is correct", inputId = "NameButton"),
                shinyjs::hidden(div(id = "FeedbackNames", 
                            p(class="text-warning", "Email address recorded, please begin with Part 1 using the tabs at the top of the page.")))
            )
        ),
        fluidRow(
            column(12, style='padding-left:10px; padding-right:10px; padding-top:35px; padding-bottom:5px',
                p(strong("Sources used to create this activity:"), style = "font-size:12px;"),
                p("Chambers, Jeffrey Q, Joaquim dos Santos, Ralfh J Ribeiro, and Niro Higuchi. 2001. Tree Damage, Allometric Relationships, and above-Ground Net Primary Production in Central Amazon Forest.", tags$em("Forest Ecology and Management"), " 152 (1–3): 73–84.", style = "font-size:12px;"),
                p("Chambers, Jeffrey Q., Edgard S. Tribuzy, Ligia C. Toledo, Bianca F. Crispim, Niro Higuchi, Joaquim dos Santos, Alessandro C. Araújo, Bart Kruijt, Antonio D. Nobre, and Susan E. Trumbore. 2004. Respiration from a Tropical Forest Ecosystem: Partitioning of Sources and Low Carbon Use Efficiency.", tags$em("Ecological Applications"), " 14 (4): 72–88.", style = "font-size:12px;"),
                p("Mazzei, Lucas, Plinio Sist, Ademir Ruschel, Francis E. Putz, Phidias Marco, Wagner Pena, and Josué Evandro Ribeiro Ferreira. 2010. Above-Ground Biomass Dynamics after Reduced-Impact Logging in the Eastern Amazon.", tags$em("Forest Ecology and Management"), " 259 (3): 367–73.", style = "font-size:12px;")
                )
            )  
        )
    ),
    tabPanel("Part 1", 
        fluidPage(
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    tags$h3("Part 1"),
                    p(class="text-primary", "There are 2 questions in this section (1 A-B).")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    tags$h3("How do pathways of matter and energy transformation function at larger scales?: A forest of trees"),
                    p("In this assignment, we will reason about matter and energy at larger scales.",
                    "Up until now, we have been thinking about pathways of matter and energy in individual organisms like animals, plants, or fungi.",
                    "However, we know that many individuals of different species can live together in one habitat, forming a community."),
                    p("Our system of interest is a forest.",
                    "The forest in this example is real and exists in Brazil, in South America, a tropical climate.",
                    "Tropical climates do not have the same seasons that we do in temperate climates (like Stony Brook).",
                    "In tropical areas, temperature is fairly consistent over the year (rainfall may vary over the year, with a dry and a wet season).",
                    "Tropical climates also have many more species than temperate climates."),
                    p(),
                    img(src='CompareForest.png', width = "750px"),
                    tags$figcaption("Photo credit: left ", tags$a(href = "https://www.flickr.com/photos/bbcworldservice", "Simon Chirgwin, BBC World News"), " right ", tags$a(href = "https://www.flickr.com/photos/nicholas_t", "Nicholas A. Tonelli")),
                    p(),
                    p("At first, we will limit ourselves to thinking about just the tree species that live in the forest.",
                    "There are other kinds of organisms in the forest as well: mammals, insects, vines, ferns, soil organisms, etc.",
                    "However, trees make up the majority of the biomass in the forest.")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::disabled(checkboxGroupInput(inputId = "1A", 
                        label = "(A) Select all correct statements about tree biomass in a forest.", 
                        choiceNames = list("None selected", 
                            "Most of a tree’s dry biomass is made up of carbon and oxygen atoms.",
                            "Most of a tree’s dry biomass is made up of nitrogen and phosphorus atoms.",
                            "A portion of a tree’s dry biomass is made up of sunlight energy.", 
                            "Almost none of a tree’s total biomass is wet biomass; trees do not contain much water.",
                            "Most of a tree’s dry biomass is made up of carbon-based molecules, like cellulose."), 
                        choiceValues = c("None selected", "A", "B", "C", "D", "E"), selected = "None selected", width = "100%")),
                    p("If you are having trouble submitting your responses, make sure: 1) your email is filled in on the 'Introduction' tab, and 2) you have unchecked 'None selected.'"),
                    p(class="text-warning", tags$em("When you press the submit button, your responses will be recorded and you will no longer be able to change your answer.")),
                    shinyjs::disabled(actionButton(label = "Submit 1 A", inputId = "Submit1A")),
                    shinyjs::hidden(div(id = "Feedback1A", 
                        tags$strong("Answer explanation:"), 
                        p("As we discussed in a previous assignment, plant dry biomass is made up of mostly carbon and oxygen atoms, whether the plant is a 6-foot tall sunflower or a 200-foot tall tropical tree.",
                        "Plants are made up of other types of atoms too, like nitrogen and phosphorus, but those atoms aren’t as abundant in the plant’s body."),
                        p("Biomass is a word used to describe the matter that makes up organisms.",
                        "Matter and energy are closely associated with one another in organisms, but they should always be thought of separately.",
                        "Matter and energy cannot be converted into one another in biological systems."),
                        p("Trees contain a lot of water, and thus, just like sunflowers, trees’ wet biomass is similar to or greater than their dry biomass.",
                        "Even though trees have wood and sunflowers do not, there is a lot of water inside the cells and tissues of trees."),
                        p("There are many different kinds of molecules in trees.",
                        "Molecules like cellulose and lignin are extremely abundant and made up mostly of carbon and oxygen atoms.",
                        "Lignin is a very large carbohydrate molecule with a lot of carbon that makes up wood.",
                        "Remember that plants contain many other kinds of molecules as well, including starch, sucrose, proteins, DNA, lipids, etc., but they are less abundant."),
                        actionButton(label = "Move on to the next section", inputId = "Next1B")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "Intro1B",
                    img(src='BirdsEye.png', width = "350px"),
                    p(),
                    p("Let’s focus on the trees in a small (one hectare) patch of forest.",
                    "For reference, one hectare is about the size of a soccer (football) or baseball field.",
                    "We will start with a no-penalty question.",
                    "The goal of this question is to get you used to the scale of the one hectare forest in this example."),
                    shinyjs::disabled(radioButtons(inputId = "1B", 
                        label = "(B) Approximately how many grams of carbon do you think are contained in one hectare of tropical forest? (no penalty)", 
                        choiceNames = list("None selected", 
                            "2,000,000 g (about the mass of two cars)",
                            "20,000,000 g (about the mass of 20 cars)",
                            "200,000,000 g (about the mass of 200 cars)"), 
                        choiceValues = c("None selected", "A", "B", "C"), selected = "None selected", width = "50%")),
                    shinyjs::disabled(actionButton(label = "Submit 1 B", inputId = "Submit1B")))),
                    shinyjs::hidden(div(id = "Feedback1B", 
                        tags$strong("Answer explanation:"), 
                        p("A typical hectare of tropical forest contains about 210,000,000 g of carbon in its trees, so this mass is greater than the mass of 200 cars.",
                        "We will continue to use the mass of a car as a reference point for the duration of this assignment."),
                        p(),
                        img(src='CompareMass_CarsTrees.png', width = "750px"),
                        p(),
                        p("However, one hectare isn’t all that large--the area of the entire forest in northern Brazil that we are using as an example is 140,000 hectares.",
                        "So this forest as a whole contains about 29,400,000,000,000 g of carbon in its trees, which is about the mass of 29,400,000 cars (it would take 100 days for this many cars to cross the George Washington Bridge in New York City).",
                        "Were we to consider the mass of carbon in all forests globally, the amount of carbon contained is hard to comprehend!",
                        "The world’s forests contain a considerable portion of the carbon present in Earth’s ecosystems."),
                        p(class="text-warning", "End of Part 1, please move on to Part 2 using the tabs at the top of the page.")))
                )
            )
        )
    ),
    tabPanel("Part 2",
        fluidPage(
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    tags$h3("Part 2"),
                    p(class="text-primary", "There are 4 questions in this section (2 A-D)."),
                    p("Please complete Part 1 before beginning this section.")
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "IntroPart2",
                        tags$h3("How do humans use resources from forests?: logging"),
                        p("Humans benefit from trees in many ways.",
                        "Trees provide resources for humans; for example, timber (wood) is used for buildings, furniture, paper, and other materials.",
                        "Trees also provide food (e.g., chocolate, Brazil nuts) or other products (e.g., natural rubber).",
                        "When trees are harvested by humans, this is called logging."),
                        p("Logging can be carried out in a number of ways, and different logging practices impact forests differently.",
                        "Clear-cutting involves cutting down all trees in an area, and it can be carried out in small patches or large areas of forest.",
                        "Selective logging involves cutting down only some trees in an area.",
                        "This may involve selecting trees based on size (only harvesting relatively large trees, for example) or selecting certain species of trees to harvest."),
                        p("The hectare of forest that we will be focusing on was selectively logged in 2005.",
                        "Only individuals larger than a certain size were harvested."),
                        p(),
                        img(src='LoggingCombined.png', width = "500px"),
                        p(),
                        p("Click the button below to see the amount of carbon: (1) in the forest before logging, (2) in the forest after logging, (3) in the timber products that were harvested, and (4) in dead trees that were killed because of logging."),
                        actionButton(label = "View logging data", inputId = "LoggingButton")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("LoggingPlot", width = "80%")
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(checkboxGroupInput(inputId = "2A", 
                        label = "(A) According to the figure above (select all that apply)...", 
                        choiceNames = c("None selected", 
                            "...approximately 65-75% of the carbon in trees was harvested during logging.", 
                            "...approximately 15-25% of the carbon in trees was harvested during logging.", 
                            "...approximately 65-75% of the carbon in live trees remains in the forest hectare after logging.",
                            "...approximately 15-25% of the carbon in live trees remains in the forest hectare after logging."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2 A", inputId = "Submit2A"))),
                    shinyjs::hidden(div(id = "Feedback2A", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Because the forest hectare was selectively logged, only a percentage of the trees were harvested.",
                            "This means that about 75% of the carbon that was in live trees remains in the live trees in the forest hectare after logging.",
                            "The rest of the carbon that was in live trees, about 25%, was either harvested or killed (collateral damage) over the course of logging."),
                            actionButton(label = "Move on to the next question", inputId = "Next2B"))))
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "2B", 
                        label = "(B) After logging, there is approximately 157,000,000 g (~157 cars) of carbon in the trees that are still standing in the forest hectare. What do you predict will happen to the amount of carbon in the living trees in the forest hectare after 50 years?", 
                        choiceNames = c("None selected", 
                            "The amount of carbon will increase.", 
                            "The amount of carbon will decrease.", 
                            "The amount of carbon will stay approximately the same."), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2 B", inputId = "Submit2B"))),
                    p(),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "View forest carbon biomass over time", inputId = "LoggingBiomassButton")))
                )
            ),
            fluidRow(              
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("LoggingBiomassPlot", width = "80%"),
                    shinyjs::hidden(div(id = "Feedback2B", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("The amount of carbon will increase over the 50-year period"),
                            actionButton(label = "Move on to the next section", inputId = "Next2C"))))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "Intro2C",
                        p("Logging removed about 47,000,000 g (~47 cars) of carbon from the living trees in the forest, most of which was used as timber.",
                        "Over time, the amount of carbon increased until it was at about the same level as before logging.",
                        "It will take about 50 years for the forest to return to its initial biomass.",
                        "This information is important for foresters (i.e., people who manage forests for logging, recreation, hunting, and conservation) to plan how often forest resources can be harvested sustainably."))),
                    shinyjs::hidden(checkboxGroupInput(inputId = "2C", 
                        label = "(C) Select ALL correct explanations for the pattern of the increase of carbon in the forest hectare over time.", 
                        choiceNames = c("None selected", 
                            "The remaining living trees continued to photosynthesize, using some portion of the carbon molecules produced to add to their bodies.", 
                            "New trees developed from seeds that germinated, developed, and grew larger in the spaces where trees were cut down.", 
                            "The remaining living trees absorbed large carbon molecules (e.g., starch, cellulose, etc.) from the soil, and added these molecules to their bodies."), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2 C", inputId = "Submit2C"))),
                    shinyjs::hidden(div(id = "Feedback2C", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("The trees that were not harvested continued to photosynthesize.",
                            "All green plants photosynthesize, and during photosynthesis, plants produce food (glucose), which they use in cellular respiration or for growth and maintenance of body structures."),
                            p("Also, the spaces left behind by the trees that were harvested were open, sunny areas.",
                            "These spaces were suitable for some seeds to germinate, develop, and grow into adult trees.",
                            "In fact, the soil in any forest contains lots of seeds that will germinate when conditions are favorable (i.e., an open space increases light levels)."),
                            p("The increase in the biomass of living trees did not come from absorption of large carbon molecules in the soil.",
                            "Plants do not eat food in the same way that animals or fungi do (by incorporating large organic molecules into their bodies); they make their own food via photosynthesis."),
                            actionButton(label = "Move on to the next question", inputId = "Next2D"))))
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "Intro2D",
                        p("So, we know that forests contain a lot of biomass, much of which is made up of carbon atoms.",
                        "After forests are logged, the remaining trees grow larger as they photosynthesize and add mass to their body structures, and new trees germinate from seeds."),
                        p("In this assignment, we will only focus on matter and energy in the living trees that were not harvested or killed during logging.",
                        "However, one thing to be aware of is that the trees that were killed during logging (knocked over by harvested trees or damaged by equipment) will still exist in the forest as dead logs.",
                        "These trees will decompose, meaning that their body tissues will be consumed by fungi, bacteria, and various animals (especially insects).",
                        "A large portion of the molecules from the dead trees’ body tissues will therefore be food for these organisms.")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "2D", 
                        label = "(D) The mass of the carbon in the living trees in the forest hectare increased by 47,000,000 g (~ 47 cars) over the 50-year period. Where did the carbon come from? Choose the best answer.", 
                        choiceNames = c("None selected", 
                            "Sunlight", 
                            "Organic matter in the soil", 
                            "Nutrients in the soil",
                            "Gases in the atmosphere"), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2 D", inputId = "Submit2D"))),
                    shinyjs::hidden(div(id = "Feedback2D", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Sunlight is energy, not matter.",
                            "Matter and energy cannot be converted into one another in biological systems."),
                            p("Plants do not eat food like animals or fungi, and therefore do not take in large organic molecules."),
                            p("Plants use nutrients in the soil, but these nutrients make up a small percentage of a plant’s mass."),
                            p("Plants are made up mostly of carbon and oxygen, and they get these atoms from carbon dioxide in the atmosphere (the air surrounding Earth).",
                            "During photosynthesis, plants combine carbon dioxide and water to form glucose (and oxygen as a byproduct) in a chemical reaction.",
                            "The glucose is used by the plant as food, and some of this glucose is used by the plant to add to their body structures.")),
                    p(class="text-warning", "End of Part 2, please move on to Part 3 using the tabs at the top of the page.")))
                )
            )
        )
    ),
    tabPanel("Part 3", 
        fluidPage(
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    tags$h3("Part 3"),
                    p(class="text-primary", "There are 3 questions in this section (3A-C)."),
                    p("Please complete Parts 1 and 2 before beginning this section.")
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "IntroPart3",
                        tags$h3("How much carbon do trees take in for photosynthesis?"),
                        p("Scientists estimated the rate of photosynthesis for the trees in the forest hectare.",
                        "This was possible using a tool called a “portable photosynthesis system”, which can detect the gases going into and coming from leaves.",
                        "They measured photosynthesis in terms of the carbon atoms (in carbon dioxide gas molecules) taken up by the trees from the atmosphere.",
                        "Using these measurements, they estimated the total amount of carbon that will be taken up by trees for a 50-year period."),
                        p("As a review, in photosynthesis, many small, lower-energy molecules (carbon dioxide gas and water) are used to make one large, higher-energy molecule (glucose) along with some leftover molecules (oxygen gas).",
                        "Sunlight provides the energy to do the work (breaking small molecules and forming large molecules).")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "3A", 
                        label = "(A) Over the 50-year period, do you think that the amount of carbon that the trees will take in for photosynthesis will be less than, about equal to, or greater than the amount of carbon that they gained in their tissues as dry biomass?", 
                        choiceNames = list("None selected", 
                                            "The trees will take in less carbon for photosynthesis than the amount of carbon that they will gain in their tissues as dry biomass.", 
                                            "The trees will take in about the same amount of carbon for photosynthesis as the amount of carbon that they will gain in their tissues as dry biomass.", 
                                            "The trees will take in more carbon for photosynthesis than the amount of carbon that they will gain in their tissues as dry biomass."), 
                        choiceValues = c("None selected", "A", "B", "C"), selected = "None selected", width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 3A", inputId = "Submit3A"))),
                    p(),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "View data for photosynthesis", inputId = "PhotosynthesisButton")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("PhotosynthesisPlot", width = "80%"),
                    p(),
                    shinyjs::hidden(div(id = "Feedback3A", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("This graph shows the total (cumulative) amount of carbon that will be taken up by the living trees in the forest hectare over the 50-year period.",
                            "Remember from Part 2 that the trees will gain about 47,000,000 g of carbon (~47 cars) in dry biomass over the same period."),
                            actionButton(label = "Move on to the next section", inputId = "Next3B"))))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "3B", 
                        label = "(B) Use the figure above to answer this question. About how many grams of carbon will be taken in for photosynthesis by the living trees in this forest hectare over the 50-year period? (Note: this is not a trick question, we just want you to practice reading a graph).", 
                        choiceNames = list("None selected",
                            "About 10,000,000 g of carbon (~10 cars)",
                            "About 50,000,000 g of carbon (~50 cars)",
                            "About 100,000,000 g of carbon (~100 cars)",
                            "About 150,000,000 g of carbon (~150 cars)",
                            "About 200,000,000 g of carbon (~200 cars)"), 
                        choiceValues = c("None selected", "A", "B", "C", "D", "E"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 3B", inputId = "Submit3B"))),
                    shinyjs::hidden(div(id = "Feedback3B", 
                        tags$ul(tags$strong("Remember the following:"), 
                            p("About 200,000,000 g (~200 cars) of carbon will be taken in by the living trees in the forest hectare over the 50-year period.",
                            "This is much greater than the 47,000,000 g (~47 cars) of carbon that the trees gained in dry biomass (see Part 2)."),
                        actionButton(label = "Move on to the next question", inputId = "Next3C"))))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "3C", 
                        label = "(C) The trees will take in MORE carbon for photosynthesis than the amount of carbon that they will gain in their tissues. What happened to the remaining carbon? Select the best explanation.", 
                        choiceNames = list("None selected",
                            "The remaining carbon will be used as an input for cellular respiration.", 
                            "The remaining carbon will be burned up and converted to energy.", 
                            "The remaining carbon will be secreted by the roots as waste."), 
                        choiceValues = c("None selected", "A", "B", "C"), selected = "None selected", width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 3C", inputId = "Submit3C"))),
                    p(),
                    shinyjs::hidden(div(id = "Feedback3C",
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("The glucose molecule that the tree produces during photosynthesis can be added to its tissues OR it can be used in metabolism (i.e., cellular respiration).",
                            "A lot of the carbon taken in for photosynthesis was used as inputs for cellular respiration.",
                            "Trees are living organisms, and like all living things, they undergo chemical processes (i.e, metabolic processes) to stay alive.",
                            "Cellular respiration is a metabolic process that allows energy to become available to the trees for work (growth, maintenance, etc.)."),
                            p("Remember that matter cannot be destroyed and matter cannot be converted into energy in biological systems."),
                            p("Trees do not produce waste in the same way that organisms that consume food (animals and fungi) do, and they do not secrete a considerable amount of carbon from their roots as waste.")),
                            p(class="text-warning", "End of Part 3, please move on to Part 4 using the tabs at the top of the page.")))
                )
            )
         )
    ),
    tabPanel("Part 4",
        fluidPage(
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    tags$h3("Part 4"),
                    p(class="text-primary", "There are 4 questions in this section (4A-D)."),
                    p("Please complete Parts 1-3 before beginning this section.")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "IntroPart4",
                        tags$h3("How much carbon do trees release for cellular respiration?"),
                        p("The scientists used similar methods to estimate cellular respiration for the living trees.",
                        "They measured cellular respiration in terms of the carbon that was released by the trees to the atmosphere.",
                        "Using these measurements, they estimated the total (cumulative) amount of carbon that will be released by the living trees in the forest hectare for a 50-year period."),
                       actionButton(label = "View cellular respiration data", inputId = "CellularRespirationButton")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "CellularRespirationPlotShow", 
                        plotOutput("CellularRespirationPlot", width = "80%")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "4A", 
                        label = "(A) Use the figure above to answer this question. About how many grams of carbon will be released for cellular respiration by the living trees in this forest hectare over the 50-year period? (Again: this is not a trick question).", 
                        choiceNames = c("None selected", 
                            "About 10,000,000 g of carbon (~10 cars)", 
                            "About 50,000,000 g of carbon (~50 cars)", 
                            "About 100,000,000 g of carbon (~100 cars)",
                            "About 150,000,000 g of carbon (~150 cars)",
                            "About 200,000,000 g of carbon (~200 cars)"), 
                        choiceValues = c("None selected", "A", "B", "C", "D", "E"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 4A", inputId = "Submit4A"))),
                    shinyjs::hidden(div(id = "Feedback4A", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("About 150,000,000 g (~150 cars) of carbon will be released by the living trees in the forest hectare over the 50-year period."),
                        actionButton(label = "Move on to the next question", inputId = "Next4B"))))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "4B", 
                        label = "(B) What happened to the carbon atoms that were used by the trees as inputs for cellular respiration?", 
                        choiceNames = c("None selected", 
                            "They left the trees’ bodies as gases.", 
                            "They left the trees’ bodies as organic molecules.", 
                            "They were burned up in the trees’ bodies and no longer exist."), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 4B", inputId = "Submit4B"))),
                    shinyjs::hidden(div(id = "Feedback4B", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("During cellular respiration, a glucose molecule (a sugar) and oxygen gas molecules are rearranged into many small, lower-energy molecules (carbon dioxide and water).",
                            "The carbon dioxide and water vapor molecules do not remain within the plant, but rather leave the plant's body as gas molecules, into the surrounding air."),
                        actionButton(label = "Move on to the next question", inputId = "Next4C"))))
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(checkboxGroupInput(inputId = "4C", 
                        label = "(C) Select ALL true statements about cellular respiration in the living trees in the tropical forest hectare.", 
                        choiceNames = c("None selected", 
                            "Cellular respiration occurred in all living cells in the trees’ roots, but not in the living cells in the trees’ leaves or stem.", 
                            "Cellular respiration occurred in all living cells in the trees’ roots, leaves, and stem.",
                            "Cellular respiration occurred in the trees during the night, but not during the day.", 
                            "Cellular respiration occurred in the trees during the day and night."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 4C", inputId = "Submit4C"))),
                    shinyjs::hidden(div(id = "Feedback4C", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Cellular respiration occurs in all living plant cells, whether the cells are in the leaves, stem (trunk), or roots of a plant.",
                            "The same goes for living cells in trees.",
                            "Cellular respiration occurs in plants all the time, not just at night."), 
                            p("However, the rate of cellular respiration will change depending on the body part/tissue or the external environment.",
                            "For example, cellular respiration may occur at a faster rate if it is sunny (and a lot of photosynthesis is occurring)."),
                        actionButton(label = "Move on to the next section", inputId = "NextIntro4D"))))
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "Intro4D",
                        p("Now, the amount of carbon that was taken up by trees (during photosynthesis) and the amount of carbon that was used by trees (during respiration), makes more sense given that we know the biomass of the forest trees increased over the 50-year period.",
                        "Again, when trees are growing, the amount of carbon they reorganize into large carbon-containing molecules from carbon dioxide via photosynthesis is greater than the amount of carbon they release to the air via respiration."),
                    actionButton(label = "View comparison of photosynthesis and respiration", inputId = "PhotoRespButton")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "ComparePhotoRespPlotShow", plotOutput("ComparePhotoRespPlot", width = "80%")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(checkboxGroupInput(inputId = "4D", 
                        label = "(D) Select ALL true statements about the living trees in the tropical forest hectare.", 
                        choiceNames = c("None selected", 
                            "The trees in the forest hectare released more carbon (as carbon dioxide) than they added to their bodies as dry biomass.", 
                            "The trees in the forest hectare took in more carbon (in carbon dioxide) than they added to their bodies as dry biomass.", 
                            "The same processes of photosynthesis, growth, and cellular respiration occur in an entire hectare of trees as occurred in a single sunflower plant.",
                            "After a 50-year period, the logged tropical forest returned to exactly the same state it was in before it was logged: with the same total biomass and the same number of tree species."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 4D", inputId = "Submit4D"))),
                    shinyjs::hidden(div(id = "Feedback4D", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("The trees in the forest hectare took in a huge amount of carbon (200,000,000 g) as carbon dioxide gas, which the trees used as an input for photosynthesis.",
                            "During photosynthesis, the carbon in carbon dioxide was converted to carbon in sugar molecules (glucose).",
                            "A lot of the carbon in glucose was used as inputs for cellular respiration.",
                            "The trees carried out cellular respiration in order to make energy available for metabolic activities in their bodies.",
                            "In fact, more carbon in glucose was used as inputs to cellular respiration than was used for growth.",
                            "Thus, the trees in the forest hectare did release more carbon (as carbon dioxide) than they added to their bodies as dry biomass."),
                            p("The same processes of photosynthesis, growth, and cellular respiration occur in an entire hectare of trees as occurred in a single sunflower plant.",
                            "So, once you understand biological processes at the organismal level, you are better prepared to think about larger scales: populations of organisms, communities, and ecosystems."),
                            p("The living trees in the forest hectare will grow to the same dry biomass after a 50-year period following logging.",
                            "However, we do not have information about the tree species that were present in the forest before and after logging.",
                            "So, we do not know whether the forest included the same number of species after the 50-year period.",
                            "Understanding which tree species are present is important for many reasons: different species have different economic value to humans; different tree species have relationships with different species of fungi, bacteria, insects, etc.; and different species have different ecosystem functions.")),
                            p(class="text-success", "End of the activity, all of your responses have been recorded.")))
                    )
                )
            )
        )
    )
)