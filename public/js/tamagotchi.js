let petId = localStorage.getItem('petId')

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

// TODO update values on screen
// TODO save pet id
async function update() {
    let res = await axios.get('api/pet/' + petId)
    data = res.data
    console.log(data)
    $('#health').val(data.health)
    $('#happy').val(data.happy)
    $('#hunger').val(data.hunger)
    $('#energy').val(data.tiredness)
    $('#higiene').val(data.higiene)
    await sleep(10000)
    update()
}

$(document).ready(function () {
    axios.get('api/pet/' + petId).then(function (res) {
        data = res.data
        $('#health').val(data.health)
        $('#happy').val(data.happy)
        $('#hunger').val(data.hunger)
        $('#energy').val(data.tiredness)
        $('#higiene').val(data.higiene)
        $('#pet').attr("src", "images/" + data.petType + data.stage + ".gif");
        console.log( $('#pet'))
        update()
    }).catch(function (err) {
        console.log(err)
    })
});
