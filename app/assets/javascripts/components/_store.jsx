var constants = {
    UPDATE_NUMBER: "UPDATE_NUMBER",
    REMOVE_NUMBER: "REMOVE_NUMBER"
};

var FluxNumberOfFavoriteCardsStore = Fluxxor.createStore({
  initialize: function() {
    $.ajax({
      url: "/api/v1/users/1",
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        if (data && data.meta) {
          this.number = data.meta.favorite_card_ids.length;
          this.emit("change");
        }
      }.bind(this),
      error: function(xhr, status, err) {

      }.bind(this)
    });

    this.number = 0;
    this.bindActions(
      constants.UPDATE_NUMBER, this.onNumberUpdate,
      constants.REMOVE_NUMBER, this.onNumberRemoval
    );
  },

  onNumberUpdate: function(payload) {
    var n = this.number
    this.number = n + payload.number
    this.emit("change")
  },

  onNumberRemoval: function(payload) {
    var n = this.number
    this.number = n - payload.number
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
  },

  removeCardNumber: function() {
    this.dispatch(constants.REMOVE_NUMBER, {number: 1})
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
