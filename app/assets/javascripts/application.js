// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require froala_editor.min.js
//= require plugins/lists.min.js
//= require plugins/char_counter.min.js
//= require dataTables/jquery.dataTables
//= require_tree .

$('textarea').froalaEditor();

$('.table').dataTable();

$('.dot').on('click', function(e) {
  if ($(this).hasClass('filled')) {
    $(this).removeClass('filled');
  } else {
    $(this).addClass('filled');
    $(this).find('input[type="radio"]').attr("checked", "checked");
    $(this).siblings().find('input[type="radio"]').removeAttr("checked");
    $(this).prevAll().addClass("filled");
  }
});
