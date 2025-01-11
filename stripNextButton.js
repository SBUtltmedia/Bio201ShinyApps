const jsdom = require("jsdom");
const { JSDOM } = jsdom;
var fs = require('fs');


var data = fs.readFileSync(process.argv[2], 'utf-8');
const dom = new JSDOM(data)
let nextButtons=Array.from(dom.window.document.getElementsByTagName("button"))
let formChecks=[...Array.from(dom.window.document.querySelectorAll("[type='radio'")),...Array.from(dom.window.document.querySelectorAll("[type='checkbox'"))]
let domItems=[...nextButtons,...formChecks]
for (button of domItems){
    button.classList.remove("shinyjs-disabled")
    button.classList.remove("disabled")
    button.disabled= false
if(button.id.includes("Next")||button.id.includes("Experiment")||button.id.includes("Button")){button.remove()}
}
console.log(dom.serialize())