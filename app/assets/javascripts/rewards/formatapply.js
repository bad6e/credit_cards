function formatColors() {
  $( ".best-offer-color" ).each(function( index, element ) {
    console.log("HI Momo")
    if ($(element).text() === "n/a") {
      $( ".loader-small-category" ).fadeOut(700)
      $(element).show();
      $(element).css({ 'color': 'black'});
    } else if ($(element).text() === "yes") {
       $(element).show();
      $(element).css({ 'color': 'green'});
    } else if ($(element).text() === "no") {
       $(element).show();
      $(element).css({ 'color': 'red'});
    }
  })
}

