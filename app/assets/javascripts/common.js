$(document).ready(function() {
  $('.hamburger').on('click', function() {
    $(this).toggleClass('is-active');
    if ($(this).hasClass('is-active')) {
      $('nav').addClass('show');
    } else {
      $('nav').removeClass('show');
    }
  });

  $('.messages .msg .close').on('click', function(e) {
    e.preventDefault();
    $(this).parents('.msg').fadeOut();
  });
});
