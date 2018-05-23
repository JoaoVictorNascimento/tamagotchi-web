function logout() {
    axios.post('api/logout').then(function () {
        localStorage.clear();
        window.location.href = "/";
    }).catch(function (err) {
        console.log(err)
    })
}