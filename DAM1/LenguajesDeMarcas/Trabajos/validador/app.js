function validar(){

    let nombre = document.getElementById("nombre").value.trim();
    let direccion = document.getElementById("direccion").value.trim();
    let edad = parseInt(document.getElementById("edad").value);
    let estudios = document.getElementById("estudios").value;
    let acepto = document.getElementById("acepto").checked;

    let pass1 = document.getElementById("pass1").value;
    let pass2 = document.getElementById("pass2").value;

    let error = document.getElementById("error");

 
    error.style.display = "none";


    if(nombre === "" || direccion === "" || isNaN(edad) || estudios === ""){
        error.style.display = "block";
        return false;
    }

 
    if(edad < 18){
        error.style.display = "block";
        return false;
    }


    if(nombre.length < 2){
        error.style.display = "block";
        return false;
    }

  
    if(direccion.length < 10){
        error.style.display = "block";
        return false;
    }

  
    if(!acepto){
        error.style.display = "block";
        return false;
    }

 
    if(pass1.length < 8){
        error.style.display = "block";
        return false;
    }


    if(pass1 !== pass2){
        error.style.display = "block";
        return false;
    }

    return true;}