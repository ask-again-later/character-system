$(document).ready(function() {

  $('table.table#questionnaire tbody').sortable({
    stop: function() {
      var sectionId;
      $('#questionnaire tbody tr').each(function (index) {
        $(this).find('.order-field').val(index);
        $(this).find('span.order').text(index);
      });
    }
  });

  $('ul#questionnaire').sortable({
    handle: 'label.handle',
    stop: function() {
      $('#questionnaire li').each(function (index) {
        $(this).find('.order-field').val(index);
      });
    }
  });

  $('ul#questionnaire').delegate('.add-question', 'click', function(e) {
    e.preventDefault();
    var $newItem = $('.question-template').children().clone();
    var $list = $(this).closest('li').find('ul');
    $list.append($newItem);
    $('#questionnaire').trigger('stop');
  });

  $('#questionnaire').delegate('.delete', 'click', function() {
    var conf = confirm('Are you sure you want to delete this question?');
    if (conf === true) {
      $(this).closest('li').remove();
    }
    return;
  });
});
