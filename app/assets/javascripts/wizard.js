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
