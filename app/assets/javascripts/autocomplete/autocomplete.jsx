(() => {
  let n = 0;
  let valueTyped = '';

  const ONE_DAY = 1000 * 60 * 60 *24

  window.onload = function() {
    checkForLocalStorage();
  }

  function checkForLocalStorage () {
    localStorage.cards && localStorage.time ? checkTimeStamp() : autocomplete();
  }

  function checkTimeStamp () {
    const savedTime = JSON.parse(localStorage.getItem('time')).timestamp;
    const currentTime = new Date().getTime();
    compareTime(savedTime, currentTime);
  }

  function compareTime (savedTime, currentTime) {
    if (currentTime > savedTime + ONE_DAY) {
      autocomplete();
    } else {
      addSearchEventListers();
    }
  }

  function autocomplete () {
   $.ajax({
      url: '/api/v1/card_names',
      dataType: 'json',
      success: function (data) {
        saveToLocalStorage(data);
      }.bind(this),
      error: function (xhr, status, err) {
        console.error('api/v1/card_names', status, err.toString());
      }.bind(this)
    });
  }

  function saveToLocalStorage (data) {
    localStorage.setItem('cards', JSON.stringify(Array.from(data)))
    const time = { timestamp: new Date().getTime() }
    localStorage.setItem('time', JSON.stringify(time));
    addSearchEventListers();
  }

  function addSearchEventListers () {
    const nonMobileSearchInput = document.querySelector('#select_origin');
    const mobileSearchInput = document.querySelector('#select_origin_mobile');

    nonMobileSearchInput.addEventListener('keyup', displayMatches);
    nonMobileSearchInput.addEventListener('keydown', checkIfUsingArrowKeys);

    mobileSearchInput.addEventListener('keyup', displayMatches);
  }

  function displayMatches (e) {
    valueTyped = this.value;

    e.preventDefault();
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
      return card[1].match(regex);
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

  function setBackgroundColor (suggestions, color) {
    if (n > 0) {
      suggestions[n - 1].style.background = color;
    }
  }

  function removeBackgroundColorDown (suggestions) {
    suggestions.forEach((sug, idx)=> {
      if (idx != (n - 1)) {
        sug.style.background = null;
      }
    });
  }

  function removeBackgroundColorUp (suggestions) {
    suggestions.forEach((sug, idx)=> {
      if (idx != (n - 1)) {
        sug.style.background = null;
      }
    });
  }

  function updateBackgroundColorDown(cardSuggestions) {
   if (n > 0) {
      setBackgroundColor(cardSuggestions, '#D3D3D3');
      removeBackgroundColorDown(cardSuggestions);
    }
  }

  function updateBackgroundColorUp(cardSuggestions) {
    if (n >= 0) {
      setBackgroundColor(cardSuggestions, '#D3D3D3');
      removeBackgroundColorUp(cardSuggestions);
    }
  }

  function checkIfUsingArrowKeys (e) {
    if (e.keyCode === 40 || e.keyCode === 38) {
      e.preventDefault();
      scrollCardsWithArrows(e);
    }

    else if (e.keyCode === 27) {
      this.value = null;
      addInputEventListener();
    } else {
      addInputEventListener();
      n = 0;
    }
  }

  function scrollCardsWithArrows (e) {
    removeInputEventListner();
    const cardSuggestions = document.querySelectorAll('.suggestion');
    const suggestions = Array.from(cardSuggestions)
                         .slice(0, cardSuggestions.length/2)

    if (e.keyCode === 40) {
      increaseNByOne(suggestions.length);
      setInputValue(e.target, suggestions);
      updateBackgroundColorDown(suggestions);
    } else {
      decreaseNByOne();
      setInputValue(e.target,suggestions);
      updateBackgroundColorUp(suggestions)
    }
  }

  function setInputValue (target, suggestions)  {
    console.log(n)
    if (n > 0) {
      target.value = suggestions[n - 1].dataset.name;
    } else {
      target.value = valueTyped;
    }
  }

  function increaseNByOne (length) {
    n < length ? n++ : null;
  }

  function decreaseNByOne () {
    n > 0 ? n-- : null;
  }

  function removeInputEventListner () {
    const nonMobileSearchInput = document.querySelector('#select_origin');
    nonMobileSearchInput.removeEventListener('keyup', displayMatches);
  }

  function addInputEventListener () {
    const nonMobileSearchInput = document.querySelector('#select_origin');
    nonMobileSearchInput.addEventListener('keyup', displayMatches);
  }

  function displayHtmlMatches(matchArray, wordTyped) {
    const html = matchArray.map(card => {
      const regex = new RegExp(wordTyped, 'gi');
      const cardName = card[1].replace(regex, `<span class=\"hl\">${wordTyped}</span>`);
        return `
          <li class="suggestion" data-id="${card.id}" data-name="${card[1]}">
            <span>${cardName}</span>
          </li>
        `;
    }).join('');
    setHtml(html);
  }
}())