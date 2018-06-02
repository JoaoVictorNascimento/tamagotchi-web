var wins = 0


function playCoin(op){
    let coin
    $('#coin').addClass('coin1-active')
    if(op.id == 'head'){
        coin = 1
    } else {
        coin = 0
    }

    let play = document.getElementById("music_coin")
    play.play()

    setTimeout(function(){
        $('#coin').removeClass('coin1-active')
    },500);

        axios.post('api//minigame/coin', {
            coin: coin
        }).then(function (res) {
            data = res.data
            if (data > 0){
                win = "YOU WIN"
                $('#result').text(win)
                if (coin == 1){
                    coins = "Head"
                    $('#coin2').text(coins)
                    
                } else {
                    coins = "Tails"
                    $('#coin2').text(coins)
                }
                wins += 1;
                $('#number').text('Victories: '+ wins)
            } else {
                wins = 0;
                lose = "YOU LOSE"
                $('#result').text(lose)
                if (coin == 1){
                    coins = "Tails"
                    $('#coin2').text(coins)
                } else {
                    coins = "Head"
                    $('#coin2').text(coins)
                }
            }
        })
}
