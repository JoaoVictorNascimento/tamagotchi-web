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

function feed(x) {
    axios.put('api/pet/' + petId + '/feed', {
        value: x
    }).then(function (res) {
        data = res.data
        console.log(data)
        $('#hunger').val(data.hunger)
    }).catch(function (err) {
        console.log(err)
    })
}

function clean(x) {
    axios.put('api/pet/' + petId + '/clean', {
        value: x
    }).then(function (res) {
        data = res.data
        console.log(data)
        $('#higiene').val(data.higiene)
    }).catch(function (err) {
        console.log(err)
    })
}

function play(x) {
    axios.put('api/pet/' + petId + '/play', {
        value: x
    }).then(function (res) {
        data = res.data
        console.log(data)
        $('#happy').val(data.happy)
    }).catch(function (err) {
        console.log(err)
    })
}

function heal(x) {
    axios.put('api/pet/' + petId + '/heal', {
        value: x
    }).then(function (res) {
        data = res.data
        console.log(data)
        $('#health').val(data.health)
    }).catch(function (err) {
        console.log(err)
    })
}

function goSleep() {
    axios.put('api/pet/' + petId + '/sleep').then(function (res) {
        data = res.data
        console.log(data)
    }).catch(function (err) {
        console.log(err)
    })
}