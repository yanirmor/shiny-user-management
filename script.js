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
	
	// privacy notice acknowledge

  Shiny.addCustomMessageHandler("privacyNoticeOk", function(message) {
    $("#privacy_notice").slideUp();
  });
	
	// analytics events

	$("#my_email").click(function() { _paq.push(['trackEvent', 'Contact Form', 'Mailto', 'Mailto']); } );

	$("#header_buttons a[href='https://www.yanirmor.com'").click(function() { _paq.push(['trackEvent', 'Header Buttons', 'Click', 'Website']); } );
	$("#header_buttons a[href='https://github.com/yanirmor/shiny-user-management'").click(function() { _paq.push(['trackEvent', 'Header Buttons', 'Click', 'GitHub']); } );
	
	Shiny.addCustomMessageHandler("matomoEvent", function(message) {
	  _paq.push(['trackEvent', message[0], message[1], message[2]]);
	});
  
});
