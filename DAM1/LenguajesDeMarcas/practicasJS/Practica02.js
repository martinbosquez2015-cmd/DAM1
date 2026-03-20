let eleccion = prompt("Dime que eleccion quieres sobre el Cofla\n(1,2 o 3): ")
if (eleccion =="1"){
    document.writeln(`<div class= "el"><h2>Has elegido Helados</h2></div>`)
    helados()
}
else if (eleccion =="2"){
    document.writeln(`<div class= "el"><h2>Has elegido Vagabundo</h2></div>`)
    helados()
}
else if (eleccion =="3"){
    document.writeln(`<div class= "el"><h2>Has elegido Asesinos</h2></div>`)
    helados()
}
else{
    alert("Lo siento, no contemplo esa opción...")
}
    

function helados(){
    const helaos = new Map([
        ["Helao e agua",0.6],
        ["Helao e crema", 1],
        ["heladix",1.6],
        ["heladovich",1.7],
        ["helardo",1.8],
        ["Helao con confites",2.9],
        ["Pote de 1/4",2.9]]);
    let nombre = prompt("Quien comprará helaos?");
    let presio = parseFloat(prompt("Cuanto tiene?"));
    if(){
        
    }
    let temp = 0;
    let kTemp = "";
    helaos.forEach(function(value, key) {
        if(value<presio && temp<value){
            temp = value;
            kTemp = key;
        }
    })
    if(temp ==0){
        alert(`No mames, el ${nombre} está bien pinche pobre a la verga!`)
        alert("JAJAJAJAJAJAJA")
        alert("JAJAJAJAJAJAJA")
        alert("JAJAJAJAJAJAJA")
        alert("JAJAJAJAJAJAJA")
        alert("JAJAJAJAJAJAJA")
    }
    else{
    alert(`A ${nombre} le alcanza hasta el ${kTemp} con un precio de ${temp} porque tiene ${presio}`)
    }
} 