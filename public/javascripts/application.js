$(document).ready(function() {
  $('#distributors table tr').hover(
    function() {
      $(this).addClass('table-hover');
    },
    function() {
      $(this).removeClass('table-hover');
    });
})

$(document).ready(function() {

  //-- Technical Library
  $("div.publications table").tablesorter({
    widgets: ['zebra']
  });

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
      }
    });
    e.preventDefault();
  })
  //-- /Technical Library
})