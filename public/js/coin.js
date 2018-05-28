var wins = 0

function movecoin(){
    console.log("oi")
    $("#coin").addClass('turncoin')
}

function playCoin(op){
    let coin 
    if(op.id == 'head'){
        coin = 1
    } else {
        coin = 0
    }
    axios.post('api//minigame/coin', {
        coin: coin
    }).then(function (res) {
        data = res.data
        if (data > 0){
            alert("YOU WIN")
            wins += 1;
            console.log(wins)
            $('#number').text(wins)
        } else {
            alert("YOU LOSE")
        }
    })
}