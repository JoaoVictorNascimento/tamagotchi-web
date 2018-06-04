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
                '<li class="my-list-group-item" id=' + pet._id.$oid + '>' +
                    '<div class="my-row">' +
                        '<div class="my-col image-pet-ranked">' +
                            '<img src="images/' + pet.petType + pet.stage + '.gif" class="gif_pet">' +
                        '</div>' +
                        '<div class="my-col infopet-ranking">'+
                            '<a>Name: '+ pet.name +'</a></br>'+
                            '<a>Age: '+ pet.age +' Days</a></br >'+
                            '<a>Trainer: ' + pet.creator + '</a></br>' +
                        '</div>' +
                    '</div>' +
                '</li>'
            )
        });
    })
});