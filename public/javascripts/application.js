$(document).ready(function() {  
  // CART
  $('div#cart ul.cart-options a.update').live('click', function(e) {
    var $elem = $(this);
    var $form = $('div#cart form');
    
    $.ajax({
      url: $elem.attr('href'),
      type: 'PUT',
      dataType: 'json',
      data: $form.serialize(),
      success: function(response) {
        window.location = response.redirect_to;
      }
    })
    e.preventDefault();
  });
  
  $('div#cart div.cart-container a.remove').live('click', function(e) {
    var $elem = $(this);
    $.ajax({
      url: $elem.attr('href'),
      type: 'DELETE',
      dataType: 'json',
      success: function(response) {
        window.location = response.redirect_to
      }
    })
    e.preventDefault();
  })
  // END CART
  
  // PRODUCT LINES
  $('div#product-line form div.make-selector select').live('change', function(e) {
    console.log('Changing the Make...');
    var $elem = $(this);
    $('div#product-line form div.unit-selector select').val('');
    
    $elem.after('<div class="indicator"><img src="/images/ajax/indicator-small.gif"></div>');
    
    var $form = $elem.closest('form');
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: $form.serialize(),
      dataType: 'json',
      success: function(response) {
        $elem.siblings('div.indicator').remove();
        $('div#product-line form div.unit-selector select').html(response.unit_select_options);
        
        var domId = $('div.parts-wrapper');
        $(domId).html(response.no_parts_partial);
      }
    })
    e.preventDefault();
  });
  
  $('div#product-line form div.unit-selector select').live('change', function(e) {
    console.log('Changing the Unit...');
    var $elem = $(this);
    
    $elem.after('<div class="indicator"><img src="/images/ajax/indicator-small.gif"></div>');
    var $form = $elem.closest('form');
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('type'),
      data: $form.serialize(),
      dataType: 'json',
      success: function(response) {
        $elem.siblings('div.indicator').remove();
        var domId = $('div.parts-wrapper');
        $(domId).html(response.parts_partial);
      }
    })

    e.preventDefault();
  });
  // END PRODUCT LINES
  
  //-- Technical Library
  $.tablesorter.addParser({
    id: 'mm-yyyy',
    is: function(s) {
      return false;
    },
    format: function(s) {
      s = '' + s;
      var hit = s.match(/(\d{2})-(\d{4})/);
      if (hit && hit.length == 3) {
        return hit[2] + hit[1];
      } else {
        return s;
      };
    },
    type: 'numeric'
  });
  
  $(document).bind('tablesorter-initialize', function() {
    $("div.publications table").tablesorter({
      headers:
      {
        2 : { sorter: "mm-yyyy" }
      },
      widgets: ['zebra']
    });
  })

  $(document).trigger('tablesorter-initialize');

  $('div.publication-list form div.subject-selector select').live('change', function(e) {
    var $elem = $(this);
    $('div.publication-list form div.make-selector select').val('');
    $('div.publication-list form div.unit-selector select').val('');

    $elem.after('<div class="indicator"><img src="/images/ajax/indicator-small.gif"></div>');

    var $form = $(this).closest('form');
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: $form.serialize(),
      dataType: 'json',
      success: function(response) {
        $elem.siblings('div.indicator').remove();
        $('div.publication-list form div.unit-selector select').html(response.unit_select_options);
        var domId = '#' + response.dom_id;
        $(domId).html(response.publications_partial);
        $(document).trigger('tablesorter-initialize');
      }
    });
    e.preventDefault();
  });

  $('div.publication-list form div.make-selector select').live('change', function(e) {
    var $elem = $(this);
    $('div.publication-list form div.subject-selector select').val('');
    $('div.publication-list form div.unit-selector select').val('');

    $elem.after('<div class="indicator"><img src="/images/ajax/indicator-small.gif"></div>');

    var $form = $(this).closest('form');
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: $form.serialize(),
      dataType: 'json',
      success: function(response) {
        $elem.siblings('div.indicator').remove();
        $('div.publication-list form div.unit-selector select').html(response.unit_select_options);
        var domId = '#' + response.dom_id;
        $(domId).html(response.publications_partial);
        $(document).trigger('tablesorter-initialize');
      }
    });
    e.preventDefault();
  });

  $('div.publication-list form div.unit-selector select').live('change', function(e) {
    var $elem = $(this);
    $('div.publication-list form div.subject-selector select').val('');
    $elem.after('<div class="indicator"><img src="/images/ajax/indicator-small.gif"></div>');

    var $form = $(this).closest('form');
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: $form.serialize(),
      dataType: 'json',
      success: function(response) {
        $elem.siblings('div.indicator').remove();
        var domId = '#' + response.dom_id;
        $(domId).html(response.publications_partial);
        $(document).trigger('tablesorter-initialize');
      }
    });
    e.preventDefault();
  });
  //-- /Technical Library
})