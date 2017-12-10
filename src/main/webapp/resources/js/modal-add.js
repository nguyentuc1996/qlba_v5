var modal_add = document.getElementById('qlba-modal');
var btn_add = document.getElementById('btn-modal-add');


var span = document.getElementById("close-add");

btn_add.onclick = function() {
    modal_add.style.display = "block";
    }



// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal_add.style.display = "none";
}
window.onclick = function(event){
    if (event.target == modal_add){
        modal_add.style.display = "none";
    }
}