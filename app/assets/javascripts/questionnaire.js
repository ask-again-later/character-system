$(document).ready(function() {

  $('#questionnaire').nestedSortable({
    handle: 'label.handle',
    listType: 'ul',
    items: 'li',
    toleranceElement: '.container',
    maxLevels: 2,
    protectRoot: true,
    stop: function() {
      $('#questionnaire > li').each(function (index) {
        $(this).find('.order-field').val(index);
        $(this).find('ul').children().each(function(subindex) {
          $(this).find('.order-field').val(subindex);
        })
      });
    }
  });

  $('#add').click(function(e) {
    e.preventDefault();
    var $newItem = $('.template').children().clone();
    $('#questionnaire').append($newItem);
  });

  $('#questionnaire > li .delete').click(function() {
    var conf = confirm('Are you sure you want to delete this section?');
    if (conf === true) {
      $(this).parents('li').remove();
    }
    return;
  });

  $('#questionnaire > li ul li .delete').click(function() {
    var conf = confirm('Are you sure you want to delete this question?');
    if (conf === true) {
      $(this).parents('li').remove();
    }
  });
});
