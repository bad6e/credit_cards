function formatColors() {
  $( ".best-offer-color" ).each(function( index, element ) {
    $(element).show();
    $(element)
    if ($(element).text() === "n/a") {
      setColor(element, 'black');
    } else if ($(element).text().replace(/ /g,'') === "yes") {
      setColor(element, 'green');
    } else if ($(element).text().replace(/ /g,'') === "no") {
      setColor(element, 'red');
    } else if ($(element).text().replace(/ /g,'') === "ok") {
      setColor(element, '#BB9D40');
    }
  })
}

function setColor(element, color_code) {
  $(element).css({ 'color': color_code});
}




