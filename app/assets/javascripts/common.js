$(document).ready(function() {
  $('.hamburger').on('click', function() {
    $(this).toggleClass('is-active');
    if ($(this).hasClass('is-active')) {
      $('nav').addClass('show');
      $('body').addClass('nav-open');
    } else {
      $('nav').removeClass('show');
      $('body').removeClass('nav-open');
    }
  });

  $('.messages .msg .close').on('click', function(e) {
    e.preventDefault();
    $(this).parents('.msg').fadeOut();
  });
});
