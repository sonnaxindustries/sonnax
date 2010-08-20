$(document).ready(function() {
  $('#distributors table tr').hover(
    function() {
      $(this).addClass('table-hover');
    },
    function() {
      $(this).removeClass('table-hover');
    }
  );
  
  $('div#masthead ul li').mouseover(function() {
    $(this).addClass('sfhover');
  });
  
  $('div#masthead ul li').mouseout(function() {
    $(this).removeClass('sfhover');
  });
})