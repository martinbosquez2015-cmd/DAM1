const form = document.getElementById("signupForm")
const result = document.getElementById("result")
const nameinput = document.getElementById("name")
const nameError = document.getElementById("nameError")
const email = document.getElementById("email")
const emailError = document.getElementById("emailError")

form.addEventListener("submit", 
    function (event){
        event.preventDefault()

        if(validateForm()){
            result.innerHTML = "Form is valid";
            result.className = "ok";
        }else{
            result.innerHTML = "Please fix the errors";
            result.className = "error";
        }
    }

)

function validateForm() {
    let okName = validateName();
    return okName;
}

function validateName() {
    let value = "";
    value = nameinput.value.trim();
    if(value.length<2){
        showError(nameError, "Name must be at least 2 characters long");
        return false;
    }
    clearError();
    return true;
}

function validateEmail() {
    let value = "";
    value =  emailInput.value.trim();
    if(!/^\s    )
}