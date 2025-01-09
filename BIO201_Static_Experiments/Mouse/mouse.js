let rightAnswers = {
    "1A": ["A"],
    "1B": ["A"],
    "1C": ["B"],
    "1D": ["D"],
    "1E": ["B", "D"],
    "1F": ["C"],
    "2A": ["C"],
    "2B": ["B"],
    "2C": ["A"],
    "2D": ["C"],
    "2E": ["B"],
    "2F": ["C"],
    "3A": ["A"],
    "3B": ["C"]
}

function eventHandler(e) {
    switch (e.currentTarget.id) {
        // case "NameButton":
        // console.log(document.getElementById("NameButton").nextSibling);
        //   document.getElementById("1A").classList.remove("shinyjs-hide");
        //   document.getElementById("Intro1A").classList.remove("shinyjs-hide");
        //   document.getElementById("Submit1A").classList.remove("shinyjs-hide");
        //   break;
        case "Submit1ABC":

            points += markAnswers("Submit1A")
            points += markAnswers("Submit1B")
            points += markAnswers("Submit1C")
            // Show question 1D and its submit button
            document.getElementById("1D").classList.remove("shinyjs-hide");
            document.getElementById("Submit1D").classList.remove("shinyjs-hide");
            break;

        case "Submit1D":

            points += markAnswers(e.currentTarget.id)
            // Show feedback for 1D, plus next question 1E and its button
            document.getElementById("Feedback1D").classList.remove("shinyjs-hide");
            document.getElementById("Introduction1EF").classList.remove("shinyjs-hide");
            document.getElementById("MassBreakdown").classList.remove("shinyjs-hide");
            document.getElementById("1E").classList.remove("shinyjs-hide");
            document.getElementById("Submit1E").classList.remove("shinyjs-hide");
            break;

        case "Submit1E":
            points += markAnswers(e.currentTarget.id)
            // Show feedback for 1E, plus next question 1F and its button
            document.getElementById("Feedback1E").classList.remove("shinyjs-hide");
            document.getElementById("1F").classList.remove("shinyjs-hide");
            document.getElementById("Submit1F").classList.remove("shinyjs-hide");
            break;

        case "Submit1F":
            points += markAnswers(e.currentTarget.id)
            // Show feedback for 1F
            document.getElementById("Feedback1F").classList.remove("shinyjs-hide");
            break;

        case "GoToExperiment2":
            document.getElementById("P2").classList.remove("shinyjs-hide");
            document.querySelector("[data-value='Experiment 2']").click()
            window.scrollTo({ top: 0, behavior: 'smooth' });
            break;


        // ---------------------------
        // EXPERIMENT 2
        // ---------------------------

        case "Submit2A":
            points += markAnswers(e.currentTarget.id)
            // Show the explanation for 2A (if you have it) plus next chunk: 2B, 2C, and submit
            // document.getElementById("Feedback2A").classList.remove("shinyjs-hide"); // Only if you have a line for Feedback2A
            document.getElementById("Experiment2GasIntro").classList.remove("shinyjs-hide");
            document.getElementById("2B").classList.remove("shinyjs-hide");
            document.getElementById("2C").classList.remove("shinyjs-hide");
            document.getElementById("Submit2BC").classList.remove("shinyjs-hide");
            document.getElementById("ClosedCage").classList.remove("shinyjs-hide");
            break;

        case "Submit2BC":
            points += markAnswers("Submit2B")
            points += markAnswers("Submit2C")
            // Reveal question 2D and its button
            document.getElementById("2D").classList.remove("shinyjs-hide");
            document.getElementById("Submit2D").classList.remove("shinyjs-hide");
            break;

        case "Submit2D":
            points += markAnswers(e.currentTarget.id)
            // Show feedback for 2D, plus next question 2E and its button
            document.getElementById("Feedback2D").classList.remove("shinyjs-hide");
            document.getElementById("2E").classList.remove("shinyjs-hide");
            document.getElementById("Submit2E").classList.remove("shinyjs-hide");
            break;

        case "Submit2E":
            points += markAnswers(e.currentTarget.id)
            // Show feedback for 2E, plus next question 2F and its button
            document.getElementById("Feedback2E").classList.remove("shinyjs-hide");
            document.getElementById("2F").classList.remove("shinyjs-hide");
            document.getElementById("Submit2F").classList.remove("shinyjs-hide");
            break;

        case "Submit2F":
            points += markAnswers(e.currentTarget.id)
            // Show feedback for 2F
            document.getElementById("Feedback2F").classList.remove("shinyjs-hide");
            break;

        case "GoToExperiment3":
            document.getElementById("P3").classList.remove("shinyjs-hide");
            document.querySelector("[data-value='Experiment 3']").click()
            window.scrollTo({ top: 0, behavior: 'smooth' });
            break;


        // ---------------------------
        // EXPERIMENT 3
        // ---------------------------

        case "Submit3A":
            points += markAnswers(e.currentTarget.id)
            // Show question 3B and its button
            document.getElementById("3B").classList.remove("shinyjs-hide");
            document.getElementById("Submit3B").classList.remove("shinyjs-hide");
            document.getElementById("OpenCage").classList.remove("shinyjs-hide");
            break;

        case "Submit3B":
            points += markAnswers(e.currentTarget.id);
            // Show feedback for 3B
            document.getElementById("Feedback3B").classList.remove("shinyjs-hide");
            grade = points / qTotal;
            console.log(grade * 100 + "%:grade");
            alert(grade * 100 + "%:Final Grade");
            break;

    }

}
