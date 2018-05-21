function login(){
    let username = $('#username').val()
    let password = $('#password').val()
    
    axios.post('/api/login', {
        username: username,
        password: password
    }).then(function (res) {
        window.localStorage.setItem('token', res.data.token);
        window.location.href = "/mypets";
    }).catch(function (err) {
        console.log(err)
        alert(err.response.data.message)
    })
}