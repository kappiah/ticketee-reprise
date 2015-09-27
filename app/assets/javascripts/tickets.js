$(document).ready(function() {
  $("#add_file").on("ajax:success", function(event, data) {
    $("#attachments").append(data);
    $(this).data("params", { index: $("#attachments div.file").length });
  });
});
