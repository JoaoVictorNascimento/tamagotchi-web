$(document).ready(function () {
    axios.get('api/userpets').then(function (res) {
        data = res.data
        data.forEach(pet => {
            console.log(pet)
            $('#pets ul').append(
                '<li class="my-list-group-item" id='+ pet._id.$oid +' onClick="choosePet(this)">' +
                    '<div class="my-row">'+
                        '<div class="my-col infopet-gif">' +
                            '<img src="images/' + pet.petType + '.gif" class="gif_pet">' +
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