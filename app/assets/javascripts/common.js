$(document).ready(function() {
  $('.hamburger').on('click', function() {
    $(this).toggleClass('is-active');
    if ($(this).hasClass('is-active')) {
      $('nav').addClass('show');
    } else {
      $('nav').removeClass('show');
    }
  });

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

  $('textarea').wrap('<div class="textarea-wrapper"></div>');
  $('.textarea-wrapper').append('<span class="notice">You can use <a href="https://guides.github.com/features/mastering-markdown/" rel="external" target="_blank">Markdown</a> in this area.</span>');
});
