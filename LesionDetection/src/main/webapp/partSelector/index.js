window.onload = function () {
    const pieces = document.getElementsByTagName('svg');
    for (var i = 0; pieces.length; i++) {
        let _piece = pieces[i];
        _piece.onclick = function (t) {
            _piece.style.fill = "orange";
            if (t.target.getAttribute('data-position') !== null) {
                document.getElementById('data').innerHTML = t.target.getAttribute('data-position');
                document.getElementById('bodyPart').value = t.target.getAttribute('data-position');
            }
            if (t.target.parentElement.getAttribute('data-position') !== null) {
                document.getElementById('data').innerHTML = t.target.parentElement.getAttribute('data-position');
                document.getElementById('bodyPart').value = t.target.parentElement.getAttribute('data-position');
            }
            submitPart();
        }
    }
}