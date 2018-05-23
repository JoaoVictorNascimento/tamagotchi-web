$(document).ready(function () {
    axios.get('api/userpets').then(function (res) {
        data = res.data
        data.forEach(pet => {
            console.log(pet)
            $('#pets ul').append(
                '<li class="list-group-item" id='+ pet._id.$oid +' onClick="choosePet(this)">' +
                    '<div class="row">'+
                        '<div class="col infopet-gif">' +
                            '<img src="images/' + pet.petType + pet.stage + '.gif" class="gif_pet">' +
                        '</div>' +
                        '<div class="col infopet">' +
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