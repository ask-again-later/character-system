$(document).ready(function() {
  $('.questionnaire h4').on('click', function() {
    if ($(this).hasClass('open')) {
      $(this).removeClass('open');
      $(this).next('.section-content').slideUp();
    } else {
      $(this).addClass('open');
      $(this).next('.section-content').slideDown();
    }
  });

  $('.questionnaire h4:first-of-type').click();

  $('.table').dataTable();
});
