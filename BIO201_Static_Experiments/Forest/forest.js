let rightAnswers = {
    "1A": ["A", "E"],
    "1B": ["C"],
    "2A": ["B", "C"],
    "2B": ["A"],
    "2C": ["A", "B"],
    "2D": ["D"],
    "3A": ["C"],
    "3B": ["E"],
    "3C": ["A"],
    "4A": ["D"],
    "4B": ["A"],
    "4C": ["B", "D"],
    "4D": ["A", "B", "C"]
}

function eventHandler(e) {
    switch (e.currentTarget.id) {
        // case "NameButton":
        // console.log(document.getElementById("NameButton").nextSibling);
        //   document.getElementById("1A").classList.remove("shinyjs-hide");
        //   document.getElementById("Intro1A").classList.remove("shinyjs-hide");
        //   document.getElementById("Submit1A").classList.remove("shinyjs-hide");
        //   break;
        case "Submit1A":
            points += markAnswers(e.currentTarget.id);
            console.log(document.getElementById("Submit1A").nextSibling);
            document.getElementById("Feedback1A").classList.remove("shinyjs-hide");
            document.getElementById("Intro1B").classList.remove("shinyjs-hide");
            break;

        case "Submit1B":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback1B").classList.remove("shinyjs-hide");
            document.getElementById("2A").classList.remove("shinyjs-hide");
            document.getElementById("Submit2A").classList.remove("shinyjs-hide");
            document.getElementById("IntroPart2").classList.remove("shinyjs-hide");
            // setTimeout(()=>{

            // },1000);
            break;
        case "GoToPart2":
            document.getElementById("P2").classList.remove("shinyjs-hide");
            document.querySelector("[data-value='Part 2']").click()
            window.scrollTo({ top: 0, behavior: 'smooth' });
            break;

        case "Submit2A":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback2A").classList.remove("shinyjs-hide");
            document.getElementById("2B").classList.remove("shinyjs-hide");
            document.getElementById("Submit2B").classList.remove("shinyjs-hide");
            break;

        case "Submit2B":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback2B").classList.remove("shinyjs-hide");
            document.getElementById("Intro2C").classList.remove("shinyjs-hide");
            document.getElementById("2C").classList.remove("shinyjs-hide");
            document.getElementById("Submit2C").classList.remove("shinyjs-hide");
            console.log("Submit2B");
            break;

        case "Submit2C":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback2C").classList.remove("shinyjs-hide");
            document.getElementById("Intro2D").classList.remove("shinyjs-hide");
            document.getElementById("2D").classList.remove("shinyjs-hide");
            document.getElementById("Submit2D").classList.remove("shinyjs-hide");
            console.log("Submit2C");
            break;

        case "Submit2D":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback2D").classList.remove("shinyjs-hide");
            document.getElementById("IntroPart3").classList.remove("shinyjs-hide");
            document.getElementById("3A").classList.remove("shinyjs-hide");
            document.getElementById("Submit3A").classList.remove("shinyjs-hide");
            console.log("Submit2D");
            break;

        case "GoToPart3":
            document.getElementById("P3").classList.remove("shinyjs-hide");
            document.querySelector("[data-value='Part 3']").click()
            window.scrollTo({ top: 0, behavior: 'smooth' });
            break;

        case "Submit3A":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback3A").classList.remove("shinyjs-hide");
            document.getElementById("3B").classList.remove("shinyjs-hide");
            document.getElementById("Submit3B").classList.remove("shinyjs-hide");
            console.log("Submit3A");
            break;

        case "Submit3B":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback3B").classList.remove("shinyjs-hide");
            document.getElementById("3C").classList.remove("shinyjs-hide");
            document.getElementById("Submit3C").classList.remove("shinyjs-hide");
            console.log("Submit3B");
            break;

        case "Submit3C":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback3C").classList.remove("shinyjs-hide");
            document.getElementById("IntroPart4").classList.remove("shinyjs-hide");
            document.getElementById("CellularRespirationPlotShow").classList.remove("shinyjs-hide");
            document.getElementById("4A").classList.remove("shinyjs-hide");
            document.getElementById("Submit4A").classList.remove("shinyjs-hide");
            break;

        case "GoToPart4":
            document.getElementById("P4").classList.remove("shinyjs-hide");
            document.querySelector("[data-value='Part 4']").click()
            window.scrollTo({ top: 0, behavior: 'smooth' });
            break;

        case "Submit4A":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback4A").classList.remove("shinyjs-hide");
            document.getElementById("4B").classList.remove("shinyjs-hide");
            document.getElementById("Submit4B").classList.remove("shinyjs-hide");
            console.log("Submit4A");
            break;

        case "Submit4B":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback4B").classList.remove("shinyjs-hide");
            document.getElementById("4C").classList.remove("shinyjs-hide");
            document.getElementById("Submit4C").classList.remove("shinyjs-hide");
            console.log("Submit4B");
            break;

        case "Submit4C":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback4C").classList.remove("shinyjs-hide");
            document.getElementById("Intro4D").classList.remove("shinyjs-hide");
            document.getElementById("ComparePhotoRespPlotShow").classList.remove("shinyjs-hide");
            document.getElementById("4D").classList.remove("shinyjs-hide");
            document.getElementById("Submit4D").classList.remove("shinyjs-hide");
            console.log("Submit4C");
            break;

        case "Submit4D":
            points += markAnswers(e.currentTarget.id);
            document.getElementById("Feedback4D").classList.remove("shinyjs-hide");
            grade = points / qTotal;
            console.log(grade * 100 + "%:grade");
            alert(grade * 100 + "%:Final Grade");
            break;
    }
}