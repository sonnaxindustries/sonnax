$(document).ready(function() {
  $('#distributors table tr').hover(
    function() {
      $(this).addClass('table-hover');
    },
    function() {
      $(this).removeClass('table-hover');
    });
})