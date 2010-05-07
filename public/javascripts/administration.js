$(document).ready(function() {
  $('body').addClass('js-enabled');
  
  $('div table tr').hover(
    function() {
      $(this).addClass('hover-row');
    },
    function() {
      $(this).removeClass('hover-row');
    }
  );
  
  $('a.destroy').click(function(e) {
    
    if (confirm('Are you sure you want to delete?')) {
      $.ajax({
        url: $(this).attr('href'),
        type: 'DELETE',
        dataType: 'json',
        success : function(response) {
          if (response.id_to_remove) {
            $('#' + response.id_to_remove).fadeOut('slow');
            $('div.flash-notice p').html(response.message);
          };
        },
        error : function(response) {
          alert('error');
        }
      });
    };
    
    return false;
  })
})