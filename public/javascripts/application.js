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
  $('div#masthead ul li').mouseover(function() {
    $(this).addClass('sfhover');
  });
  
  $('div#masthead ul li').mouseout(function() {
    $(this).removeClass('sfhover');
  });
  
  
  $('a[href^="http://"]:not("[href*=sonnax.com]"), a[rel="external"], a[href$="pdf"]').click(function(e) {
    //var pageInfo = $(this).attr('href') + " (" + $(this).attr('title') + ")";
    //pageTracker._trackEvent('Outgoing', 'ClickedExternalLink', pageInfo);
    window.open($(this).attr('href'));
    e.preventDefault();
  })
  
  $('a[href^="mailto:"]').click(function(e) {
    pageTracker._trackEvent('Email', 'ClickedMailtoLink', $(this).attr('href').replace('mailto:', ''));
  })
  
  $('a[href^="mailto:"]').addClass('link-email');
  $('a[href^="http://"]:not("[href*=within3.com]"), a[rel="external"]').addClass('link-external');
  
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

  $('div#product-line form div.make_selector select').live('change', function(e) {
    var $elem = $(this);
    $('div#product-line form div.unit-selector select').val('');
    
    $elem.after('<div class="indicator"><img src="/images/ajax/indicator-small.gif"></div>');
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
        $(document).trigger('tablesorter-initialize');
      }
    });
    e.preventDefault();
  });
  
  $('div#product-line form div.make-selector select').live('change', function(e) {
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
        //var domId = "#" + response.dom_id;
        //$(domId).html(response.parts_partial);
      }
    })
    e.preventDefault();
  });
  
  $('div#product-line form div.unit-selector select').live('change', function(e) {
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
        //var domId = "#" + response.dom_id;
        var domId = $('div#no-parts');
        $(domId).replaceWith(response.parts_partial);
      }
    })

    e.preventDefault();
  })

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
  })
  //-- /Technical Library
})