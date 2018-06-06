$(document).ready(function () {
    getPets()
});

function getPets() {
    axios.get('api/userpets').then(function (res) {
        data = res.data
        if (data.length > 0) {
            localStorage.setItem('petId', data[0]._id.$oid)
        }
        data.filter(petDead).forEach(pet => {
            console.log(pet)
            $('#pets ul').append(
                '<li class="my-list-group-item">' +
                '<button type="button" class="close-btn" name=' + pet._id.$oid + ' onClick="death(this)">' + 'x' + '</button>' +
                '<div class="my-row"  id=' + pet._id.$oid + ' onClick="choosePet(this)">' +
                '<div class="my-col infopet-gif">' +
                '<img src="images/' + pet.petType + pet.stage + '.gif" class="gif_pet1">' +
                '</div>' +
                '<div class="my-col infopet">' +
                '<a>' + pet.name + '</a>' +
                '</br>' +
                '<a>' + pet.state + '</a>' +
                '</div>' +
                '</div>' +
                '</li>'
            )
        });
    })
}

function choosePet(pet) {
    localStorage.setItem('petId', pet.id)
    window.location.href = "/tamagotchi";
}

function sound_button() {
    let sound = document.getElementById("sound_button")
    sound.play()
}

function petDead(pet) {
    if (pet.state != 'dead') {
        return true
    }
    else {
        return false
    }
}

async function death(pet) {
    if(confirm("Tem certeza que dejesa deletar este pokemon?")){
        await axios.delete('/api/pet/'+pet.name)
        window.location.reload(false);
    }
}