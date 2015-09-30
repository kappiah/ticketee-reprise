$(document).ready(function(){
  $('.tag .remove').on("ajax:success", function() {
    $(this).parent().fadeOut();
  });
});
