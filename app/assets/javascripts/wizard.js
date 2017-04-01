$(document).ready(function() {
  $('.build-method label').on('click', function() {
    $(this).addClass('checked').siblings('.checked').removeClass('checked');
  });

  $('#back').on('click', function(e) {
    e.preventDefault();
    $('#form-action').val('save-back');
    $('form').submit();
  });

  $('#save').on('click', function(e) {
    e.preventDefault();
    $('#form-action').val('save');
    $('form').submit();
  });

  $('#save-continue').on('click', function(e) {
    e.preventDefault();
    $('#form-action').val('save-continue');
    $('form').submit();
  });

  $('#save-skip').on('click', function(e) {
    e.preventDefault();
    $('#form-action').val('save-skip');
    $('form').submit();
  });

  $('#switch-non-mechanics').on('click', function(e) {
    e.preventDefault();
    $('#character_use_extended').val('true');
    $('#form-action').val('switch-non-mechanics');
    $('form').submit();
  });
});
