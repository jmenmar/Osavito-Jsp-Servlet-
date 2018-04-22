function guardarSesion(){
    sessionStorage.clear();
    tisCapturada = document.getElementById("tislogin").value;
    fechaCapturada = document.getElementById("fecha").value;
    
    sessionStorage.setItem(tisCapturada,fechaCapturada);
}

function logout(){
    if (confirm("¿Estás seguro?") == true) {
         sessionStorage.clear();
        window.location = "loginPaciente.html";
     } else {
        
     }
}

function mostrarDatosUsuario(){
    var numeroTIS = document.getElementById('numeroT');
    numeroTIS.innerHTML = '';
    for (var f = 0; f < sessionStorage.length; f++) {
        var clave = sessionStorage.key(f);
        var valor = sessionStorage.getItem(clave);
        numeroTIS.innerHTML += clave;  
    }
}
