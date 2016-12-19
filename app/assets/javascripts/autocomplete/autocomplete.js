let cards = []

$(document).ready(function(){
  const endpoint = '/api/v1/cards'
  const searchInput = document.querySelector('#select_origin');
  auto2("select_origin", cards, endpoint);
  searchInput.addEventListener('keyup', displayMatches);


  auto2 ("select_origin_mobile", cards, endpoint);
  // $( ".middle-search" ).click(function() {
  //   auto("select_origin_middle")
  // });
});

function auto2(div, cards, endpoint) {
  fetch(endpoint)
    .then(blob => blob.json())
    .then(data => cards.push(...data));
}

function findMatches(wordToMatch, cards) {
  return cards.filter(card => {
    const regex = new RegExp(wordToMatch, 'gi');
    return card.name.match(regex);
  })
}

function displayMatches () {
  if (this.value.length >= 2) {
    const matchArray = findMatches(this.value, cards);

    const html = matchArray.map(card => {
      const regex = new RegExp(this.value, 'gi');
      const cardName = card.name.replace(regex, `<span class=\"hl\">${this.value}</span>`)
      return `
        <li class="suggestion" data-id=${card.id}>
          <span>${cardName}</span>
        </li>

      `;
    }).join('');

    let suggestions = document.querySelector('.suggestions');
    suggestions.innerHTML = html;

    let suggestion = document.querySelectorAll('.suggestion')
    suggestion.forEach(sug => {
      sug.addEventListener('click', route);
    })



  } else if (this.value.length < 2) {
    let suggestions = document.querySelector('.suggestions');
    suggestions.innerHTML = null
  }
}

function route () {
  window.location.pathname = `cards/${this.dataset.id}`
}

// function enterKey (e) {
//   debugger;
//   if (e.keyCode === 13) {
//     route
//   }
// }



// ocument.querySelector('#txtSearch').addEventListener('keypress', function (e) {
//     var key = e.which || e.keyCode;
//     if (key === 13) { // 13 is enter
//       // code for enter
//     }
// });





// function auto(div) {
//   $('#' + div).autocomplete({
//     minLength: 2,
//     source: '/api/v1/search',
//     focus: function(event, ui) {
//       $('#select_origin').val(ui.item.name);
//       return false;
//     },
//     select: function(event, ui) {
//       $('#' + div).val(ui.item.name);
//         window.location.pathname = "cards/" + ui.item.id;
//     }
//   })
//   .data("uiAutocomplete")._renderItem = function(div, item) {
//     return $( "<div activetrigger'></div>")
//     .data( "item.autocomplete", item )
//     .append(item.name)
//     .appendTo( div );
//   };
// };
