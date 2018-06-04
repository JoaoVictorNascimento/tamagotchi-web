var petType = ''
var special = false
var price = 0

function sound_button() {
    let sound = document.getElementById("sound_button")
    sound.play()
}

function select(img) {
    sound_button()
    sound_button();
    special = false;
    if (petType == '') {
        petType = img.id
        $("#" + petType).addClass('selected_pet')
    } else {
        $("#" + petType).removeClass('selected_pet')
        petType = img.id
        $("#" + petType).addClass('selected_pet')
    }
}

function createPet() {
function selectSpecial(img) {
    sound_button()
    special = true;
    if (petType == '') {
        petType = img.id
        $("#" + petType).addClass('selected_pet')
    } else {
        $("#" + petType).removeClass('selected_pet')
        petType = img.id
        $("#" + petType).addClass('selected_pet')
    }
}

function newPet() {
    name = $("#nome").val()    
    if (name != '' && petType != '') {
        axios.post('api/pet', {
            petType: petType,
            name: name
        }).then(function (res) {
            data = res.data
            localStorage.setItem('petId', data.id)
            alert("Pet criado!")
            window.location.href = "/tamagotchi";
        })
    } else {
        alert("Preencha podos os campos")
    }
}

function createPet() {
    sound_button()
    name = $("#nome").val()
    if (name == '' || petType == '') {
        alert("Preencha podos os campos")
        return;
    }
    if (special) {
        price = Number($("#"+petType+"-price").text())
        axios.put('api/pay', {
            cash: price
        }).then(function (res) {
            newPet();
        }).catch(function (err) {
            alert("Dinheiro insuficiente!")
            return;
        })
    } else {
        newPet();
    }
}



$(document).ready(function () {
    petId = localStorage.getItem('petId')
    console.log(petId)
    if (!petId) {
        $('#exit').hide()
    }
});