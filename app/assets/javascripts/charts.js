$(document).ready(function() {
  var creatureTypes = document.getElementById('creatureTypes');
  var creatureTypesChart = new Chart(creatureTypes, {
    type: 'pie',
    data: {
      labels: ["Witch", "Vampire", "Werewolf", "Demonblooded", "Other Creature", "Unnatural", "Human"],
      datasets: [
        {
          data: creatureTypesData,
          backgroundColor: ['#FF0000', '#00FF00', '#0000FF', '#FF00FF', '#FFFF00', '#00FFFF', '#000000']
        }
      ]
    }
  });

  var trueSelves = document.getElementById('trueSelves');
  var trueSelvesChart = new Chart(trueSelves, {
  type: 'pie',
  data: {
    labels: trueSelfLabels,
    datasets: [
      {
        data: trueSelfData,
        backgroundColor: ['#FF0000', '#00FF00', '#0000FF', '#FF00FF', '#00FFFF', '#FFFF00', '#660000', '#006600', '#000066', '#660066', '#006666', '#666600', '#990000', '#009900', '#000099']
      }
    ]
  }
});
});
