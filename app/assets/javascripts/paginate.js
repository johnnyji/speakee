/* jshint browser:true, jquery:true, undef:true, devel:true */
$(function onDocumentReady() {
  'use strict';
  var $confessionsContainer = $('.school-confessions-container');
  var requestSent = false;

  if (!$('.pagination').length) { return; }

  $(window).on('scroll', function windowScrollHandler() {
    var $nearBottomOfScreen = $(window).scrollTop() > $(document).height() - $(window).height() - 130;

    if (!$nearBottomOfScreen) { return; }
    var $moreConfessionsUrl = $('.pagination .next_page').attr('href');
    if (!($moreConfessionsUrl && !window.requestSent)) { return; }

    var $paginationBar = $('.pagination');
    $paginationBar.text('Loading more...');
    requestSent = true;
    $.ajax({
      method: 'GET',
      url: $moreConfessionsUrl,
      dataType: 'html',
      success: function(data) {
        // parses the HTML file for only confession partial div
        var $nextPageConfessions = $('.confession-container', $.parseHTML(data));
        $confessionsContainer.append($nextPageConfessions);
        $paginationBar = $paginationBar.replaceWith($('.pagination', $.parseHTML(data)));
      },
      error: function() {
        // where and how in my controller do I specify what JSON data gets send in case of a non-200 status code?
      },
      complete: function() {
        requestSent = false;
      }
    });
  });
});