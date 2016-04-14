$(document).ready(function(){
  // Track clicks on podcast links on homepage.
  $(".podcast-index-link").on("click", function() {
    var podcastTitle = $(this).data('podcastTitle');
    ga(
      'send',
      'event',
      'Podcast',
      'clicked',
      'Link to Show Page: ' + podcastTitle
    );
  });

  // Track clicks on play links on podcast show pages.
  $("button.jp-play-frontend").on("click", function() {
    var podcastTitle = $(this).data('podcastTitle');
    ga(
      'send',
      'event',
      'Podcast',
      'clicked',
      'Play Btn: ' + podcastTitle
    );
  });
});
