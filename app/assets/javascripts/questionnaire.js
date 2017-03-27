$(document).ready(function() {
  /*$('#questionnaire').sortable({
    handle: 'label',
    stop: function() {
      var length = $('#questionnaire > li').length;
      $('#questionnaire > li').each(function (index) {
        $(this).find('.order-field').val(index);
      });
    }
  });*/

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

  $('.delete').click(function() {
    $(this).parent().remove();
  })
});
