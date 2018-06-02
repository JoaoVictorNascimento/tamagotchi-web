$(document).ready(function () {
    axios.get('api/userpets').then(function (res) {
        data = res.data
        if(data.length > 0){
            localStorage.setItem('petId', data[0]._id.$oid)
        } 
        data.filter(petDead).forEach(pet  => {
            console.log(pet)
            $('#pets ul').append(
                '<li class="my-list-group-item" id='+ pet._id.$oid +' onClick="choosePet(this)">' +
                    '<div class="my-row">'+
                        '<div class="my-col infopet-gif">' +
                            '<img src="images/' + pet.petType + pet.stage + '.gif" class="gif_pet1">' +
                        '</div>' +
                        '<div class="my-col infopet">' +
                            '<a>'+pet.name+'</a>' +
                            '</br>' +
                            '<a>'+pet.state+'</a>' +
                        '</div>'+
                    '</div>'+
                '</li>'
            )
        });
    })
});

function choosePet(pet){
    localStorage.setItem('petId', pet.id)
    window.location.href = "/tamagotchi";
}

function sound_button(){
    let sound = document.getElementById("sound_button")
    sound.play()
}

function petDead(pet){
    if(pet.state != 'dead'){
        return true
    }
    else{
        return false
    }
}