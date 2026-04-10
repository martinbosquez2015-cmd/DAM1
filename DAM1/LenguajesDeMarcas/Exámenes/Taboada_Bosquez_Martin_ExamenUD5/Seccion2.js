let guests = [];

function displayGuests(){
    let html = "";
    for(let i=0; i<guests.length; i++){
        html+= "<li>" + guests[i] + "<button onclick='removeGuest("+i+")'>eliminar</button></li>";
    }
    document.getElementById("guest-list").innerHTML = html;
}


function addGuest(){
    let guestInput = document.getElementById("guest-name");
    let text = guestInput.value;
    let errorsito = document.getElementById("error-msg");
    if(text ===""){
        return;
    }
    else if (text.length<3){
        let cadena = `Error: no se puede añadir "${text}" a la lista.`
        errorsito.innerText = (cadena)
    }
    else{
    guests.push(text);
    guestInput.value = "";
    saveGuests();
    displayGuests();
    errorsito.innerText = ""
    }
}


function removeGuest(i){
    guests.splice(i,1);
    saveGuests();
    displayGuests();
}

function clearAll(){
    guests = [];
    saveGuests();
    displayGuests();
}


function saveGuests(){
    localStorage.setItem("guests", JSON.stringify(guests));
}


function loadGuests(){
    let saved = localStorage.getItem("guests");
    if(saved!= null){
        guests = JSON.parse(saved);
    }
}

loadGuests();
displayGuests();