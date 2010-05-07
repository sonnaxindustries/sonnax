$(document).ready(function() {
  $('a.destroy').click(function(e) {
    
    if (confirm('Are you sure you want to delete?')) {
      $.ajax({
        url: $(this).attr('href'),
        type: 'DELETE',
        dataType: 'json',
        success : function(response) {
          if (response.id_to_remove) {
            $('#' + response.id_to_remove).fadeOut('slow');
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