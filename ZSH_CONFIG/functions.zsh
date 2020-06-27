# use delta as diff
function dt() {
    diff -u $@ | delta --theme="Dracula"
}
