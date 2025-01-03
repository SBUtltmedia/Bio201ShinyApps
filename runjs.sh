node stripNextButton.js "$1">"$2"
node stripNoneSelected.js "$2">"${2}a"
mv "${2}a" "$2"