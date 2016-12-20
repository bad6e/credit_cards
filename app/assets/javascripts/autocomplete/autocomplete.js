//To Do's

//1. expire local storage
//2. Arrow keys down
//3. Styling form

let n = 0

window.onload = function() {
  checkLocalStorage();
}

function checkLocalStorage () {
  if (localStorage.cards) {
    addSearchEventListers();
  } else {
    autocomplete()
  }
}

function autocomplete () {
  fetch('/api/v1/card_names')
    .then(blob => blob.json())
    .then(data => localStorage.setItem('cards',
      JSON.stringify(Array.from(data))))
    .then(addSearchEventListers);
}

function addSearchEventListers () {
  const nonMobileSearchInput = document.querySelector('#select_origin');
  const mobileSearchInput = document.querySelector('#select_origin_mobile');
  const middleSearchInput = document.querySelector('#select_origin_middle');

  nonMobileSearchInput.addEventListener('keyup', displayMatches);
  nonMobileSearchInput.addEventListener('keydown', scrollCards);
  middleSearchInput.addEventListener('keyup', displayMatches);

  mobileSearchInput.addEventListener('keyup', displayMatches);
}

function displayMatches () {
  if (this.value.length >= 2) {
    const matchArray = findMatches(this.value,
      JSON.parse(localStorage.getItem('cards') || []));
    displayHtmlMatches(matchArray, this.value);
    setEventListeners();
  } else if (this.value.length < 2) {
    setHtml(null);
  }
}

function findMatches(wordToMatch, cards) {
  return cards.filter(card => {
    const regex = new RegExp(wordToMatch, 'gi');
    return card.name.match(regex);
  })
}

function route () {
  window.location.pathname = `cards/${this.dataset.id}`
}

function setHtml (html) {
  let suggestions = document.querySelectorAll('.card-suggestions');
    suggestions.forEach(sug => {
      sug.innerHTML = html;
  })

}

function setEventListeners () {
  let suggestion = document.querySelectorAll('.suggestion')
    suggestion.forEach(sug => {
      sug.addEventListener('click', route);
  })
}

function scrollCards (e) {
  if (e.keyCode === 40) {
    removeInputEventListner();
    let cardSuggestions = document.querySelectorAll('.suggestion');
    this.value = cardSuggestions[n].dataset.name;
    increaseNByOne(cardSuggestions.length);
  } else if (e.keyCode === 38) {
    removeInputEventListner();
    let cardSuggestions = document.querySelectorAll('.suggestion');
    this.value = cardSuggestions[n].dataset.name;
    decreaseNByOne();
  } else {
    const nonMobileSearchInput = document.querySelector('#select_origin');
    nonMobileSearchInput.addEventListener('keyup', displayMatches);
    n = 0
  }
}

function increaseNByOne (length) {
  if (n < length - 1) {
    n++
  }
}

function decreaseNByOne () {
  if (n > 0) {
    n--
  }
}

function removeInputEventListner () {
  const nonMobileSearchInput = document.querySelector('#select_origin');
  nonMobileSearchInput.removeEventListener('keyup', displayMatches);
}

function displayHtmlMatches(matchArray, wordTyped) {
  const html = matchArray.map(card => {
    const regex = new RegExp(wordTyped, 'gi');
    const cardName = card.name.replace(regex, `<span class=\"hl\">${wordTyped}</span>`)
      return `
        <li class="suggestion" data-id="${card.id}" data-name="${card.name}">
          <span>${cardName}</span>
        </li>
      `;
  }).join('');
  setHtml(html);
}
