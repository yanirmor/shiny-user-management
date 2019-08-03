$(function() {
   
  // limit contact form fields length
  
  function textInputLimit(event) {
   if ($(this).val().length <= event.data.limit) return;
   $(this).val($(this).val().substring(0, event.data.limit));
  }
   
  $("#contact_name").on("keyup", { limit: 50 }, textInputLimit);
  $("#contact_email").on("keyup", { limit: 50 }, textInputLimit);
  $("#contact_message").on("keyup", { limit: 255 }, textInputLimit);
    
});
