function mute() {
    var bool = $("#player").muted;
    $("#player").attr("muted",!bool);
}