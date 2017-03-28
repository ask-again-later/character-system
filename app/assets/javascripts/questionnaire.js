$(document).ready(function() {
  $('table.table#questionnaire tbody').sortable({
    stop: function() {
      var sectionId;
      $('#questionnaire tbody tr').each(function (index) {
        $(this).find('.order-field').val(index);
        $(this).find('span.order').text(index);

        $.ajax({
          method: 'POST',
          url: '/storytellers/questionnaire_sections/reorder',
          data: $('form').serialize()
        });
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
    var newindex = $('ul#questionnaire li').length;
    $newItem.find('input').each(function() {
      $(this).attr('name', $(this).attr('name').replace("[]", "["+newindex+"]"));
    });
    $list.append($newItem);
    $('ul#questionnaire').trigger('stop');
  });

  $('ul#questionnaire').delegate('.delete', 'click', function() {
    var conf = confirm('Are you sure you want to delete this question?');
    if (conf === true) {
      var $parent = $(this).closest('li');
      if ($(this).find('.question-id').val() == "") {
        $parent.remove();
      } else {
        $parent.hide();
        $parent.find('.destroy').val(1);
      }
    }
    return;
  });
});
