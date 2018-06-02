op = ''

function select(img) {
    if (op == '') {
        op = img.id
        $("#" + op).addClass('selected_pet')
    } else {
        $("#" + op).removeClass('selected_pet')
        op = img.id
        $("#" + op).addClass('selected_pet')
    }
}

function jakenpo(){
    if(op != ''){
        let jankenpo
        if (op == 'rock'){
            jankenpo = 0
        } else if (op == 'paper'){
            jankenpo = 1
        } else {
            jankenpo = 2
        }
        axios.post('/api/minigame/jankenpo', {
            jankenpo: jankenpo
        }).then(function (res) {
            data = res.data
            if(data == -1){
                recive(20)
            } else if (data == 0){
                recive(30)
            } else {
                recive(40)
            }
            if (jankenpo == 0){
                console.log(data)
                if(data == -1){
                    $('#enemyJank').attr("src", "images/paper.gif");
                    $('#resultJank').text('Voce Perdeu')
                } else if (data == 0){
                    $('#enemyJank').attr("src", "images/rock.gif");
                    $('#resultJank').text('Empate')
                } else {
                    $('#enemyJank').attr("src", "images/scissor.gif");
                    $('#resultJank').text('Voce Ganhou')
                }
            } else if (jankenpo == 1){
                console.log(data)
                if(data == -1){
                    $('#enemyJank').attr("src", "images/scissor.gif");
                    $('#resultJank').text('Voce Perdeu')
                } else if (data == 0){
                    $('#enemyJank').attr("src", "images/paper.gif");
                    $('#resultJank').text('Empate')
                } else {
                    $('#enemyJank').attr("src", "images/rock.gif");
                    $('#resultJank').text('Voce Ganhou')
                }
            } else {
                console.log(data)
                if(data == -1){
                    $('#enemyJank').attr("src", "images/rock.gif");
                    $('#resultJank').text('Voce Perdeu')
                } else if (data == 0){
                    $('#enemyJank').attr("src", "images/scissor.gif");
                    $('#resultJank').text('Empate')
                } else {
                    $('#enemyJank').attr("src", "images/paper.gif");
                    $('#resultJank').text('Voce Ganhou')
                }       
            }
        })
    } else {
        alert("escolha uma jogada!")
    }
}