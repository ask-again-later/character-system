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

  $('#add-question').on('click', function(e) {
    e.preventDefault();
    var $newItem = $('.question-template').children().clone();
    var $list = $('ul#questionnaire');
    $list.append($newItem);
    $('ul#questionnaire').trigger('stop');
  });

  $('ul#questionnaire').delegate('.delete', 'click', function() {
    var conf = confirm('Are you sure you want to delete this question?');
    if (conf === true) {
      $(this).closest('li').remove();
    }
    return;
  });
});
