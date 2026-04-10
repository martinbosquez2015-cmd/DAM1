let tasks = [];

//Esta función muestra todo para que se actualice cada vez que añadimos algo
function displayTask(){
    let html = "";
    for(let i=0; i<tasks.length; i++){
        html+= "<li>" + tasks[i] + "<button onclick='removeTask("+i+")'>x</button></li>";
    }
    document.getElementById("list").innerHTML = html;
}

//añadir una funcion
function addTask(){
    let taskInput = document.getElementById("task");
    let text = taskInput.value;
    if(text ===""){
        return;
    }
    tasks.push(text);
    taskInput.value = "";
    saveTasks();
    displayTask();
}


//remover alguna tarea
function removeTask(i){
    tasks.splice(i,1);
    saveTasks();
    displayTask();
}

function clearAll(){
    tasks = [];
    saveTasks();
    displayTask();
}

//guardar tareas
function saveTasks(){
    localStorage.setItem("tasks", JSON.stringify(tasks));
}

//cargar tareas
function loadTasks(){
    let saved = localStorage.getItem("tasks");
    if(saved!= null){
        tasks = JSON.parse(saved);
    }
}

loadTasks();
displayTask();