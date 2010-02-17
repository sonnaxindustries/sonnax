$(document).ready(function() {
  $('a.add-line-item').click(function(e) {
    var speedOrderTable = $('table.speed-order');
    var tableBody = speedOrderTable.find('tbody');
    var totalItems = tableBody.find('tr').size();
    var nextNum = totalItems + 1;
    
    tableBody.find('tr:first').clone().appendTo(tableBody);
    e.preventDefault();
  })
  
  //NOTE: On blur of the text field, if anything is entered, validate it and then if the result is 200OK, then its valid, otherwise, it's invalid
  $('form#speed-order-form td.part-number input').blur(function() {
    console.log('finished adding a part number');
    //$(this).closest('tr').addClass('valid');
  });
  
  $('form#speed-order-form').submit(function(e) {
    alert('Submitting the Form');
    e.preventDefault();
  })
})