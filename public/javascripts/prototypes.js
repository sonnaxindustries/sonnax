$(document).ready(function() {
  $('a.add-line-item').click(function(e) {
    var speedOrderTable = $('table.speed-order');
    var tableBody = speedOrderTable.find('tbody');
    var totalItems = tableBody.find('tr').size();
    var nextNum = totalItems + 1;
    
    tableBody.find('tr:first').clone().appendTo(tableBody);
    e.preventDefault();
  })
  
  $('form#speed-order-form').submit(function(e) {
    alert('Submitting the Form');
    e.preventDefault();
  })
})