$(document).ready(function() {

  $('#questionnaire').nestedSortable({
    handle: 'label.handle',
    listType: 'ul',
    items: 'li',
    toleranceElement: '.container',
    maxLevels: 2,
    protectRoot: true,
    stop: function() {
      var sectionId;
      $('#questionnaire > li').each(function (index) {
        $(this).find('.order-field').val(index);
        $(this).find('ul').children().each(function(subindex) {
          $(this).find('.order-field').val(subindex);
        })
      });
    }
  });

  $('#questionnaire').delegate('.add-question', 'click', function(e) {
    e.preventDefault();
    var $newItem = $('.question-template').children().clone();
    var $list = $(this).closest('li').find('ul');
    $list.append($newItem);
    $('#questionnaire').trigger('stop');
  });

  $('.add-section').click(function(e) {
    e.preventDefault();
    var $newItem = $('.section-template').children().clone();
    $('#questionnaire').append($newItem);
    $('#questionnaire').trigger('stop');
  });

  $('#questionnaire').delegate('li > .container.top > .delete', 'click', function() {
    var conf = confirm('Are you sure you want to delete this section? This will also delete all questions within the section.');
    if (conf === true) {
      $(this).closest('li').remove();
    }
    return;
  });

  $('#questionnaire').delegate('li > .container ul > li .delete', 'click', function() {
    var conf = confirm('Are you sure you want to delete this question?');
    if (conf === true) {
      $(this).closest('li').remove();
    }
    return;
  });
});
