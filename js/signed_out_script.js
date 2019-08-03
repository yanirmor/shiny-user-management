$(function() {
  
  "use strict";
  
  // key events
  
  $("#sign_in_section .form-control").keyup(function(event) { 
    if (event.keyCode == 13) $("#sign_in_button").click();
  });
  
  $("#sign_up_section .form-control").keyup(function(event) { 
    if (event.keyCode == 13) $("#sign_up_button").click();
  });
  
});
