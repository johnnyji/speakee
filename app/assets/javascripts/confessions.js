$(function() {
  $successMessageDiv = $('.successful-confession-message');
  $newConfessionLink = $('.new-confession-link');
  $confessionTitleError = $('.confession-title-error');
  $confessionBodyError = $('.confession-body-error');
  // clears the success and fail message when the write message link is clicked
  $newConfessionLink.on('click', function(e) {
    $successMessageDiv.html("");
    $confessionTitleError.html("");
    $confessionBodyError.html("");
  });
});
    