function mute() {
    som = document.getElementById("into"); 
    som.muted = !som.muted
    window.localStorage.setItem('mute', som.muted);
}

$(document).ready(function (){
    muted = window.localStorage.getItem('mute')
    som = document.getElementById("into"); 
    if(muted == 'true'){
        som.muted = true
    } else {
        som.muted = false
    }
    console.log(muted)
});

function recive(x){
    axios.put("/api/recive", {
        cash:x
    }).then(res => {
        console.log(res)
    })
}