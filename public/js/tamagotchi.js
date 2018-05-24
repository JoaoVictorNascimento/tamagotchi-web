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
        $('#food').popover({
            html : true,
            trigger: 'focus',
            title: function () {
                return $("#header-food").html();
            },
            content: function() {
                return $("#body-food").html();
            }
        });
        $('#info').popover({
            html : true,
            trigger: 'focus',
            title: function () {
                return $("#header-info").html();
            },
            content: function() {
                return $("#body-info").html();
            }
        });

        document.getElementById("name1").innerHTML = data.name;
        document.getElementById("state").innerHTML = data.state;
        document.getElementById("weight").innerHTML = data.weight;
        document.getElementById("age").innerHTML = data.age;

        console.log( $('#pet'))
        update()
    }).catch(function (err) {
        console.log(err)
    })
});
