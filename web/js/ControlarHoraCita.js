var selecthora,selectmin,fechaSel,today;
function validacion() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();
    if(dd<10){
        dd='0'+dd;
    } 
    if(mm<10){
        mm='0'+mm;
    } 

    today = yyyy+'-'+mm+'-'+dd;

    selecthora = document.getElementById("selecthora");
    selectmin = document.getElementById("selectmin");
    fechaSel = document.getElementById("fecha");
    
    if(selecthora.value==10 && selectmin.value != 00){
        selectmin.setCustomValidity('Selecciona min');
        selectmin.style.background = '#FFDDDD';
        alert("Imposible pedir cita después de las 10:00");
    }else if(fechaSel.value==today && selecthora.value < h){ //Hora del día ya pasada
        selecthora.setCustomValidity('Selecciona hora');
        selecthora.style.background = '#FFDDDD';
        alert("Horario no disponible");

    }else if(fechaSel.value==today && selecthora.value == h && selectmin.value<m){ //En la hora pero min pasados
        selecthora.setCustomValidity('Selecciona hora');
        selecthora.style.background = '#FFDDDD';
        alert("Horario no disponible");
    }else{
        selecthora.setCustomValidity('');
        selecthora.style.background = '#FFFFFF';

        if (confirm("¿Deseas confirmar la cita?") == true) {
            document.getElementById("pedirCita").submit();
        } else { 
        }
    }
    }
    
    function noFindes(){
        fechaSel = document.getElementById("fecha");
        var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        var d = new Date(fechaSel.value);
        var dayName = days[d.getDay()];
        if(dayName==='Saturday' || dayName==='Sunday'){
            alert("Imposible pedir cita durante fin de semana.");
        }else{
            validacion();
        }
    }


