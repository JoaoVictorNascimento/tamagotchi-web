var enemyLife = 150;
let petId = localStorage.getItem('petId')

$(document).ready(function () {
    axios.get('api/pet/' + petId).then(function (res) {
        data = res.data
        console.log(data.name)
        $('#pokemonLife').val(data.health)
        $('#myPoke').attr("src", "images/" + data.petType + '_back' + data.stage + ".gif");
        $('#pokeName').text(data.name)
    }).catch(function (err) {
        console.log(err)
    })
});

function attack(x) {
    axios.post('/api/minigame/battle/'+petId, {
        attack: x,
        enemy: enemyLife
    }).then(function (res) {
        data = res.data
        console.log(data)
        enemyLife = data.enemy
        $("#lucario").val(enemyLife)
        $('#pokemonLife').val(data.life)
        if (data.life <= 0){
            alert("Seu pokemon está desmaiado")
            window.location.href = "/tamagotchi";
        }
        if (enemyLife <= 0){
            alert("Voce ganhou a luta")
            window.location.href = "/tamagotchi";
        }
    })
}