const jsdom = require("jsdom");
const { JSDOM } = jsdom;
var fs = require('fs');


var data = fs.readFileSync(process.argv[2], 'utf-8');
const dom = new JSDOM(data)
nextButtons=Array.from(dom.window.document.getElementsByTagName("button"))
for (button of nextButtons){

if(button.id.includes("Next")||button.id.includes("Experiment")||button.id.includes("Button")){button.remove()
}
}
console.log(dom.serialize())