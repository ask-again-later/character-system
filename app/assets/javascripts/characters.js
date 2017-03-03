$('input[name="character[strength]"]').on('change', function() {
  $('input#character_speed').val(5+parseInt($('input[name="character[strength]"]:checked').val()));
});

$('input[name="character[resolve]"]').on('change', function() {
  $('input#willpower').val(5+parseInt($('input[name="character[resolve]"]:checked').val()));
});

$('input[name="character[composure]"], input[name="character[dexterity]"]').on('change', function() {
  var composure = parseInt($('input[name="character[composure]"]:checked').val());
  var dexterity = parseInt($('input[name="character[dexterity]"]:checked').val());
  $('input#character_initiative').val(composure+dexterity);
});

$('input[name="character[wits]"], input[name="character[dexterity]"]').on('change', function () {
  var wits = parseInt($('input[name="character[wits]"]:checked').val());
  var dexterity = parseInt($('input[name="character[dexterity]"]:checked').val());
  $('input#character_defense').val(wits+dexterity);
});

$('#advantage-add').on('click', function(e) {
  e.preventDefault();
  var $selected = $('#advantages option:selected');
  var specification = $selected.data('specification');
  var ratings = $selected.data('allowed-ratings');
  var advantageId = $selected.val();
  var name = $selected.text().replace(/\s\[[0-9\,]+\]/, "");
  var lowestRating;
  if (ratings.length > 1) {
    lowestRating = ratings.split(",")[0];
  } else {
    lowestRating = ratings;
  }

  $('ul#advantages-list').append('<li>'+name+((specification) ? ' (<span class="specification"></span>)' : '')+((ratings.length > 1) ? ' <span class="rating">'+lowestRating+'</span>' : '')+' <a href="#" class="advantage-edit"><i class="fa fa-edit"></i></a> <a href="#" class="advantage-delete"><i class="fa fa-minus-circle"></i></a><input type="hidden" name="character[character_has_advantages][][id]" value="" /><input type="hidden" name="character[character_has_advantages][][advantage_id]" value="'+advantageId+'" /><input type="hidden" name="character[character_has_advantages][][rating]" value="'+lowestRating+'" /><input type="hidden" name="character[character_has_advantages][][specification]" value="" /></li>');
});

$("#advantages-list").delegate('.advantage-edit', 'click', function(e) {
  e.preventDefault();
  // get the modal + advantage data
  var $modal = $('#advantages-overlay .modal');
  var $advantage = $(this).parent('li');
  var index = $advantage.index();
  var rating = $advantage.find('input[name="character[character_has_advantages][][rating]"]').val();
  var advantageId = $advantage.find('input[name="character[character_has_advantages][][advantage_id]"]').val();
  var specification = $advantage.find('input[name="character[character_has_advantages][][specification]"]').val();
  // get advantage data from API

  $.ajax({
    url: '/api/advantages/'+advantageId,
    method: 'GET',
    success: function(data) {
      $modal.find('#modal-description').html(data.description);
      $modal.find('.header span').text(data.name);
      // hide all the stuff that's irrelevant
      if (!data.requires_specification) {
        $modal.find('.specification').hide();
      } else {
        $modal.find('.specification').show();
      }
      var ratings = data.allowed_ratings.split(",");
      var opt = "";
      $modal.find('#modal-rating').empty();
      for (var i = 0; i < ratings.length; i++) {
        opt = "<option value='"+ratings[i]+"'";
        if (ratings[i] === rating) {
          opt += " selected='selected'";
        }
        opt += ">"+ratings[i]+"</option>";
        $modal.find('#modal-rating').append(opt);
      }
      if (!(data.allowed_ratings.length > 1)) {
        $modal.find('.rating').attr("disabled", "disabled");
      } else {
        $modal.find('.rating').removeAttr("disabled");
      }
    }
  });
  // put the data in the modal from the advantage

  $modal.find('#modal-specification').val(specification);
  $modal.find('#modal-id').val(index);

  $('.overlay').fadeIn();
});

$('#save-advantage').on('click', function(e) {
  var $modal = $('#advantages-overlay .modal');
  var specification = $modal.find('#modal-specification').val();
  var rating = $modal.find('#modal-rating').val();
  var advantageToUpdate = $modal.find('#modal-id').val();
  var $advantage = $('#advantages-list li:nth-child('+(parseInt(advantageToUpdate)+1)+')');
  // update both display and hidden field values

  $advantage.find('.rating').text(rating);
  $advantage.find('input[name="character[character_has_advantages][][rating]"]').val(rating);
  $advantage.find('.specification').text(specification);
  $advantage.find('input[name="character[character_has_advantages][][specification]"]').val(specification);
  $('.overlay').fadeOut();
});

$('#cancel-advantage').on('click', function(e) {
  $('.overlay').fadeOut();
});

$('#advantages-list').delegate(".advantage-delete", 'click', function(e) {
  e.preventDefault();
  $(this).parent('li').detach();
});

$('#challenge-add').on('click', function(e) {
  e.preventDefault();
  var $selected = $('#challenges option:selected');
  var name = $selected.text();
  var challengeId = $selected.val();

  $('ul#challenges-list').append('<li data-challenge-id="'+challengeId+'">'+name+'<a href="#" class="challenge-delete"><i class="fa fa-minus-circle"></i><div class="description"></div><input type="hidden" name="character[character_has_challenges][][id]" value="" /><input type="hidden" name="character[character_has_challenges][][challenge_id]" value="'+challengeId+'" /></li>');

  $.ajax({
    url: '/api/challenges/'+challengeId,
    method: 'GET',
    success: function(data) {
      $('#challenges-list li').last().find('.description').html(data.description);
    }
  });
});

$('#challenges-list').delegate('.challenge-delete', 'click', function(e) {
  e.preventDefault();
  $(this).parent('li').detach();
});

$('.dot').on('click', function(e) {
  e.preventDefault();
  if ($(e.target).hasClass('dot')) {
    $(this).addClass('selected').prevAll().addClass('selected');
    $(this).nextAll().removeClass('selected');
    $(this).find('input').attr("checked", "checked");
    $(this).find('input').change();
  }
});
