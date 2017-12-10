var modal_update = document.getElementById('qlba_modal_update');
var btn_update = document.getElementById('btn-modal-update');
console.log(btn_update);
var span = document.getElementById("close-update");

btn_update.onclick = function() {
//    alert("a");
    modal_update.style.display = "block";
    
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal_update.style.display = "none";
}
window.onclick = function(event){
    if (event.target == modal_update){
        modal_update.style.display = "none";
    }
}