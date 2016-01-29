$(document).ready(function(){
   // $('#loaderImg').hide();

  $(function(){
      $('#select_origin').autocomplete({
        minLength: 3,
        source: '/api/v1/search',
        focus: function(event, ui) {
          $('#select_origin').val(ui.item.name);
          return false;
        },
        select: function(event, ui) {
          // $( "#loaderImg" ).fadeIn(700)
          $('#select_origin').val(ui.item.name);
          $('#link_origin_id').val(ui.item.id);
            console.log(ui.item)
            // airportInformation(ui.item.id);
        }
      })
      .data("uiAutocomplete")._renderItem = function(div, item){
        return $( "<div activetrigger'></div>")
        .data( "item.autocomplete", item )
        .append(item.name)
        .appendTo( div );
      };
    });
});
