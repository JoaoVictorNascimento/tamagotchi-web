coin = ''
function movecoin(){
    console.log("oi")
    $("#coin").addClass('turncoin')
}

function select(opt){
    if (coin == ''){
        coin = opt.id
    }
}