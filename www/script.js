$(document).keyup(function(event) {
  if (
    event.keyCode == 13 &&
    (
      $("#login_username").is(":focus") || 
      $("#login_password").is(":focus")
    )
  ) {
    $("#login_submit").click();
  }
});

$(document).keyup(function(event) {
  if (
    event.keyCode == 13 &&
    (
      $("#sign_up_username").is(":focus") || 
      $("#sign_up_password").is(":focus") ||
      $("#sign_up_verify").is(":focus")
    )
  ) {
    $("#sign_up_submit").click();
  }
});
