if($.browser.msie) {
  var changeEvt = "click";
}else {
  var changeEvt = "change";
}

$(document).ready(function() {
  //Focus on quick search
  $('div#quick-search input[type="text"]').focus();

  $("a[rel*=fancybox]").click(function(e) {
    var $elem = $(this);
    var imageSource = $elem.attr('href');
    var options = "resizeable=yes, toolbar=no, directories=no, location=no, status=yes, menubar=no, scrollbars=no, width=500, height=500";
    window.open(imageSource, 'ReferenceFigure', options);
    e.preventDefault();
  });

  $('a.print').live('click', function() {
    window.print();
    return false;
  });


  // CART
  $('div#cart div.cart-options ul a.update').live('click', function(e) {
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

  var $selectedMake = $('div#product-line form div.make-selector select option:selected');
  var $selectedUnit = $('div#product-line form div.unit-selector select option:selected');

  // PRODUCT LINES
  $('div#product-line form div.make-selector select').live(changeEvt, function(e) {
    $('div.search div#search-options div.search-terms input[type="text"]').val('');
    var $elem = $(this);
    var $selected = $(this).attr('selected', 'selected');
    if ($elem.val() == $selectedMake.val() || $elem.val() == '') {
      return;
    }
    $('div#product-line form div.unit-selector select').val('');

    $elem.after('<div class="indicator"><img src="/images/ajax/indicator-small.gif"></div>');
    var $form = $elem.closest('form');
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: $form.serialize(),
      dataType: 'json',
      async: 'false',
      success: function(response) {
        window.location.replace(response.redirect_url);
      }
    })
    return false;
  });

  $('div#product-line form div.unit-selector select').live(changeEvt, function(e) {
    var $elem = $(this);
    if ($elem.val() == $selectedUnit.val() || $elem.val() == '') {
      return;
    }

    $elem.after('<div class="indicator"><img src="/images/ajax/indicator-small.gif"></div>');
    window.location.replace($elem.attr('value'));
    return false;
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

  $('#distributors table').tablesorter();

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



  $('div.publication-list form div.subject-selector select').live(changeEvt, function(e) {
    var $elem = $(this);
    if ($elem.val() == '') {
      return;
    }
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

  $('div.publication-list form div.make-selector select').live(changeEvt, function(e) {
    var $elem = $(this);
    if ($elem.val() == '') {
      return;
    }
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

  $('div.publication-list form div.unit-selector select').live(changeEvt, function(e) {
    var $elem = $(this);
    if ($elem.val() == '') {
      return;
    }
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
