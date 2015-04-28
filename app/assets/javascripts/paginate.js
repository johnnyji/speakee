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


        // OPTION 1
        $.ajax({
          method: "GET",
          url: $moreConfessions,
          dataType: "json",
          success: function(data) {
            $.each(data, function(index, confession) {
              console.log(confession.title);
              // data is now the retrieved confessions of the next page, now how to convert those into confession objects and append them to the confessions container?
            });
          },
          error: function(data) {
            // where and how in my controller do I specify what JSON data gets send in case of a non-200 status code?
          }

        });

        // OPTION 2
        $.getJSON($moreConfessions).then(function(data) {
          var moreConfessions = data;
          setTimeout(function() { 
            for(i = 0; i < moreConfessions.length; i++) {
              $paginationBar.html("");
              // how can I take these javascript objects and fill the _confession partial with them? and then append those partials to the confessions container?
              debugger;
              $confessionsContainer.append(moreConfessions[i]);
            }
          }, 1000);
        });

      }
    });
  }

});