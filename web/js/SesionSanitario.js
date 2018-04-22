function guardarSesion(){
    sessionStorage.clear();
    numCol = document.getElementById("numcolegiado").value;
    
    sessionStorage.setItem(numCol,"Sanitario");
}

function logout(){
    if (confirm("¿Estás seguro?") == true) {
        sessionStorage.clear();
        window.location = "loginSanitario.html";
     } else {}
}

function mostrarDatosSanitario(){
    var numCol = document.getElementById('numeroCol');
    numCol.innerHTML = '';
    for (var f = 0; f < sessionStorage.length; f++) {
        var clave = sessionStorage.key(f);
        var valor = sessionStorage.getItem(clave);
        numCol.innerHTML += clave;  
    }
}
    