let rightAnswers = {
    "PB1A": ["A","B","C","D"], 
    "PB1B": ["A","C"],         
    "PB1C": ["A","B","C"],     
    "PB2A": ["C"],             
    "PB2B": ["C"],             
    "PB2C": ["A"],             
    "PB2D": ["A","B","C"],    
    "1A":  ["B","C","D"],      
    "1B":  ["B"],
    "1C":  ["A"],
    "1D":  ["B","D"],
    "1E":  ["A"],
    "1F":  ["D"],
    "2A":  ["C"],
    "2B":  ["A"],
    "2C":  ["B"],
    "2D":  ["A"],
    "2E":  ["B"]
  };
  function eventHandler(e) {
    switch (e.currentTarget.id) {

        // ======================================
        // PLANT BASICS 1
        // ======================================
        case "SubmitPB1A":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("FeedbackPB1A").classList.remove("shinyjs-hide");
            document.getElementById("WetDryMass").classList.remove("shinyjs-hide");
            document.getElementById("AtomConcentration").classList.remove("shinyjs-hide");
            document.getElementById("Graph1").classList.remove("shinyjs-hide");
            document.getElementById("PB1B").classList.remove("shinyjs-hide");
            document.getElementById("SubmitPB1B").classList.remove("shinyjs-hide");
            break;

        case "SubmitPB1B":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("FeedbackPB1B").classList.remove("shinyjs-hide");
            document.getElementById("Cellulose").classList.remove("shinyjs-hide");
            document.getElementById("Graph2").classList.remove("shinyjs-hide");
            document.getElementById("PB1C").classList.remove("shinyjs-hide");
            document.getElementById("SubmitPB1C").classList.remove("shinyjs-hide");

            // Show next content: PlantMass, AtomMassesPlot, etc.
            break;

        case "SubmitPB1C":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("FeedbackPB1C").classList.remove("shinyjs-hide");
            document.getElementById("PlantMass").classList.remove("shinyjs-hide");
            document.getElementById("Graph3").classList.remove("shinyjs-hide");
            document.getElementById("AtomMassesCaption").classList.remove("shinyjs-hide");
            document.getElementById("PB2A").classList.remove("shinyjs-hide");
            document.getElementById("SubmitPB2A").classList.remove("shinyjs-hide");
            // Reveal PB2A next
            break;

        case "GoToPlantBasics2":

                document.getElementById("P2").classList.remove("shinyjs-hide");
                document.querySelector("[data-value='Plant Basics 2']").click()
                window.scrollTo({ top: 0, behavior: 'smooth' });
                break;
            break;


        // ======================================
        // PLANT BASICS 2
        // ======================================
        case "SubmitPB2A":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("FeedbackPB2A").classList.remove("shinyjs-hide");
            document.getElementById("GasCanistersIntro").classList.remove("shinyjs-hide");
            document.getElementById("PB2B").classList.remove("shinyjs-hide");
            document.getElementById("SubmitPB2B").classList.remove("shinyjs-hide");


            // Show GasCanistersIntro, PB2B, etc.
            break;

        case "SubmitPB2B":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("FeedbackPB2B").classList.remove("shinyjs-hide");
            document.getElementById("MoleculeMasses").classList.remove("shinyjs-hide");
            document.getElementById("Graph4").classList.remove("shinyjs-hide");
            document.getElementById("PB2C").classList.remove("shinyjs-hide");
            document.getElementById("SubmitPB2C").classList.remove("shinyjs-hide");
            // Show MoleculeMasses, PB2C, etc.
            break;

        case "SubmitPB2C":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("FeedbackPB2C").classList.remove("shinyjs-hide");
            document.getElementById("CelluloseMasses").classList.remove("shinyjs-hide");
            document.getElementById("CelluloseMassesCaption").classList.remove("shinyjs-hide");
            document.getElementById("Graph5").classList.remove("shinyjs-hide");
            document.getElementById("Photosynthesis").classList.remove("shinyjs-hide");
            document.getElementById("Respiration").classList.remove("shinyjs-hide");
            document.getElementById("PB2D").classList.remove("shinyjs-hide");
            document.getElementById("SubmitPB2D").classList.remove("shinyjs-hide");
            
            // Show CelluloseMasses, Photosynthesis, Respiration, etc.
            break;

        case "SubmitPB2D":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("FeedbackPB2D").classList.remove("shinyjs-hide");
            document.getElementById("Growth").classList.remove("shinyjs-hide");
            document.getElementById("Experiment1Intro").classList.remove("shinyjs-hide");
            document.getElementById("1A").classList.remove("shinyjs-hide");
            document.getElementById("Submit1A").classList.remove("shinyjs-hide");
            // Show feedback PB2D, Growth, etc.
            break;

            case "GoToExperiment1":
                document.getElementById("P3").classList.remove("shinyjs-hide");
                document.querySelector("[data-value='Experiment 1']").click()
                window.scrollTo({ top: 0, behavior: 'smooth' });
                break;


        // ======================================
        // EXPERIMENT 1
        // ======================================
        case "Submit1A":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback1A").classList.remove("shinyjs-hide");
            document.getElementById("PlantInitialFinal").classList.remove("shinyjs-hide");
            document.getElementById("1B").classList.remove("shinyjs-hide");
            document.getElementById("Submit1B").classList.remove("shinyjs-hide");
            // Reveal next question 1B
            break;

        case "Submit1B":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback1B").classList.remove("shinyjs-hide");
            document.getElementById("Graph6").classList.remove("shinyjs-hide");
            document.getElementById("PlantWetMass").classList.remove("shinyjs-hide");
            document.getElementById("1C").classList.remove("shinyjs-hide");
            document.getElementById("Submit1C").classList.remove("shinyjs-hide");
            // Reveal question 1C
            break;

        case "Submit1C":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback1C").classList.remove("shinyjs-hide");
            document.getElementById("PlantDryMass").classList.remove("shinyjs-hide");
            document.getElementById("1D").classList.remove("shinyjs-hide");
            document.getElementById("Submit1D").classList.remove("shinyjs-hide");
            // Reveal question 1D
            break;

        case "Submit1D":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback1D").classList.remove("shinyjs-hide");
            document.getElementById("MeasureSoil").classList.remove("shinyjs-hide");
            document.getElementById("1E").classList.remove("shinyjs-hide");
            document.getElementById("Submit1E").classList.remove("shinyjs-hide");
            // Reveal question 1E
            break;

        case "Submit1E":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback1E").classList.remove("shinyjs-hide");
            document.getElementById("Graph7").classList.remove("shinyjs-hide");
            document.getElementById("1F").classList.remove("shinyjs-hide");
            document.getElementById("Submit1F").classList.remove("shinyjs-hide");
            // Reveal question 1F
            break;

        case "Submit1F":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback1F").classList.remove("shinyjs-hide");
            document.getElementById("PlantMassDryOnlyPlot").classList.remove("shinyjs-hide");
            document.getElementById("Graph8").classList.remove("shinyjs-hide");
            document.getElementById("Experiment2IntroA").classList.remove("shinyjs-hide");
            document.getElementById("Experiment2IntroB").classList.remove("shinyjs-hide");
            document.getElementById("2A").classList.remove("shinyjs-hide");
            document.getElementById("Submit2A").classList.remove("shinyjs-hide");
            // Possibly show a button for Experiment 2 or final feedback
            break;

            case "GoToExperiment2":
                document.getElementById("P4").classList.remove("shinyjs-hide");
                document.querySelector("[data-value='Experiment 2']").click()
                window.scrollTo({ top: 0, behavior: 'smooth' });
                break;


        // ======================================
        // EXPERIMENT 2
        // ======================================
        case "Submit2A":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback2A").classList.remove("shinyjs-hide");
            document.getElementById("Graph9").classList.remove("shinyjs-hide");
            document.getElementById("Experiment2GasIntro").classList.remove("shinyjs-hide");
            document.getElementById("Experiment2GasIntroPlot").classList.remove("shinyjs-hide");
            document.getElementById("Graph10").classList.remove("shinyjs-hide");
            document.getElementById("2B").classList.remove("shinyjs-hide");
            document.getElementById("2C").classList.remove("shinyjs-hide");
            document.getElementById("Submit2BC").classList.remove("shinyjs-hide");
            // Show Experiment2GasIntro, 2B, 2C, etc.
            break;

        case "Submit2BC":
            points += markAnswers("Submit2B");
            points += markAnswers("Submit2C");
            document.getElementById("Graph11a").classList.remove("shinyjs-hide");
            document.getElementById("Graph11b").classList.remove("shinyjs-hide");
            document.getElementById("2D").classList.remove("shinyjs-hide");
            document.getElementById("Submit2D").classList.remove("shinyjs-hide");
            // Reveal 2D
            break;

        case "Submit2D":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback2D").classList.remove("shinyjs-hide");
            document.getElementById("2E").classList.remove("shinyjs-hide");
            document.getElementById("Submit2E").classList.remove("shinyjs-hide");
            // Reveal 2E
            break;

        case "Submit2E":
  

            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback2E").classList.remove("shinyjs-hide");
            grade = Math.floor((points / qTotal)*10**precison)/10**precison;
            console.log(grade * 100 + "%:grade");
            alert(grade * 100 + "%:Final Grade");
            ses.grade = grade;
            postLTI(ses,"");
            break;

        default:
            break;
    }
}