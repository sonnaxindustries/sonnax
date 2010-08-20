$(document).ready(function() {
  $('a[href^="http://"]:not("[href*=sonnax.com]"), a[rel="external"], a[href$="pdf"]').click(function(e) {
    //var pageInfo = $(this).attr('href') + " (" + $(this).attr('title') + ")";
    //pageTracker._trackEvent('Outgoing', 'ClickedExternalLink', pageInfo);
    window.open($(this).attr('href'));
    e.preventDefault();
  })
  
  $('a[href^="mailto:"]').click(function(e) {
    //pageTracker._trackEvent('Email', 'ClickedMailtoLink', $(this).attr('href').replace('mailto:', ''));
  })
  
  $('a[href^="mailto:"]').addClass('link-email');
  $('a[href^="http://"]:not("[href*=within3.com]"), a[rel="external"]').addClass('link-external');
});