$(document).ready(function() {
  $('input[name="character[strength]"]').on('change', function() {
    $('input#character_speed').val(5+parseInt($('input[name="character[strength]"]:checked').val()));
  });

  $('input[name="character[resolve]"]').on('change', function() {
    $('input#character_willpower').val(5+parseInt($('input[name="character[resolve]"]:checked').val()));
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

  $('input[name="character[stamina]"]').on('change', function () {
    $('input#character_health').val(5+parseInt($('input[name="character[stamina]"]:checked').val()));
  });

  // VALIDATION

  $('.attributes input').on('change', function () {
    var mentals = parseInt($('input[name="character[intelligence]"]:checked').val()) + parseInt($('input[name="character[wits]"]:checked').val()) + parseInt($('input[name="character[resolve]"]:checked').val()) - 3;
    var physicals = parseInt($('input[name="character[strength]"]:checked').val()) + parseInt($('input[name="character[dexterity]"]:checked').val()) + parseInt($('input[name="character[stamina]"]:checked').val()) - 3;
    var socials = parseInt($('input[name="character[presence]"]:checked').val()) + parseInt($('input[name="character[manipulation]"]:checked').val()) + parseInt($('input[name="character[composure]"]:checked').val()) - 3;
    var errors = [];

    console.log(mentals);
    console.log(physicals);
    console.log(socials);

    // general error validation
    if (mentals > 6) {
      errors.push("You'll need to remove at least "+(mentals - 6)+" dots from mental attributes.");
    }
    if (physicals > 6) {
      errors.push("You'll need to remove at least "+(physicals - 6)+" dots from physical attributes.");
    }
    if (socials > 6) {
      errors.push("You'll need to remove at least "+(socials - 6)+" dots from social attributes.");
    }

    var primary_name = "";
    var secondary_name = "";
    var tertiary_name = "";
    var primary_val = 0;
    var secondary_val = 0;
    var tertiary_val = 0;

    // if user has allocated all dots (or has too many)
    if (mentals + physicals + socials >= 13) {
      if (mentals >= physicals && mentals >= socials) {
        primary_name = "mental";
        primary_val = mentals;
        // mental is primary category
        if (physicals >= socials) {
          // physical is secondary
          secondary_name = "physical";
          secondary_val = physicals;
          tertiary_name = "social";
          tertiary_val = socials;
        } else {
          // social is secondary
          secondary_name = "social";
          secondary_val = socials;
          tertiary_name = "physical";
          tertiary_val = physicals;
        }
      } else if (physicals >= mentals && physicals >= socials) {
        // physical is primary
        primary_name = "physical";
        primary_val = physicals;
        if (mentals >= socials) {
          // mental is secondary
          secondary_name = "mental";
          secondary_val = mentals;
          tertiary_name = "social";
          tertiary_val = socials;
        } else {
          // social is secondary
          secondary_name = "social";
          secondary_val = socials;
          tertiary_name = "mental";
          tertiary_val = mentals;
        }
      } else {
        // social is primary
        primary_name = "social";
        primary_val = socials;
        if (mentals >= physicals) {
          // mental is secondary
          secondary_name = "mental";
          secondary_val = mentals;
          tertiary_name = "physical";
          tertiary_val = physicals;
        } else {
          // physical is secondary
          secondary_name = "physical";
          secondary_val = physicals;
          tertiary_name = "mental";
          tertiary_val = mentals;
        }
      }
      if (primary_val === 6) {
        // configuration should be 6/4/3
        if (secondary_val > 4) {
          errors.push("You'll need to remove at least "+(secondary_val - 4)+" dot"+ (((secondary_val - 4) > 1) ? 's' : '')+" from "+secondary_name+" attributes.");
        } else if (secondary_val < 4) {
          errors.push("You'll need to add at least "+(4 - secondary_val)+" dot"+ (((4 - secondary_val) > 1) ? 's' : '')+" to "+secondary_name+" attributes.");
        }
        if (tertiary_val > 3) {
          errors.push("You'll need to remove at least "+(tertiary_val - 3)+" dot"+ (((tertiary_val - 3) > 1) ? 's' : '')+" from "+tertiary_name+" attributes.");
        } else if (tertiary_val < 3) {
          errors.push("You'll need to add at least"+(3 - tertiary_val)+" dot"+ (((3 - tertiary_val) > 1) ? 's' : '')+" to "+tertiary_name+" attributes.");
        }
      } else {
        if (secondary_val === 5) {
          // configuration should be 5/5/3
          if (secondary_val > 5) {
            errors.push("You'll need to remove at least "+(secondary_val - 5)+" dot"+ (((secondary_val - 4) > 1) ? 's' : '')+" from "+secondary_name+" attributes.");
          } else if (secondary_val < 5) {
            errors.push("You'll need to add at least "+(5- secondary_val)+" dot"+ (((5 - secondary_val) > 1) ? 's' : '')+" to "+secondary_name+" attributes.");
          }
          if (tertiary_val > 3) {
            errors.push("You'll need to remove at least "+(tertiary_val - 3)+" dot"+ (((tertiary_val - 3) > 1) ? 's' : '')+" from "+tertiary_name+" attributes.");
          } else if (tertiary_val < 3) {
            errors.push("You'll need to add at least "+(3 - tertiary_val)+" dot"+ (((tertiary_val - 3) > 1) ? 's' : '')+" to "+tertiary_name+" attributes.");
          }
        } else {
          // configuration should be 5/4/4
          if (secondary_val > 4) {
            errors.push("You'll need to remove at least "+(secondary_val - 4)+" dot"+ (((secondary_val - 4) > 1) ? 's' : '')+" from "+secondary_name+" attributes.");
          } else if (secondary_val < 4) {
            errors.push("You'll need to add at least "+(4- secondary_val)+" dot"+ (((4 - secondary_val) > 1) ? 's' : '')+" to "+secondary_name+" attributes.");
          }
          if (tertiary_val > 4) {
            errors.push("You'll need to remove at least "+(tertiary_val - 4)+" dot"+ (((tertiary_val - 4) > 1) ? 's' : '')+" from "+tertiary_name+" attributes.");
          } else if (tertiary_val < 4) {
            errors.push("You'll need to add at least"+(4 - tertiary_val)+" dot"+ (((4 - tertiary_val) > 1) ? 's' : '')+" to "+tertiary_name+" attributes.");
          }
        }
      }
    }
  });

  function totalSkillsTrainingCount() {
    var total = 0;
    $('.skills-training input:checked').each(function() {
      total += parseInt($(this).val());
    });

    return 22-total;
  }

  $('.skills-training input').on('change', function() {
    console.log('skills & trainings updated');
    var count = totalSkillsTrainingCount();
    var $indicator = $('#skills-total');
    $indicator.text(count+" Remaining");
    if (count < 0) {
      $indicator.addClass('warn');
    } else {
      $indicator.removeClass('warn');
    }
  });
  $('.skills-training input').first().trigger('change');

  function specialTrainingCount() {
    var trainings = 0;
    $('.special-training input:checked').each(function() {
      trainings += parseInt($(this).val());
    });

    return 8-trainings;
  }

  $('.special-training input').on('change', function() {
    var count = specialTrainingCount();
    var $indicator = $('#special-training');
    $indicator.text(count+" Remaining");
    if (count < 0) {
      $indicator.addClass('warn');
    } else {
      $indicator.removeClass('warn');
    }
  });
  $('.special-training input').first().trigger('change');

  function updateAdvantageCount() {
    var count = 0;
    var $indicator = $('#advantage-count');
    var $advantages = $('#advantages-list input[name="character[character_has_advantages][][rating]"]');
    $advantages.each(function() {
      count += parseInt($(this).val());
    });
    $indicator.text((17-count)+" Remaining");
    if (17-count < 0) {
      $indicator.addClass('warn');
    } else {
      $indicator.removeClass('warn');
    }
  }
  updateAdvantageCount();

  function updateChallengeCount() {
    var count = $('#challenges-list li').length;
    var $indicator = $('#challenge-count');
    $indicator.text((2-count)+" Remaining");
    if (2-count < 0) {
      $indicator.addClass('warn');
    } else {
      $indicator.removeClass('warn');
    }
  }

  updateChallengeCount();

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
    updateAdvantageCount();
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
        var converter = new showdown.Converter();
        $modal.find('#modal-description').html(converter.makeHtml(data.description));
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

    $('#advantages-overlay').fadeIn().css("display", "flex");
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
    updateAdvantageCount();
  });

  $('#cancel-advantage').on('click', function(e) {
    $('.overlay').fadeOut();
  });

  $('#advantages-list').delegate(".advantage-delete", 'click', function(e) {
    e.preventDefault();
    $(this).parent('li').detach();
    updateAdvantageCount();
  });

  $('#challenge-add').on('click', function(e) {
    e.preventDefault();
    var $selected = $('#challenges option:selected');
    var name = $selected.text();
    var challengeId = $selected.val();

    $('ul#challenges-list').append('<li data-challenge-id="'+challengeId+'"><span class="custom-name">'+name+'</span> <a href="#" class="challenge-delete"><i class="fa fa-minus-circle"></i></a><div class="description"></div><input type="hidden" name="character[character_has_challenges][][id]" value="" /><input type="hidden" name="character[character_has_challenges][][challenge_id]" value="'+challengeId+'" /><input type="hidden" name="character[character_has_challenges][][custom_description]" value="" /><input type="hidden" name="character[character_has_challenges][][custom_name]" value="" /><input type="hidden" name="character[character_has_challenges][][is_creature_challenge]" value="true" /></li>');

    $.ajax({
      url: '/api/challenges/'+challengeId,
      method: 'GET',
      success: function(data) {
        var converter = new showdown.Converter();
        $('#challenges-list li').last().find('.description').html(converter.makeHtml(data.description));
        $('#challenges-list li').data('is-creature', data.is_creature_challenge)
      }
    });
    updateChallengeCount();
  });

  $('#challenge-add-custom').on('click', function(e) {
    e.preventDefault();
    var id = $(this).data('challenge-id');

    $('ul#challenges-list').append('<li data-challenge-id="'+id+'"><span class="custom-name"></span> <a href="#" class="challenge-edit"><i class="fa fa-edit"></i></a> <a href="#" class="challenge-delete"><i class="fa fa-minus-circle"></i></a><div class="description"></div><input type="hidden" name="character[character_has_challenges][][id]" value="" /><input type="hidden" name="character[character_has_challenges][][challenge_id]" value="'+id+'" /><input type="hidden" name="character[character_has_challenges][][custom_name]" value="" /><input type="hidden" name="character[character_has_challenges][][custom_description]" value="" /><input type="hidden" name="character[character_has_challenges][][is_creature_challenge]" value="false" /></li>');

    $.ajax({
      url: '/api/challenges/'+id,
      method: 'GET',
      success: function(data) {
        var converter = new showdown.Converter();
        $('#challenges-list li').last().find('.custom-name').html(data.name);
        $('#challenges-list li').last().find('.custom-description').html(converter.makeHtml(data.description));
      }
    });
    updateChallengeCount();
  });

  $('#challenges-list').delegate('.challenge-edit', 'click', function(e) {
    e.preventDefault();
    var $modal = $('#challenges-overlay .modal');
    var $challenge = $(this).parent('li');
    var index = $challenge.index();
    var challengeId = $challenge.find('input[name="character[character_has_challenges][][challenge_id]"]').val();
    var name = $challenge.find('input[name="character[character_has_challenges][][custom_name]"]').val();
    var description = $challenge.find('input[name="character[character_has_challenges][][custom_description]"]').val();
    var creature = $challenge.find('input[name="character[character_has_challenges][][is_creature_challenge]"]').val();

    $modal.find('#modal-custom-name').val(name);
    $modal.find('#modal-custom-description').text(description);
    if (creature == "true") {
      $modal.find('#modal-creature-challenge').prop("checked", "checked");
    } else {
      $modal.find('#modal-creature-challenge').removeProp("checked");
    }
    $modal.find('#modal-chc-id').val(index);

    $('#challenges-overlay').fadeIn().css("display", "flex");
  });

  $('#save-challenge').on('click', function(e) {
    var $modal = $('#challenges-overlay .modal');
    var name = $modal.find('#modal-custom-name').val();
    var description = $modal.find('#modal-custom-description').val();
    var challengeToUpdate = $modal.find('#modal-chc-id').val();
    var creature = $modal.find('#modal-creature-challenge').is(':checked');
    var $challenge = $('#challenges-list li:nth-child('+(parseInt(challengeToUpdate)+1)+')');
    // update both display and hidden field values
    var converter = new showdown.Converter();

    $challenge.find('.custom-name').text(name);
    $challenge.find('input[name="character[character_has_challenges][][custom_name]"]').val(name);
    $challenge.find('.description').html(converter.makeHtml(description));
    $challenge.find('input[name="character[character_has_challenges][][custom_description]"]').val(description);
    $challenge.find('input[name="character[character_has_challenges][][is_creature_challenge]"]').val(creature);
    $('.overlay').fadeOut();
    updateChallengeCount();
  });

  $('#cancel-challenge').on('click', function(e) {
    $('.overlay').fadeOut();
  });

  $('#challenges-list').delegate('.challenge-delete', 'click', function(e) {
    e.preventDefault();
    $(this).parent('li').detach();
    updateChallengeCount();
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

  $('#save-submit').on('click', function(e) {
    e.preventDefault();
    $('#character_status').val(1);
    console.log($('#character_status').val());
    $('form').submit();
  });
});
