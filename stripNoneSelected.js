const jsdom = require("jsdom");
const { JSDOM } = jsdom;
var fs = require('fs');


var data = fs.readFileSync(process.argv[2], 'utf-8');
const dom = new JSDOM(data)
questions=Array.from(dom.window.document.getElementsByClassName('shiny-options-group'))
for (question of questions){

let firstQ= question.getElementsByClassName("checkbox")[0] || question.getElementsByClassName("radio")[0]
if(firstQ){question.removeChild(firstQ)
}
}
console.log(dom.serialize())