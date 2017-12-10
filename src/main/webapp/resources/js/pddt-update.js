pddt = document.getElementsByClassName("pddt");
    for (var i=0; i<pddt.length;i++){
        pddt[i].style.display = "none";
    }
function openTask(event, task){
    pddt = document.getElementsByClassName("pddt");
    for (var i=0; i<pddt.length;i++){
        pddt[i].style.display = "none";
    }
    document.getElementById(task).style.display = "block";
}