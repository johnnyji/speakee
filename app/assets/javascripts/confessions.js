$(function() {
  $successMessageDiv = $('.successful-confession-message');
  $newConfessionLink = $('.new-confession-link');
  $confessionTitleError = $('.confession-title-error');
  $confessionBodyError = $('.confession-body-error');
  // clears the success and fail message when the write message link is clicked
  $newConfessionLink.on('toggle', function(e) {
    console.log('hit'); //this script isn't even running
    $(this).text("Nevermind");
    $successMessageDiv.html("");
    $confessionTitleError.html("");
    $confessionBodyError.html("");
  },
  function(e) {
    $(this).text("Write a confession");
  });
});
    