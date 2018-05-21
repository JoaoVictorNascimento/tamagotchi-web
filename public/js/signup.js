function signup(){
    let username = $('#username').val()
    let password = $('#password').val()
    let confirmPassword = $('#confirmPassword').val()
    
    if(password == confirmPassword){
        axios.post('/api/createuser', {
            username: username,
            password: password
        }).then(function (res) {
            alert('Cadastro realizado com sucesso')
            window.location.href = "/";
        }).catch(function (err) {
            alert(err.response.data.message)
        })
    } else {
        alert("senhas não combinam")
    }
}