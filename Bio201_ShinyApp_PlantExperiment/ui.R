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
    title = "Movement of matter in plants test",
    tabPanel("Introduction", 
        fluidPage(theme = shinytheme("cosmo"),
        shinyjs::useShinyjs(),
            tags$h3("Your assignment"),
        p("In this activity, you will work through two introductory modules about plants and two experiments involving a sunflower (a plant).",
        "You will predict what will happen to the mass of the sunflower and other objects in the experiments.",
        "Over the course of the activity, you will shift perspectives from thinking about the parts of a system to thinking about the system as a whole."),
        p(class="text-warning",
           tags$strong("Instructions (read carefully!):")),
            p("Use the tabs at the top of the page to navigate through the experiments.",
            "Begin with Plant Basics 1.",
            "As you answer questions, new questions will appear below.",
            "Take time to think before selecting each answer.",
            tags$em("You will only have one chance to answer each question.")
            ),
        fluidRow(
            column(12,
                tags$h4("Enter your email"),
                p("Before beginning the activity, make sure that your ", tags$strong("stonybrook.edu"), " email has been recorded in the box below."),
                textInput(inputId = "name", label = '', "Enter email here before beginning Plant Basics 1.", width = "100%"),
                actionButton(label = "The email above is correct", inputId = "NameButton"),
                shinyjs::hidden(div(id = "FeedbackNames", 
                            p(class="text-warning", "email recorded, please begin Plant Basics 1 using the tabs at the top of the page.")))
                )
            ),
        fluidRow(
            column(12, style='padding-left:10px; padding-right:10px; padding-top:35px; padding-bottom:5px',
                p(strong("Sources used to create this activity:"), style = "font-size:12px;"),
                p("Blackman, G. E., J. N. Black, and A. W. Kemp. 1955. Physiological and Ecological Studies in the Analysis of Plant Environment.", tags$em("Annals of Botany"), " 19 (76): 527–548.
", style = "font-size:12px;"),
                p("Canvin, David T., Joseph A. Berry, Murray R. Badger, Heinrich Fock, and C. Barry Osmond. 1980. Oxygen Exchange in Leaves in the Light.", tags$em("Plant Physiology"), " 66: 302–7.", style = "font-size:12px;"),
                p("Dekov, I, T Tsonev, and I Yordanov. 2000. Effects of Water Stress and High-Temperature Stress on the Structure and Activity of Photosynthetic Apparatus of Zea Mays and Helianthus Annuus.", tags$em("Photosynthetica"), " 38 (3): 361–366.", style = "font-size:12px;"),
                p("Rowe, D. Bradley, Kristin L. Getter, and Angela K. Durhman. 2012. Effect of Green Roof Media Depth on Crassulacean Plant Succession over Seven Years.", tags$em("Landscape and Urban Planning"), " 104 (3–4): 310–19.", style = "font-size:12px;")
                )
            )  
        )
    ),
    tabPanel("Plant Basics 1", 
        fluidPage(
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    tags$h3("Plant Basics 1"),
                    p(class="text-primary", "There are two questions in this section (PB1 A-B).")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    tags$h3("What is a plant made of?"),
                    p("You’ve probably noticed that plants grow from tiny seeds into large individuals.",
                    "Below is an example of a sunflower seed growing into a large sunflower plant (about six feet tall)."),
                    p(),
                    img(src='Plant_Scales.png', width = "750px"),
                    p(),
                    p("Most plants have leaves, a stem/trunk, and roots, and these body parts are made up of tissues.",
                    "If we zoom into the tissues in the sunflower’s leaves, we can observe that the plant cells are surrounded by water (we will return to this later).",
                    "Plant cell walls are made up mostly of a molecule called cellulose.", 
                    "Different kinds of molecules have different masses and different properties.",
                    "For example, molecules of cellulose together help give plants structure.", 
                    "You are probably more familiar with cellulose than you think--cotton is almost entirely made up of cellulose.",
                    "Notice the structure of the cellulose molecule, and compare this with the structure of a glucose molecule (a sugar)."),
                    p("A cellulose molecule and a glucose are shown in more detail in the figure below."),
                    p(),
                    img(src='CompareCelluloseGlucose.png', width = "600px")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::disabled(checkboxGroupInput(inputId = "PB1A", 
                        label = "(A) Which of the following are TRUE about cellulose molecules and glucose molecules? Select all correct statements.", 
                        choiceNames = list("None selected", 
                            "Both molecules are made up only of carbon, oxygen, and hydrogen atoms.",
                            "Cellulose is a larger molecule than glucose (in size and mass).",
                            "Cellulose has more chemical bonds and more atoms than glucose.", 
                            "Cellulose is made up of many glucose molecules joined together."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), selected = "None selected", width = "50%")),
                    p("If you are having trouble submitting your responses, make sure: 1) your email is filled in on the 'Introduction' tab, and 2) you have unchecked 'None selected.'"),
                    p(class="text-warning", tags$em("When you press the submit button, your responses will be recorded and you will no longer be able to change your answer.")),
                    shinyjs::disabled(actionButton(label = "Submit Plant Basics 1 A", inputId = "SubmitPB1A")),
                    shinyjs::hidden(div(id = "FeedbackPB1A", 
                        tags$strong("Answer explanation:"), 
                        p("Both cellulose and glucose are made up entirely of carbon, oxygen, and hydrogen atoms.",
                            "Cellulose is a much larger molecule than glucose, and it includes more atoms and more chemical bonds.",
                            "To put it simply, cellulose is a very large molecule made up of many smaller glucose molecules (hundreds) joined together in a chain."),
                        actionButton(label = "Move on to the next section", inputId = "NextWetDryMass")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "WetDryMass",
                    tags$h3("Why should we think about a plant’s wet mass and dry mass separately?"),
                    p("Water is found within all of a plant's tissues (inside and outside of many of the plant's cells).",
                    "However, scientists do ", tags$u("not"), " consider the water to be the matter that makes up the plant's tissues (like cellulose).",
                    "In other words, water is not 'counted' as part of the plant itself."),
                    p("Imagine a small sunflower plant that you want to know the mass of.",
                    "You dig up the plant and place it on a scale--it weighs 10 grams.",
                    "However, almost 90% of that mass is 'water weight,' which is referred to as the plant's ", tags$strong("wet mass."),
                    "Next, you dry out the plant until all of the water has evaporated (scientists use drying ovens to do this).",
                    "You weigh the plant again, and it weighs 1 g.",
                    "The mass after the water has been removed is referred to as the plant’s ", tags$strong("dry mass.")),
                    p(),
                    img(src='DryWetMassPlantBasics.png', width = "250px"),
                    p(),
                    p("Scientists who study plants are interested in dry mass.",
                    "This is because (1) water ", tags$em("surrounds"), " a plant’s tissues but it isn’t ", tags$em("a part of"), 
                    " the plant’s tissues, and (2) wet mass can change from day to day (plant wet mass will be significantly different on a dry day versus after a rain)."),
                    actionButton(label = "Move on to the next section", inputId = "NextAtomConcentration")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "AtomConcentration", 
                        tags$h3("What atoms make up a plant’s dry mass?"), 
                        p("Above, we discussed how cellulose is one of the most common molecules in plants, and cellulose contains carbon, oxygen, and hydrogen atoms.",
                        "Of course, plant tissues are made up of many other types of molecules too; these include starch, chlorophyll, DNA, sucrose, and fatty acids, among many others.",
                        "The figure below will show the concentration of elements (e.g., hydrogen, oxygen) in all parts of a plant’s body.",
                        "You can measure this by analyzing ground-up dry plant tissue using a tool called a gas chromatograph."),
                        actionButton(label = "View atom concentration data", inputId = "AtomConcentrationButton")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("AtomConcentrationPlot", width = "70%")
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(checkboxGroupInput(inputId = "PB1B", 
                        label = "(B) According to the figure above (select all that apply)...", 
                        choiceNames = c("None selected", 
                            "...most of the dry mass in a plant comes from carbon and oxygen atoms.", 
                            "...plants have fewer hydrogen atoms than oxygen atoms.", 
                            "...plant tissues contain potassium, phosphorus, magnesium, and calcium atoms."), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit Plant Basics 1 B", inputId = "SubmitPB1B"))),
                    shinyjs::hidden(div(id = "FeedbackPB1B", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Most of the dry mass in a plant comes from carbon and oxygen atoms.",
                            "These atoms are abundant in cellulose molecules.",
                            "Even though hydrogen atoms are common in plants, hydrogen atoms have a very small mass.",
                            "We will talk about this more in the next tab."), 
                            p("The figure above shows the concentration of each element in a plant’s body.",
                            "The concentration of a particular element is the MASS, not the NUMBER, of its atoms in 1 kg of plant dry mass.",
                            "Carbon atoms have much more mass than hydrogen atoms, so if a plant has the same NUMBER of each, then the carbon atoms will have a higher CONCENTRATION than the hydrogen atoms.",
                            "In reality, plants have MORE hydrogen atoms than oxygen atoms (not fewer as indicated in the question), but because of the low mass of each hydrogen atom, the concentration of these atoms is very low."), 
                            p("Plants do contain potassium, phosphorus, magnesium, and calcium atoms (even though these atoms are not present in cellulose molecules).",
                            "In plants, phosphorus can be found in DNA, protein, and other molecules; magnesium is a part of chlorophyll molecules; and calcium is a part of membrane molecules in cell walls; and potassium atoms are dissolved in the liquid parts of plant cells.")),
                            p("To reiterate, cellulose is one of the most common molecules making up plant cells and tissues.",
                    "Cellulose is made up entirely of carbon, oxygen, and hydrogen atoms, so it is not surprising that these atoms make up a lot of the dry mass of plants."),
                            actionButton(label = "Move on to the next section", inputId = "NextCellulose")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "Cellulose",
                        tags$h3("Is cellulose the ", tags$em("only"), " substance making up a plant’s dry mass?"),
                        img(src='CelluloseChain.png', width = "650px"),
                        p("In this assignment, we have been focusing on cellulose both because it is extremely abundant and because it is a molecule made up of many glucose molecules.",
                            "Although plants have a lot of cellulose, they also contain many other kinds of molecules.",
                            "You are probably familiar with some of these molecules."), 
                        p("Glucose and cellulose are both carbohydrate molecules.",
                        "Plants also contain other kinds of ", tags$strong("carbohydrate molecules"), ", including starch and fructose.",
                        tags$u("Starch"), " molecules are common carbohydrates in root tissues.",
                        "Starch, like cellulose, is made up of glucose molecules.",
                        "Starch is an important source of matter and energy for plants, meaning that plants can use starch as an input for tissue building or cellular respiration.",
                        "Potatoes, for example, contain a lot of starch molecules (potatoes are underground parts of a potato plant’s stem, see the figure below).",
                        tags$u("Fructose"), " molecules are sugars that are common in fruit tissues.",
                        "Strawberries contain a lot of fructose molecules (strawberries are the fruits from strawberry plants, see the figure below)."),
                        p("Plant tissues also include many different kinds of ", tags$strong("protein molecules"), ", which serve various functions in plants.",
                        "Proteins are an important source of matter for plants; they are used to add structure, to allow movement (e.g., during mitosis), to help chemical reactions occur (enzymes), or to perform other functions (e.g., ion channel proteins).",
                        "As an example, chickpeas have a lot of protein molecules (chickpeas are the seeds of chickpea plants, see the figure below).",
                        "Proteins can be used as a source of energy in plants (i.e., they can be used as inputs to certain stages of cellular respiration), but it is not very common."),
                        p("Plant tissues also contain ", tags$strong("lipid molecules"), ", which are important components of cell membranes and sources of matter and energy.",
                        tags$u("Oil"), " molecules (a kind of lipid) are very abundant in seeds.",
                        "When seeds start growing, they require (1) a source of matter (carbon) to make body structures, and (2) a source of energy for cellular respiration.",
                        "For example, the walnuts that we eat contain between 60-70% oils (walnuts are the seeds of walnut trees, see the figure below)."),
                        p("It is important to note that there can be many different molecules that can be inputs for cellular respiration (and thus, used as a source of energy).",
                        "Above, we mentioned that starch (a carbohydrate), oils (lipid), and to a lesser extent proteins, are molecules that can be used as sources of energy.",
                        "In fact, plants often use sucrose instead of glucose as the initial input for cellular respiration. "),
                        p("Plants also contain ", tags$strong("minerals"), ", but minerals are not a source of matter and energy for plants.",
                        "A few examples of minerals that can be found in plants are described to illustrate their diversity.",
                        "(1) Iron is a part of molecules (hemes) that are associated with proteins used in cellular respiration and photosynthesis.",
                        "(2) Magnesium is a part of green pigment molecules (chlorophyll) that absorb sunlight in photosynthesis.",
                        "(3) Calcium and potassium are charged atoms (ions) that are dissolved in water in plant cells and used as messenger ions or to establish gradients for metabolic processes."),
                        img(src='PlantsNutrientComposition.png', width = "650px"),
                        p(),
                        actionButton(label = "View nutrient data for potatoes, strawberries, chickpeas, and walnuts", inputId = "NutrientCompositionButton")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("NutrientCompositionPlot", width = "70%")
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(checkboxGroupInput(inputId = "PB1C", 
                        label = "(C) According to the figure above (select all that apply)...", 
                        choiceNames = c("None selected", 
                            "...walnuts have a higher percentage of lipids than potatoes, strawberries, or chickpeas.", 
                            "...potatoes and strawberries have a higher percentage of carbohydrates than chickpeas or walnuts.", 
                            "...chickpeas and walnuts have a higher percentage of protein than potatoes or strawberries.",
                            "...potatoes, strawberries, chickpeas, and walnuts are mostly made of minerals."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit Plant Basics 1 C", inputId = "SubmitPB1C"))),
                    shinyjs::hidden(div(id = "FeedbackPB1C", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Walnuts have a higher percentage of lipids than the other food items listed here. Specifically, walnuts have a lot of lineoleic acid (a kind of oil)."),
                            p("The kinds of carbohydrates shown here are fructose (a small molecule), starch (a large molecule), and other (including many types of carbohydrate molecules: glucose, sucrose, cellulose, etc.). Potatoes and strawberries have a higher percentage of carbohydrates than the other food items."),
                            p("Chickpeas and walnuts have higher percentages of proteins than the other foods. Both chickpeas and walnuts are plant seeds, and seeds need a source of protein to carry out early growth and development."),
                            p("Minerals are not extremely abundant in plants relative to carbohydrates, proteins, and lipids. None of the food items here is mostly made up of minerals."),
                            p("Last, note that each of bars in the figure represents the nutrient percentages for a PART of a plant. Were we to look at an entire strawberry plant, for example, the nutrient breakdown would be different.")),
                        p(class="text-warning", "End of Plant Basics 1, please move on to Plant Basics 2 using the tabs at the top of the page.")))
                )
            )
        )
    ),
    tabPanel("Plant Basics 2",
        fluidPage(
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    tags$h3("Plant Basics 2"),
                    p(class="text-primary", "There are four questions in this section (PB2 A-D)."),
                    p("Please complete Plant Basics 1 before beginning this section.")
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "PlantMass",
                        tags$h3("Where does plant mass come from?"),
                        p("In the previous tab, we discussed some of the molecules and atoms that make up plants.",
                        "Now, we will determine where the matter that makes up plants comes from.",
                        "Before really getting into this question, we have to review some chemistry basics."),
                        tags$h4("Do all atoms have the same mass?"),
                        p("Even though atoms are incredibly small, they have mass.",
                        "Different kinds of atoms (called elements) have different masses.",
                        "The following figure shows the masses of three kinds of atoms that are common in plants (carbon, oxygen, and hydrogen).",
                        "Even though hydrogen is common in plant tissues, it does not make up very much of the mass of plants because it weighs so little."),
                        actionButton(label = "View relative atom mass data", inputId = "AtomMassesButton")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("AtomMassesPlot", width = "50%"),
                    shinyjs::hidden(div(id = "AtomMassesCaption",
                        tags$figcaption("Relative masses of a hydrogen atom, a carbon atom, and an oxygen atom. These kinds of atoms are common in plants and other organisms.")))
                )
            ),
             fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(checkboxGroupInput(inputId = "PB2A", 
                        label = "(A) According to the figure above (select all that apply)...", 
                        choiceNames = c("None selected", 
                            "...an oxygen atom weighs more than a carbon atom.", 
                            "...hydrogen atoms are very rare in plants.", 
                            "...carbon atoms weigh more than hydrogen atoms.",
                            "...plants are mostly made of oxygen atoms."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit Plant Basics 2 A", inputId = "SubmitPB2A"))),
                    shinyjs::hidden(div(id = "FeedbackPB2A", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("This figure shows the relative masses of hydrogen, carbon, and oxygen atoms.",
                                "However, this figure does not give us any information specific to plants.",
                                "Rather, it shows the masses of any hydrogen, carbon, or oxygen atom, regardless of where the atom is located.",
                                "Oxygen atoms weigh more than carbon atoms, and carbon atoms weigh more than hydrogen atoms."),
                            actionButton(label = "Move on to the next section", inputId = "NextGasCanisters"))))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "GasCanistersIntro",
                        p("Atoms can bond together to form molecules.",
                        "Different molecules have different masses and may also have different properties.",
                        "As one example, oxygen gas is a molecule in which two oxygen atoms are bonded together.",
                        "Air is made up of about 20% oxygen gas.",
                        "Even though it is a gas and you can’t see it, oxygen gas has mass (and by extension, air has mass)."),
                        p(),
                        img(src='GasCanisters_WithLids.png', width = "500px")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "PB2B", 
                        label = "(B) You use special equipment to suck the air out of two identical canisters. Now you have two empty canisters that have exactly the same weight. Then, you pump one canister with carbon dioxide gas, and the other with the same number of molecules of oxygen gas. You place a lid on top of the canisters to keep the gases inside. Which canister weighs more, or do they weigh the same amount?", 
                        choiceNames = c("None selected", 
                            "The canister filled with oxygen gas weighs more.", 
                            "The two canisters weigh the same amount.", 
                            "The canister with carbon dioxide gas weighs more.",
                            "There is not enough information to answer the question."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit Plant Basics 2 B", inputId = "SubmitPB2B"))),
                    shinyjs::hidden(div(id = "FeedbackPB2B", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("The canister with carbon dioxide gas weighs more than the canister with the same number of molecules of oxygen gas because the carbon dioxide molecule has a larger mass than the oxygen gas molecule.",
                            "Oxygen gas is made up of two oxygen atoms and carbon dioxide is made up of two oxygen atoms, ", tags$u("plus a carbon atom."),
                            "The image below shows a simplified visual representation of the relative masses of these molecules."), 
                            img(src='CO2O2.png', width = "200px"),
                            p(),
                            actionButton(label = "Move on to the next section", inputId = "NextMoleculeMasses"))))
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "MoleculeMasses",
                        p("Just because we cannot see a molecule with our own eyes, doesn’t mean that it lacks mass.",
                        "In the graphs below, notice how the masses of some of the atoms and molecules we have discussed so far differ.",
                        "As shown in the graph, a molecule of carbon dioxide (containing one carbon atom and two oxygen atoms) weighs more than a molecule of oxygen gas (containing two oxygen atoms).",
                        "Also notice that a molecule of carbon dioxide gas weighs ", tags$u("more"), " than a molecule of water.",
                        "Glucose, a sugar molecule, weighs much more than any of the other atoms or molecules in the figure. "),
                        plotOutput("MoleculeMassesPlot", width = "70%"),
                        tags$figcaption("Relative masses of atoms and molecules that are common in plants and other organisms.")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "PB2C", 
                        label = "(C) Which option below correctly orders atoms and molecules from smallest to largest mass?", 
                        choiceNames = c("None selected", 
                            "Oxygen atom, carbon atom, carbon dioxide molecule, glucose molecule, water molecule", 
                            "Oxygen atom, carbon dioxide molecule, water molecule, glucose molecule, hydrogen atom", 
                            "Carbon atom, oxygen atom, water molecule, carbon dioxide molecule, glucose molecule",
                            "Carbon atom, carbon dioxide molecule, water molecule, oxygen atom, glucose molecule"), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit Plant Basics 2 C", inputId = "SubmitPB2C"))),
                    shinyjs::hidden(div(id = "FeedbackPB2C", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("The atoms and molecules in the figure are ordered from smallest to largest mass from left to right: hydrogen atom, carbon atom, oxygen atom, water molecule, carbon dioxide molecule, glucose molecule"))))
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "CelluloseMasses",
                        p("Notice that cellulose, which is a molecule made up of a long chain of glucose molecules, is not shown in this figure.",
                        "Click the button below to see how the mass of each of these molecules compares to the mass of cellulose."),
                        actionButton(label = "Show how the mass of these molecules compares to cellulose", inputId = "CelluloseMassesButton")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "CelluloseMassesCaption",
                        plotOutput("CelluloseMassesPlot", width = "80%"),
                        p("In this figure, the atoms and molecules we have been discussing are shown next to the mass of cellulose.",
                        "The mass of cellulose is so large that you can’t even see the masses of the other molecules."),
                        actionButton(label = "Move on to the next section", inputId = "NextPhotosynthesis")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "Photosynthesis",
                        tags$h3("How do plants make cellulose?"),
                        tags$h4("Photosynthesis"),
                        p("Plants are organisms that photosynthesize.",
                        "In photosynthesis, many small, lower-energy molecules (carbon dioxide and water) are used to make one large, higher-energy molecule (glucose) and leftover molecules (oxygen gas).",
                        "Sunlight provides the energy to do the work (breaking small molecules and forming large molecules)."),
                        img(src='Photosynthesis.png', width = "700px"),
                        p(),
                        p("The glucose molecule that a plant produces during photosynthesis can be added to the plant's tissues OR it can be used in metabolism (i.e., cellular respiration).",
                        "The same glucose molecule CANNOT do both.",
                        "Which of these paths (tissue building vs. metabolism) a particular glucose molecule will follow depends on the environment and the plant’s biological demands.",
                        "The figure below shows a visual depiction of the two paths a glucose molecule produced by photosynthesis could take."),
                        p(),
                        img(src='GlucoseDestination.png', width = "500px"),
                        p(),
                        actionButton(label = "Move on to the next section", inputId = "NextRespiration")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "Respiration",
                        tags$h3("How do plants use glucose to do work?"),
                        tags$h4("Cellular respiration"),
                        p("Like all living things, plants undergo chemical processes (i.e, metabolic processes) to stay alive.",
                        "You can think of metabolism as the “fees” that the plant pays to keep on living.",
                        "One important metabolic process is cellular respiration.",
                        "Cellular respiration is a metabolic process that allows energy to become available to the plant for work (growth, maintenance, etc.).",
                        "Some of the glucose that plants produce in photosynthesis will be inputs in cellular respiration."),
                        p("In cellular respiration, a large, higher-energy molecule (glucose) is used as a source of matter and energy to do work in the plant's body.",
                        "During cellular respiration, a glucose molecule and oxygen gas molecules are rearranged into many small, lower-energy molecules (carbon dioxide and water).",
                        "These small, lower-energy molecules do not remain within the plant, but rather leave the plant's body as an output of cellular respiration.",
                        "However, while ALL of the MATTER (and thus mass) of the glucose molecule leaves the body as gases, most of the ENERGY of the glucose molecule stays inside the body and is stored in a molecule called ATP.",
                        "The energy stored in ATP is now readily available to the plant, and ATP can be thought of as the “batteries” that power metabolic processes in the plant’s body.",
                        "Therefore, cellular respiration is essential for conducting metabolic activities in organisms.",
                        "The image below shows a visual representation of cellular respiration.",
                        "Keep in mind that ALL of the atoms shown as the outputs of the cellular respiration reaction (on the right) leave the plant’s body as gases. "),
                        img(src='CellularRespiration.png', width = "700px")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(checkboxGroupInput(inputId = "PB2D", 
                            label = "(D) Which of the following statements about photosynthesis and cellular respiration in plants are true? Select all correct responses.", 
                            choiceNames = c("None selected", 
                                "The same number of atoms are found in the input molecules and the output molecules of photosynthesis.", 
                                "The same number of atoms are found in the input molecules and the output molecules of cellular respiration.", 
                                "The types of molecules that result from photosynthesis are the same as the inputs into cellular respiration.",
                                "All glucose molecules that a growing plant produces during photosynthesis are used by the plant as inputs in cellular respiration."), 
                            choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%", selected = "None selected")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit Plant Basics 2 D", inputId = "SubmitPB2D"))),
                    shinyjs::hidden(div(id = "FeedbackPB2D", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Matter cannot be destroyed, so the number of atoms in the inputs of a chemical reaction (like photosynthesis or cellular respiration) will be the same as the number of atoms in the outputs."),
                            p("Plants make glucose during photosynthesis, which they use as a source of matter and energy (i.e., food).",
                            "In cellular respiration, organisms use the matter and energy contained in food and transform it into matter and energy that can be used to do work in their bodies.",
                            "The types of molecules in the inputs and outputs of photosynthesis and cellular respiration are opposite one another. Therefore, The types of molecules that result from photosynthesis are the same as the inputs into cellular respiration."), 
                            p("Regardless, not every molecule of glucose that plants make during photosynthesis will be used by the plant for cellular respiration.",
                            "Plenty of glucose produced during photosynthesis goes towards making plant tissues.",
                            "Because the same glucose molecule cannot be used for both growth and metabolism, glucose that makes plant tissues would NOT go through cellular respiration.",
                            "If a plant is increasing in mass (i.e. growing), it MUST be using some of the glucose for growth (after all, the matter has to come from somewhere)."),
                            p("The rate of cellular respiration relative to photosynthesis will depend on various factors (the age of the plant, the plant species, temperature, precipitation, etc.), but on the whole, plants photosynthesize more than they respire.")),
                            actionButton(label = "Move on to the next section", inputId = "NextGrowth")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "Growth",
                    tags$h4("How does plant growth relate to atoms and molecules?"),
                    p("Some of the glucose that plants produce in photosynthesis will be used in growth and maintenance of plant tissues (leaves, stem/trunk, and roots).",
                    "These glucose molecules were not used in cellular respiration.",
                    "As we have been discussing, a lot of plant mass is made up of the molecule cellulose, which is a tissue composed of long chains made up of many glucose molecules.",
                    "The figure below shows how a cellulose chain gets longer by adding more glucose molecules.",
                    "Note that the figure shows the process in a simplified way, though the general idea is the same."),
                    img(src='PlantGrowth.png', width = "700px"),
                    p(),
                    p("We can link this depiction of growth (adding glucose to a long cellulose molecule) back to the discussion of a small sunflower seed growing into a large adult plant (see image below).",
                    "This sunflower increases in mass (i.e., grows) when some glucose molecules do not go through cellular respiration and instead help build plant tissues like cellulose (although some glucose must also be going through cellular respiration to provide sufficient energy for the growth process)."),
                    img(src='Plant_Scales.png', width = "750px"),
                    p(),
                    p(class="text-warning", "End of Plant Basics 2, please move on to Experiment 1 using the tabs at the top of the page.")))
                )
            )
        )
    ),
    tabPanel("Experiment 1", 
        fluidPage(
            fluidRow(
                column(12, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    tags$h3("Experiment 1: within-system perspective"),
                    p(class="text-primary", "There are six questions in this section (1A-F)."),
                    p("Please complete Plant Basics 1 and 2 before beginning this section.")
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "Experiment1Intro",
                        p("You decide that you want to conduct an experiment with sunflower plants in a sunny greenhouse in order to better understand changes in matter over time."),
                        p("You measure out 200 grams (g) of dry soil and add it to a small pot.",
                        "Then, you add 270 g of water to the pot.", "You place a clear plastic cover over the soil to prevent the water from evaporating (see the figure below)."),
                        p(),
                        img(src='Measurement.png', width = "300px"),
                        tags$figcaption("Measuring the soil and the water for Experiment 1."),
                        p(),
                        p("Next, you plant a small sunflower in the center of the pot.",
                        "The sunflower plant initially weighs 0.45 g.",
                        "However, plants contain a lot of water.",
                        "So, you estimate that the dry mass of the sunflower, or its mass if it is dried out and all of the water is removed from its body, is 0.05 g.",
                        "You let the sunflower grow in the pot for 10 days (see the figure below for the experimental set-up)."),
                        img(src='PlantInitialFinal.png', width = "350px"),
                        tags$figcaption("The sunflower plant at the beginning and the end of Experiment 1."),
                        p(),
                        p("After 10 days, you take measurements.",
                        "You dig up the sunflower plant and weigh it.",
                        "You also weigh the wet soil.",
                        "Then, you place the sunflower plant and the soil in an oven until they are completely dry, and weigh both again.",
                        "Using this method, you have measurements of the wet and dry mass of the sunflower plant and the soil (see the figure below)."),
                        p(),
                        img(src='DryWetMass.png', width = "270px"),
                        tags$figcaption("Measuring the wet mass (left column) and dry mass (right column) of the sunflower plant (top row) and the soil (bottom row) at the end of Experiment 1.")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(shinyjs::disabled(checkboxGroupInput(inputId = "1A", 
                        label = "(A) After 10 days, what do you predict will happen to the 270 g of water that you initially added to the soil? Select all correct responses.", 
                        choiceNames = list("None selected", 
                                            "Some of the water now no longer exists.", 
                                            "Some of the water is now in the soil.", 
                                            "Some of the water is now in the sunflower.", 
                                            "Some of the water is now in the air."), 
                        choiceValues = c("None selected", "A", "B", "C", "D"), selected = "None selected", width = "50%"))),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 1A", inputId = "Submit1A"))),
                    p(),
                    shinyjs::hidden(div(id = "Feedback1A", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Matter cannot be destroyed, so all of the water molecules still exist somewhere."), 
                            p("Some of the water will remain in the soil."), 
                            p("The sunflower plant will absorb some of the water with its roots.", 
                                "Plants are living organisms that need water for many reasons, including: to stay upright (otherwise they wilt), to keep cool (plants reduce their body temperature by evaporating water), and as an input of photosynthesis.",
                                "You may want to revisit the Plant Basics 1 tab to review water's role in plants."), 
                            p("So, even though you placed a plastic screen on top of the soil to prevent water from directly evaporating, some of the water will be in the air because of the biological processes carried out by the sunflower.")),
                        actionButton(label = "Move on to the next section", inputId = "Next1B")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "PlantInitialFinal", img(src='PlantInitialFinal.png', width = "350px"))),
                )
            ),
            fluidRow(
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "1B", 
                        label = "(B) What do you predict will happen to the mass of the sunflower plant at the end of Experiment 1 (after 10 days)? Note that the wet mass and the dry mass will show the same pattern.", 
                        choiceNames = list("None selected", "Decrease", "Increase", "Stay the same"), 
                        choiceValues = c("None selected", "A", "B", "C"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 1B", inputId = "Submit1B"))),
                    p(),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "View data for plant mass", inputId = "Experiment1PlantData"))),
                    p(),
                    shinyjs::hidden(div(id = "Feedback1B", 
                        tags$ul(tags$strong("Remember the following:"), 
                            p("Dry mass is the mass of the sunflower after all of the water has been evaporated from its body."), 
                            p("Also, the initial dry mass of the sunflower is so small (0.05 g) that it is difficult to see on graph 1B (above and to the right)."), 
                            tags$strong("Answer explanation:"), 
                            p("The mass of the sunflower (both wet mass and dry mass) increased from Day 1 to Day 10.", 
                            "In the following two questions, you will be asked why the mass increased.")),
                        actionButton(label = "Move on to the next section", inputId = "Next1C")))
                ),
                column(6,
                    plotOutput("PlantMass")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "PlantWetMass", img(src='WetMassPlant.png', width = "120px"),
                        tags$figcaption("Measuring the wet mass of the sunflower at the end of Experiment 1."))),
                    p(),
                    shinyjs::hidden(radioButtons(inputId = "1C", label = "(C) What process is responsible for MOST of the increase in the WET mass of the sunflower from Day 1 to Day 10? Choose the best answer. You may want to review Figure 1B before answering this question.", choiceNames = list("None selected", "The sunflower absorbed water from the soil through its roots. The water is now inside most tissues in the sunflower’s body.", "The sunflower produced glucose during photosynthesis, which it used to add mass to its leaves, roots, and stem.", "The sunflower absorbed organic matter (e.g., fats, proteins, carbohydrates) from the soil, which it used to add mass to its leaves, roots, and stem.", "The sunflower absorbed nutrients (e.g., nitrogen, potassium, phosphorus) from the soil, which it used to add mass to its leaves, roots, and stem."), choiceValues = c("None selected", "A", "B", "C", "D"), selected = "None selected", width = "50%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 1C", inputId = "Submit1C"))),
                    p(),
                    shinyjs::hidden(div(id = "Feedback1C",
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Plants absorb water from their roots and they use the water for a number of biological reasons, including staying upright, keeping cool, and as an input of photosynthesis.", 
                                "So, the big increase in mass that you can observe in the blue columns of figure 1B is from the sunflower absorbing water through its roots.")),
                        actionButton(label = "Move on to the next section", inputId = "Next1D")))
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "PlantDryMass", img(src='DryMassPlant.png', width = "120px"),
                        tags$figcaption("Measuring the dry mass of the sunflower at the end of Experiment 1."))),
                    p(),
                    shinyjs::hidden(checkboxGroupInput(inputId = "1D", label = "(D) What process(es) are responsible for the increase in the DRY mass of the sunflower from Day 1 to Day 10? Select ALL correct answers.", choiceNames = list("None selected", "The sunflower absorbed water from the soil through its roots. The water is now inside most tissues in the sunflower’s body.", "The sunflower produced glucose during photosynthesis, which it used to add mass to its leaves, roots, and stem.", "The sunflower absorbed organic matter (e.g., fats, proteins, carbohydrates) from the soil, which it used to add mass to its leaves, roots, and stem.", "The sunflower absorbed nutrients (e.g., nitrogen, potassium, phosphorus) from the soil, which it used to add mass to its leaves, roots, and stem."), choiceValues = c("None selected", "A", "B", "C", "D"), selected = "None selected", width = "50%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 1D", inputId = "Submit1D"))),
                    p(),
                    shinyjs::hidden(div(id = "Feedback1D", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Plants are completely dried in an oven before dry mass is measured.", 
                                "This means that the increase in dry mass from Day 1 to Day 10 (Figure 1B, red columns) is not because the plant absorbed water (the water does not become a part of the plant's tissues)."), 
                            p("However, green plants photosynthesize.", 
                                "During photosynthesis, plants produce food (glucose), which they use in cellular respiration or for growth and maintenance of body structures."), 
                            p("Plants do not eat food in the same way that animals or fungi do (by incorporating large organic molecules into their bodies)."),
                            p("Plants absorb nutrients like nitrogen and phosphorus from the soil.", 
                                "These nutrients are a part of proteins, DNA, and other molecules in the plant.", 
                                "These nutrients will account for a little bit of the mass increase by the plant.")),
                        actionButton(label = "Move on to the next section", inputId = "Next1E")))
                )
            ),
            fluidRow(  
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "MeasureSoil", img(src='MeasureSoil.png', width = "120px"))),
                    p(),
                    shinyjs::hidden(radioButtons(inputId = "1E", label = "(E) What do you predict the DRY MASS of the soil will be at the end of Experiment 1? Initially, there was 200 g of soil in the pot. Choose the best response.", choiceNames =  c("None selected", "Approximately 200 g", "Approximately 150 g", "Approximately 100 g", "Approximately 50 g", "Approximately 0 g"), choiceValues = c("None selected", "A", "B", "C", "D", "E"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 1E", inputId = "Submit1E"))),
                    p(),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "View data for soil mass", inputId = "Experiment1SoilData"))),
                    p(),
                    shinyjs::hidden(div(id = "Feedback1E", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("The mass of the soil will stay almost exactly the same over the 10 day period.", 
                                "It's true that plants need nutrients like nitrogen, potassium, phosphorus, and calcium.", 
                                "However, these nutrients do not make up a large percentage of mass in plants.", 
                                "While the sunflower plant did absorb some of these nutrients, they make up only a very small percentage of its mass.")),
                        actionButton(label = "Move on to the next section", inputId = "Next1F")))
                ),
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("SoilMass")
                )
            ),
            fluidRow(  
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(radioButtons(inputId = "1F", label = "(F) The dry mass of the sunflower increased by about 1 g in 10 days. However, the mass of the soil barely changed. Where did most of the 1 g of dry mass in the plant come from? Choose the best answer.", choiceNames = c("None selected", "Sunlight", "Organic matter in the soil", "Nutrients in the soil", "Gases in the air"), choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 1F", inputId = "Submit1F"))),
                    p(),
                    shinyjs::hidden(div(id = "Feedback1F", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Sunlight is energy, not matter.", 
                                "Matter and energy cannot be converted into one another in biological systems."), 
                            p("Plants do not eat food like animals or fungi, and therefore do not take in large organic molecules."),
                            p("Plants use nutrients in the soil, but these nutrients make up a small percentage of a plant’s mass."), 
                            p("Plants are made up mostly of carbon and oxygen, and they get these atoms from carbon dioxide in the air.", 
                                "During photosynthesis, plants combine carbon dioxide and water to form glucose (and oxygen as a byproduct) in a chemical reaction.", 
                                "The glucose is used by the plant as food, and some of this glucose is used by the plant to add to their body structures."), 
                            p(class="text-warning", "End of Experiment 1, please move on to Experiment 2 using the tabs at the top of the page."))))
                ),
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    shinyjs::hidden(div(id = "PlantMassDryOnlyPlot", plotOutput("PlantMassDryOnly")))
                )
            )
         )
    ),
    tabPanel("Experiment 2",
        fluidPage(
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:5px',
                    tags$h3("Experiment 2: whole-system perspective, sealed box"),
                    p(class="text-primary", "There are five questions in this section (2A-E)."),
                    p("Please complete Plant Basics 1 and 2 and Experiment 1 before beginning this section.")
                )
            ),
            fluidRow(
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "Experiment2IntroA",
                        p("The next day, you try a different experiment.", 
                        "The initial set-up of the experiment is the same as Experiment 1.",
                        "In the same sunny greenhouse, you measure out 200 g of dry soil in a small pot, and add 270 g of water to the pot.",
                        "You place a clear plastic cover over the soil to prevent the water from evaporating.",
                        "Again, you plant a small sunflower in the center of the pot.",
                        "Its initial mass is the same as the sunflower from Experiment 1 (wet mass = 0.45 g, dry mass = 0.05 g)."),
                        p("However, for Experiment 2, you place the sunflower (in the pot, with soil and water) inside a clear SEALED box.",
                        "No air can get in or out of this box, but sunlight can get in.",
                        "You measure the mass of the entire box (containing the sunflower, pot, soil, and water) over time.",
                        "At the beginning of the experiment, you weigh the box and all of its contents, and it weighs 1,500 g."),
                        p("Soil is made up of many different things, including small pieces of rocks, minerals, and dead organisms.",
                            "However, soil also contains living organisms, like fungi and bacteria.",
                            "The fungi and bacteria that live in soil would complicate our simple plant system, so we will ignore them for this assignment.",
                            "While natural soil contains a lot of organisms, the basic potting soil that you can buy at a garden store does not contain nearly as many.",
                            "So, this is a safe enough assumption for our purposes.")
                    ))
                ),
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "Experiment2IntroB",
                        img(src='BoxInitial.png', width = "300px"),
                        tags$figcaption("Placing a sunflower (with a pot, soil, and water) inside a clear, sealed box for Experiment 2.")))
                )
            ),
            fluidRow(
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(shinyjs::disabled(radioButtons(inputId = "2A", label = "(A) You leave the box and all of its contents on the scale for 12 hours, and you measure its mass once every hour. What do you predict will happen to the mass of the box and its contents during Experiment 2?", choiceNames = c("None selected", "Decrease", "Increase", "Stay the same"), choiceValues = c("None selected", "A", "B", "C"), width = "100%"))),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2A", inputId = "Submit2A"))),
                    p(),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Conduct Experiment 2", inputId = "Experiment2"))),
                    p(),
                    shinyjs::hidden(div(id = "Feedback2A", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("The mass of the box and its contents will not change, even though the plant itself will weigh a little more at the end of Experiment 2.")),
                        actionButton(label = "Move on to the next section", inputId = "NextGasIntro")))
                ),
                column(6, style='padding-left:0px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("ClosedBox")
                )
            ),
            fluidRow(
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(div(id = "Experiment2GasIntro", 
                    tags$h3("Gases in the air (inside the sealed box)"),
                    p(),
                    p("Even though the mass of the system as a whole (the box and its contents) doesn't change over time, the mass of the components that make up the system can change.",
                    "Using a probe that can detect gases in the air, you measure the mass of the gases inside the box before the experiment begins (shown in the figure to the right).",
                    "The most abundant gas molecules in the air are nitrogen gas (N2), oxygen gas (O2), argon gas (Ar, a single atom molecule), and carbon dioxide (CO2).",
                    "Notice that there is a lot more oxygen gas in the air than carbon dioxide, though both gases are important in biological systems."))),
                    p(),
                    shinyjs::hidden(div(id = "Experiment2GasIntroPlot", plotOutput("GasesBarChart", width = "70%")))
                )
            ),
            fluidRow(
                column(6,
                    shinyjs::hidden(radioButtons(inputId = "2B", label = "(B) What do you predict will happen to the mass of the carbon dioxide gas inside the box during Experiment 2?", choiceNames = c("None selected", "Decrease", "Increase", "Stay the same"), choiceValues = c("None selected", "A", "B", "C"), width = "100%"))
                ),
                column(6,
                    shinyjs::hidden(radioButtons(inputId = "2C", label = "(C) What do you predict will happen to the mass of the oxygen gas inside the box during Experiment 2?", choiceNames = c("None selected",  "Decrease", "Increase", "Stay the same"), choiceValues = c("None selected", "A", "B", "C"), width = "100%"))
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
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("CO2Mass")
                ),
                column(6, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    plotOutput("O2Mass")
                )
            ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "2D", label = "(D) Is cellular respiration occurring in the sunflower during Experiment 2? Select the best explanation.", choiceNames = c("None selected", "Yes, cellular respiration is happening in all living plant cells.", "No, cellular respiration can sometimes happen in plants, but it does not happen during Experiment 2.", "Yes, cellular respiration was happening in only the leaf cells of the sunflower.", "No, cellular respiration cannot happen in plants."), choiceValues = c("None selected", "A", "B", "C", "D"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2D", inputId = "Submit2D"))),
                    shinyjs::hidden(div(id = "Feedback2D", 
                        tags$ul(tags$strong("Answer explanation:"), 
                            p("Plants undergo cellular respiration in all living plant cells in order to carry out metabolic activities."), 
                            p("Cellular respiration occurs in living plants all of the time, during the day or at night.",
                                "The rate of cellular respiration may increase or decrease depending on sunlight, temperature, or other factors.",
                                "However, cellular respiration will not completely stop.")),
                        actionButton(label = "Move on to the next section", inputId = "Next2E")))
                    )
                ),
            fluidRow(  
                column(12, style='padding-left:5px; padding-right:1px; padding-top:5px; padding-bottom:15px',
                    shinyjs::hidden(radioButtons(inputId = "2E", 
                        label = "(E) When the sunflower undergoes cellular respiration during Experiment 2, it releases carbon dioxide gas. Why then is carbon dioxide DECREASING inside the sealed box during Experiment 2 (see Figure 2B)? Select the best explanation.", 
                        choiceNames = c("None selected", 
                            "The sunflower is taking in more carbon dioxide for photosynthesis than it is releasing for cellular respiration. Some of the glucose made during photosynthesis is being burned up by the plant and converted to energy.", 
                            "The sunflower is taking in more carbon dioxide for photosynthesis than it is releasing for cellular respiration. Some of the glucose made during photosynthesis is being added to the plant's tissues and is not used in cellular respiration.",
                            "The sunflower is taking in more carbon dioxide for digestion than it is releasing for cellular respiration. The carbon dioxide that is absorbed through its roots and is digested is then added to the plant's tissues."), choiceValues = c("None selected", "A", "B", "C"), width = "100%")),
                    shinyjs::hidden(shinyjs::disabled(actionButton(label = "Submit 2E", inputId = "Submit2E"))),
                    shinyjs::hidden(div(id = "Feedback2E", 
                            p("When sunlight is available, plants photosynthesizeP and make make glucose. Plants use glucose as a source of matter and energy (i.e., food)."),
                            p("However, matter cannot be destroyed and matter cannot be converted into energy in biological systems."),
                            p("Plenty of glucose produced during photosynthesis goes towards making plant tissues, and will not be used by the plant for cellular respiration.",
                            "If a plant is increasing in mass (i.e. growing), it MUST be using some of the glucose for growth (after all, the matter has to come from somewhere)."),
                            p("The rate of cellular respiration relative to photosynthesis will depend on various factors (the age of the plant, the plant species, temperature, precipitation, etc.), but on the whole, plants photosynthesize more than they respire."),
                        p(class="text-success", "End of the activity, all of your responses have been recorded.")))
                    )
                )
            )
        )
    )
)