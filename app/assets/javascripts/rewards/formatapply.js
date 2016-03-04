function formatColors() {
  $( ".best-offer-color" ).each(function( index, element ) {
    $(element).show();
    if ($(element).text() === "n/a") {
      setColor(element, 'black');
    } else if ($(element).text() === "yes") {
      setColor(element, 'green');
    } else if ($(element).text() === "no") {
      setColor(element, 'red');
    } else if ($(element).text() === "ok") {
      setColor(element, '#BB9D40');
    }
  })
}

function setColor(element, color_code) {
  $(element).css({ 'color': color_code});
}

