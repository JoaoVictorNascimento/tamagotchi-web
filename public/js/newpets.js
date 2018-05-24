petType = ''

function select(img) {
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

$(document).ready(function () {
    petId = localStorage.getItem('petId')
    console.log(petId)
    if (!petId){
        $('#exit').hide()
    }
});