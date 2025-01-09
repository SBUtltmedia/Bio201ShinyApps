let score = 1
let points = 0;
let qTotal = 0;
let grade = 0;
// /[\w\.]*@stonybrook.edu$/
addEventListener("DOMContentLoaded", (event) => {

let buttons = document.getElementsByTagName("button")
let buttonArray = Array.from(buttons);
let buttonNames = []
let answerCount = 0
for (button of buttonArray) {

buttonNames.push(button.id)


button.addEventListener("click", (e) => {

eventHandler(e);
document.getElementById(e.currentTarget.id).disabled = true;
})
}
console.log(buttonNames)


});

function markAnswers(targetID) {
    console.log(targetID);

    qTotal++;
  
    let questionID = targetID.split("Submit")[1];
    let cssMap = { true: "correct", false: "incorrect" }


    let answers = [...document.querySelectorAll(`[name="${questionID}"]`)]


    // let checkedAnswers = answers.filter(ans => ans.checked)
    // let uncheckedAnswers = answers.filter(ans => !ans.checked)
    let correctAnswers = rightAnswers[questionID]
    let wrongAnswers = 0

    for (eachCheck of answers) {
        eachCheck.disabled = true
        let css = cssMap[correctAnswers.includes(eachCheck.value)]
        eachCheck.nextElementSibling.classList.add(css)
    }
    let userChecked = answers.filter(ans => ans.checked).map((ans => ans.value))
    let returnValue = JSON.stringify(userChecked) == JSON.stringify(rightAnswers[questionID])
    console.log(returnValue + 0 )
    console.log(points + "points");
    console.log(score + "score");
    console.log(qTotal + ":Question Total");
    // grade = points/qTotal;
    // console.log("%" + grade * 100 + ":Current Grade")
    return returnValue;
}