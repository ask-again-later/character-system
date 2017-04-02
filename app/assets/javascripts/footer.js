$(document).ready(function() {
  $('.table').dataTable();

  $('textarea').wrap('<div class="textarea-wrapper"></div>');
  $('.textarea-wrapper').append('<span class="notice">You can use <a href="https://guides.github.com/features/mastering-markdown/" rel="external" target="_blank">Markdown</a> in this area.</span>');
});
