$(function() {
  
  "use strict";
  
  // about section handler
  Shiny.addCustomMessageHandler("aboutSectionHandler", function(message) {
	  if (message == "show") {
	    $("#about").show();  
	    
	  } else if (message == "hide") {
	    $("#about").hide();  
	  }
  });
  
  // close modals with enter
  //$(document).keyup(function(event) { 
  //  if ($(".modal").length > 0 & event.keyCode == 13) {
  //    $(".modal").modal("hide");
  //  }
  //});
  
  // licenses tooltip

	$("#licenses > span").hover(
		function() { $("#licenses > div").fadeIn(); },
		function() { $("#licenses > div").fadeOut(); }
	);
  
});
