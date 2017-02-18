$(document).ready(function() {
  $('#questionnaire').sortable({
    handle: 'label',
    stop: function() {
      var length = $('#questionnaire li').length;
      $('#questionnaire li').each(function (index) {
        $(this).find('.order-field').val(index);
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
