// $(document).ready(function(){
//   formatColors();
//   $( "#loaderImg" ).fadeIn(700)
//   grabCardId();
// })


// }



// function checkForShowTestEnv() {
//   if (window.location.hostname === "127.0.0.1") {
//     var id = $(".entry-title").attr('id');
//     getRewardData(id);
//   } else {
//     var id = $(".entry-title").attr('id');
//     getRewardData(id);
//   }
// }

// function getRewardData(id) {
//   $.ajax({
//     type: 'GET',
//     url: '/api/v1/rewards/' + id,
//     success: function(response){
//       $( "#loaderImg" ).hide();
//       checkIfResponseIsEmpty(response)
//     }
//   });
// }

// function checkIfResponseIsEmpty(response)  {
//   if (response.rewards.length === 0) {
//     hideAllRewardInformation();
//   } else {
//     checkWhatTypeOfRewardsArePresent(response);
//   }
// }

// function checkWhatTypeOfRewardsArePresent(response) {
//   if (allCentValuesAreNull(response.rewards)) {
//     showOnlyBonusInformation(response);
//   } else {
//     showBonusAndPointInformation(response);
//   }
//   checkIfCardHasEnoughRewards(response.rewards);
// }

// function allCentValuesAreNull(response) {
//   return _.every(response, ['cent_value', null])
// }
