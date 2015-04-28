$(function() {
  var $paginationBar = $('.pagination');
  var $confessionsContainer = $('.school-confessions-container');

  //if statements checks if the page contains pagination before listening for scroll
  if ($paginationBar.length) {
    $(window).on('scroll', function(e) {
      var $moreConfessions = $('.pagination .next_page').attr('href');
      var $nearBottomOfScreen = $(window).scrollTop() > $(document).height() - $(window).height() - 130;

      if ($moreConfessions && $nearBottomOfScreen) {
        $paginationBar.html('<p class="load-more-confessions">Loading Confessions...</p>');
        console.log('hit');
        setTimeout(function() {
          $.ajax({
            method: "GET",
            url: $moreConfessions,
            dataType: "html",
            success: function(data) {
              // parses the HTML file for only confession partial div
              var $nextPageConfessions = $('.confession-container', $.parseHTML(data));
              $confessionsContainer.append($nextPageConfessions);
            },
            error: function(data) {
              // where and how in my controller do I specify what JSON data gets send in case of a non-200 status code?
            }
          });
        }, 1000);
      }
      if (!$moreConfessions) {
        $paginationBar.html('');
      }
    });
  }

});