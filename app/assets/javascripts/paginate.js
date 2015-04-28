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

        // this JSON grabs the confessions on the next page
        $.ajax({
          type: "GET",
          url: "/schools/3",
          // dataType: "json",
          success: function(data) {
            var confessions = $.parseJSON(data);
            console.log(confessions.title);
          },
          error: function(data) {

          }

        });




        // $.getJSON($moreConfessions).then(function(data) {
        //   var moreConfessions = data;
        //   setTimeout(function() { 
        //     for(i = 0; i < moreConfessions.length; i++) {
        //       $paginationBar.html("");
        //       // how can I take these javascript objects and fill the _confession partial with them? and then append those partials to the confessions container?
        //       debugger;
        //       $confessionsContainer.append(moreConfessions[i]);
        //     }
        //   }, 1000);
        // });
      }
    });
  }

});