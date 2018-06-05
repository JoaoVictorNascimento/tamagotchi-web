var enemyLife = 150;
let petId = localStorage.getItem('petId')

function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function punch(){
    let sound = document.getElementById("punch")
    sound.play()
}

$(document).ready(function () {
    axios.get('api/pet/' + petId).then(function (res) {
        data = res.data
        num = getRandomInt(1,4);
        console.log(data.name)
        $('#pokemonLife').val(data.health)
        $('#myPoke').attr("src", "images/" + data.petType + '_back' + data.stage + ".gif");
        $('#pokeName').text(data.name)
        $('#background_battle').attr("src","images/" + 'background_battle' + num + ".png");
        if(data.health <= 2){
            alert("Seu pokemon está incapaz de lutar")
            window.location.href = "/tamagotchi";
        }
    }).catch(function (err) {
        console.log(err)
    })
});

function attack(x) { 
    axios.post('/api/minigame/battle/'+petId, {
        attack: x,
        enemy: enemyLife
    }).then(function (res) {
        $('#myPoke').addClass('mypokemon-attack')
        punch();
        setTimeout(function(){
            $('#myPoke').removeClass('mypokemon-attack')
            $('#lucario1').addClass('lucario-attack')
            punch();
            
        },400);
        setTimeout(function(){
            $('#lucario1').removeClass('lucario-attack')
            sound.play()
        },700);
        data = res.data
        console.log(data)
        enemyLife = data.enemy
        $("#lucario").val(enemyLife)
        $('#pokemonLife').val(data.life)
        punch();
        if (data.life <= 0){
            recive(10)
            alert("Seu pokemon está desmaiado")
            window.location.href = "/tamagotchi";
            $('#myPoke').removeClass('mypokemon-attack')
        }
        if (enemyLife <= 0){
            recive(100)
            alert("Voce ganhou a luta")
            window.location.href = "/tamagotchi";
            $('#myPoke').removeClass('mypokemon-attack')
        }
    })
}
