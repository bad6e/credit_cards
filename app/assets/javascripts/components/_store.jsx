function getIdeas() {
  var beginNumber = $.getJSON('/api/v1/users/1', function(response){
    if (response[0]) {
      response[0]. favorite_card_ids.length
    }
  });
}

var constants = {
    UPDATE_NUMBER: "UPDATE_NUMBER"
};

var FluxNumberOfFavoriteCardsStore = Fluxxor.createStore({
  initialize: function(startNumber) {
    this.number = startNumber
    this.bindActions(
      constants.UPDATE_NUMBER, this.onNumberUpdate
    );
  },

  onNumberUpdate: function(payload) {
    var n = this.number
    this.number = n + payload.number
    this.emit("change")
  },

  getState: function() {
    return {
      number: this.number,
    };
  }
});

var actions = {
  updateCardNumber: function() {
    this.dispatch(constants.UPDATE_NUMBER, {number: 1});
  }
};

var stores = {
  FluxNumberOfFavoriteCardsStore: new FluxNumberOfFavoriteCardsStore(19)
};

var flux = new Fluxxor.Flux(stores, actions);

flux.on("dispatch", function(type, payload) {
  if (console && console.log) {
    console.log("[Dispatch]", type, payload);
  }
});
