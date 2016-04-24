var constants = {
    UPDATE_NUMBER: "UPDATE_NUMBER"
};

var FluxNumberOfFavoriteCardsStore = Fluxxor.createStore({
  initialize: function() {
    $.ajax({
      type: "GET",
      url: "/api/v1/users/1/",
      success: function(data) {
        this.number = data.length
      }.bind(this),
      failure: function() {

      }
    });
    this.numbrer = 0
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
  FluxNumberOfFavoriteCardsStore: new FluxNumberOfFavoriteCardsStore()
};

var flux = new Fluxxor.Flux(stores, actions);

flux.on("dispatch", function(type, payload) {
  if (console && console.log) {
    console.log("[Dispatch]", type, payload);
  }
});
