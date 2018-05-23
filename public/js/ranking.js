function treatAsUTC(date) {
    var result = new Date(date);
    result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
    return result;
}

function daysBetween(startDate, endDate) {
    var millisecondsPerDay = 24 * 60 * 60 * 1000;
    return (treatAsUTC(endDate) - treatAsUTC(startDate)) / millisecondsPerDay;
}

$(document).ready(function () {
    axios.get('api/pets').then(function (res) {
        data = res.data

        data.sort(function (a, b) {
            if (a.age > b.age) {
                return -1
            } else {
                return 1
            }
        })
        data.forEach(pet => {
            $('#pets ul').append(
                '<li class="list-group-item" id=' + pet._id.$oid + '>' +
                    '<div class="row">' +
                        '<div class="col image-pet-ranked">' +
                            '<img src="images/' + pet.petType + pet.stage + '.gif" class="gif_pet">' +
                        '</div>' +
                        '<div class="col infopet-ranking">'+
                            '<a>Nome: '+ pet.name +'</a></br>'+
                            '<a>Idade: '+ pet.age +' dias</a></br >'+
                            '<a>Criador: ' + pet.creator + '</a></br>' +
                        '</div>' +
                    '</div>' +
                '</li>'
            )
        });
    })
});