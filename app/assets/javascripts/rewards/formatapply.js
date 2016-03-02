function formatColors() {
  $( ".best-offer-color" ).each(function( index, element ) {
    console.log("HI Momo")
    if ($(element).text() === "n/a") {
      console.log(element)
      $(element).show();
      $(element).css({ 'color': 'black'});
    } else if ($(element).text() === "yes") {
      console.log(element)
       $(element).show();
      $(element).css({ 'color': 'green'});
    } else if ($(element).text() === "no") {
      console.log(element)
       $(element).show();
      $(element).css({ 'color': 'red'});
    }
  })
}

