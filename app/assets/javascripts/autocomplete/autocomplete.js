$(document).ready(function(){
  auto("select_origin");
  auto("select_origin_mobile");
  $( ".middle-search" ).click(function() {
    auto("select_origin_middle")
  });
});

function auto(div) {
  $('#' + div).autocomplete({
    minLength: 2,
    source: '/api/v1/search',
    focus: function(event, ui) {
      $('#select_origin').val(ui.item.name);
      return false;
    },
    select: function(event, ui) {
      $('#' + div).val(ui.item.name);
        window.location.pathname = "cards/" + ui.item.id;
    }
  })
  .data("uiAutocomplete")._renderItem = function(div, item) {
    return $( "<div activetrigger'></div>")
    .data( "item.autocomplete", item )
    .append(item.name)
    .appendTo( div );
  };
};
