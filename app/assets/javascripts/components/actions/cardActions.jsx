var LoadCards = React.createClass({
  getInitialState : function () {
    return {
      cards: [],
      loaderImg: true
    };
  },

  componentDidMount: function () {
    this.loadCardsFromAPI();
  },

  loadCardsFromAPI: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (cards) {
        setTimeout(function() {
          this.setState(
            {
              cards: cards,
              loaderImg: false
            },
            this.sortCardsByDollarAmount()
          )
        }.bind(this), 800);
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  sortCardsByName : function() {
   var sortedCardsByName = _.sortBy(this.state.cards, function(o) { return o.name; })
   this.setState({ cards: sortedCardsByName })
  },

  sortCardsByAmount : function() {
    var sortedCardsByAmount = _.sortBy(this.state.cards, function(o) {
      if (o.rewards.length > 0) {
        return o.rewards[0].amount;
      } else if (o.rewards.length === 0) {
        return -1
      }
    })
    this.setState({ cards: sortedCardsByAmount.reverse() })
  },

  sortCardsByDollarAmount : function() {
    var sortedCardsByDollarAmount = _.sortBy(this.state.cards, function(o) {
      if (o.rewards.length > 0  &&  o.rewards[0].dollar_amount) {
        return o.rewards[0].dollar_amount;
      } else if (o.rewards.length > 0 && o.rewards[0].dollar_amount === 0) {
        return -1
      } else if (o.rewards.length > 0 && o.rewards[0].dollar_amount === null) {
        return -2
      } else if (o.rewards.length === 0) {
        return -3
      }
    })
    this.setState({ cards: sortedCardsByDollarAmount.reverse() })
  },

  removeFavoriteCardFromState : function(id) {
    var deletedCard = _.find(this.state.cards, function(o) { return o.id === id })
    var newCardState = _.remove(this.state.cards, function (card) { return card != deletedCard })
    this.setState({ cards: newCardState})
  },

  postFavoriteCard : function(id) {
    $.ajax({
      url: "api/v1/favorite_cards/" + id,
      dataType: 'json',
      type: 'PUT',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: id,
      success: function(data) {
        this.props.flux.actions.updateCardNumber();
        console.log(data);
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  removeFavoriteCard : function(id) {
    $.ajax({
      url: "/api/v1/favorite_cards/" + id,
      dataType: 'json',
      type: 'DELETE',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: id,
      success: function(data) {
        this.props.flux.actions.removeCardNumber();
        console.log(data)
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render : function () {
    const loadImg = this.state.loaderImg ?  <LoaderImg /> : null
    return (
      <div>
        { loadImg }
        <Cards key={1}
               cards={this.state.cards}
               postFavoriteCard={this.postFavoriteCard}
               removeFavoriteCard={this.removeFavoriteCard}
               sortCardsByName={this.sortCardsByName}
               sortCardsByAmount={this.sortCardsByAmount}
               sortCardsByDollarAmount={this.sortCardsByDollarAmount}
               apiUrl={this.props.url}
               removeFavoriteCardFromState={this.removeFavoriteCardFromState}
               currentUser={this.props.currentUser}
        />
      </div>
    );
  }
});

window.loadCardsFlux = function(url, currentUser) {
  var FluxMixin = Fluxxor.FluxMixin(React),
      StoreWatchMixin = Fluxxor.StoreWatchMixin;

  var CardActions = React.createClass({
    mixins: [Fluxxor.FluxMixin(React), StoreWatchMixin("FluxNumberOfFavoriteCardsStore")],

    getStateFromFlux: function() {
      var flux = this.getFlux();
      return flux.store("FluxNumberOfFavoriteCardsStore").getState();
    },

    render : function() {
      return (
        <div>
          <LoadCards url={this.props.url}
                     currentUser={this.props.currentUser}
                     flux={flux}
          />
        </div>
      )
    }
  });
  ReactDOM.render(<CardActions flux={flux} url={url} currentUser={currentUser}/>, document.getElementById('shitty'));
}

