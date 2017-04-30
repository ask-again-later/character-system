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

  function updateAttributes() {
    var mentals = parseInt($('input[name="character[intelligence]"]:checked').val()) + parseInt($('input[name="character[wits]"]:checked').val()) + parseInt($('input[name="character[resolve]"]:checked').val()) - 3;
    var physicals = parseInt($('input[name="character[strength]"]:checked').val()) + parseInt($('input[name="character[dexterity]"]:checked').val()) + parseInt($('input[name="character[stamina]"]:checked').val()) - 3;
    var socials = parseInt($('input[name="character[presence]"]:checked').val()) + parseInt($('input[name="character[manipulation]"]:checked').val()) + parseInt($('input[name="character[composure]"]:checked').val()) - 3;
    var errors = [];

    // general error validation
    if (mentals > 6) {
      $('#mental-count').text((6-mentals)+" Remaining").addClass('warn').removeClass('hidden');
    } else {
      $('#mental-count').addClass('hidden');
    }
    if (physicals > 6) {
      $('#physical-count').text((6-physicals)+" Remaining").addClass('warn').removeClass('hidden');
    } else {
      $('#physical-count').addClass('hidden');
    }
    if (socials > 6) {
      $('#social-count').text((6-socials)+" Remaining").addClass('warn').removeClass('hidden');
    } else {
      $('#social-count').addClass('hidden');
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
      if (primary_val >= 6) {
        // configuration should be 6/4/3
        if (primary_val > 6) {
          $('#'+primary_name+"-count").removeClass('hidden').addClass('warn').text((6 - primary_val)+" Remaining");
        } else {
          $('#'+primary_name+"-count").addClass('hidden');
        }
        if (secondary_val > 4) {
          $('#'+secondary_name+"-count").removeClass('hidden').addClass('warn').text((4 - secondary_val)+" Remaining");
        } else if (secondary_val < 4) {
          $('#'+secondary_name+"-count").removeClass('hidden').removeClass('warn').text((4 - secondary_val)+ "Remaining");
        } else {
          $('#'+secondary_name).addClass('hidden');
        }
        if (tertiary_val > 3) {
          $('#'+tertiary_name+"-count").removeClass('hidden').addClass('warn').text((3-tertiary_val)+" Remaining");
        } else if (tertiary_val < 3) {
          $('#'+tertiary_name+"-count").removeClass('hidden').removeClass('warn').text((3-tertiary_val)+" Remaining");
        } else {
          $('#'+tertiary_name+"-count").addClass('hidden');
        }
      } else {
        if (secondary_val === 5) {
          // configuration should be 5/5/3
          if (secondary_val > 5) {
            $('#'+secondary_name+"-count").removeClass('hidden').addClass('warn').text((5 - secondary_val)+" Remaining");
          } else if (secondary_val < 5) {
            $('#'+secondary_name+"-count").removeClass('hidden').removeClass('warn').text((5 - secondary_val)+" Remaining");
          } else {
            $('#'+secondary_name+"-count").addClass('hidden');
          }
          if (tertiary_val > 3) {
            $('#'+tertiary_name+"-count").removeClass('hidden').addClass('warn').text((3-tertiary_val)+" Remaining");
          } else if (tertiary_val < 3) {
            $('#'+tertiary_name+"-count").removeClass('hidden').removeClass('warn').text((3-tertiary_val)+" Remaining");
          } else {
            $('#'+tertiary_name+"-count").addClass('hidden');
          }
        } else {
          // configuration should be 5/4/4
          if (secondary_val > 4) {
            $('#'+secondary_name+"-count").removeClass('hidden').addClass('warn').text((4 - secondary_val)+" Remaining");
          } else if (secondary_val < 4) {
            $('#'+secondary_name+"-count").removeClass('hidden').removeClass('warn').text((4 - secondary_val)+" Remaining");
          }
          if (tertiary_val > 4) {
            $('#'+tertiary_name+"-count").removeClass('hidden').addClass('warn').text((4 - tertiary_val)+" Remaining");
          } else if (tertiary_val < 4) {
            $('#'+tertiary_name+"-count").removeClass('hidden').removeClass('warn').text((4 - tertiary_val)+" Remaining");
          } else {
            $('#'+tertiary_name+"-count").addClass('hidden');
          }
        }
      }
    }
  }

  updateAttributes();

  function updateSkillsTrainingCount() {
    var count = 0;
    var $indicator = $('#skills-total');
    $('.skills-training input:checked').each(function() {
      count += parseInt($(this).val());
    });
    $indicator.text((22-count)+" Remaining");
    if (count > 22) {
      $indicator.addClass('warn');
    } else {
      $indicator.removeClass('warn');
    }
  }

  updateSkillsTrainingCount();

  function updateSpecialTrainingCount() {
    var count = 0;
    var $indicator = $('#special-training');
    $('.special-training input:checked').each(function() {
      count += parseInt($(this).val());
    });
    $indicator.text((8-count)+" Remaining");
    if (count > 8) {
      $indicator.addClass('warn');
    } else {
      $indicator.removeClass('warn');
    }
  }

  updateSpecialTrainingCount();

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
    if (count > 2) {
      $indicator.addClass('warn');
    } else {
      $indicator.removeClass('warn');
    }
  }

  updateChallengeCount();

  function updateCreatureChallengeCount() {
    var count = $('#challenges-list li[data-creature="true"]').length;
    var $indicator = $('#creature-challenge-count');
    $indicator.text((1-count)+" Creature Challenges Remaining");
    if (count > 1) {
      $indicator.addClass('warn');
    } else {
      $indicator.removeClass('warn');
    }
  }

  updateCreatureChallengeCount();

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

    $('ul#challenges-list').append('<li data-challenge-id="'+challengeId+'" data-creature="true"><span class="custom-name">'+name+'</span> <a href="#" class="challenge-delete"><i class="fa fa-minus-circle"></i></a><div class="description"></div><input type="hidden" name="character[character_has_challenges][][id]" value="" /><input type="hidden" name="character[character_has_challenges][][challenge_id]" value="'+challengeId+'" /><input type="hidden" name="character[character_has_challenges][][custom_description]" value="" /><input type="hidden" name="character[character_has_challenges][][custom_name]" value="" /><input type="hidden" name="character[character_has_challenges][][is_creature_challenge]" value="true" /></li>');

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
    updateCreatureChallengeCount();
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
    updateCreatureChallengeCount();
  });

  $('#challenges-list').delegate('.challenge-edit', 'click', function(e) {
    e.preventDefault();
    var $modal = $('#challenges-overlay .modal');
    var $challenge = $(this).parents('li');
    var index = $challenge.index();
    var challengeId = $challenge.find('input[name="character[character_has_challenges][][challenge_id]"]').val();
    var name = $challenge.find('input[name="character[character_has_challenges][][custom_name]"]').val();
    var description = $challenge.find('input[name="character[character_has_challenges][][custom_description]"]').val();
    var creature = $challenge.find('input[name="character[character_has_challenges][][is_creature_challenge]"]').val();

    $modal.find('#modal-custom-name').val(name);
    $modal.find('#modal-custom-description').val(description);
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
    $challenge.attr('data-creature', creature);
    $('.overlay').fadeOut();
    updateChallengeCount();
    updateCreatureChallengeCount();
  });

  $('#cancel-challenge').on('click', function(e) {
    $('.overlay').fadeOut();
  });

  $('#challenges-list').delegate('.challenge-delete', 'click', function(e) {
    e.preventDefault();
    $(this).parent('li').detach();
    updateChallengeCount();
  });

  $('.dot').on('click', function() {
    $(this).addClass('selected');
    $(this).prevAll().addClass('selected');
    $(this).nextAll().removeClass('selected');
    $(this).find('input').prop('checked', 'checked');
    updateSkillsTrainingCount();
    updateSpecialTrainingCount();
    updateAttributes();
  });

  $('#save-submit').on('click', function(e) {
    e.preventDefault();
    $('#character_status').val(1);
    console.log($('#character_status').val());
    $('form').submit();
  });
});
