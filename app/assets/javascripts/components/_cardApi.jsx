var CardList = React.createClass({
  determinePointRewardStatus : function(details) {
    return details && details.rewards && details.rewards.length
                        ? this.numberWithCommas(details.rewards[0].amount) : <div id="no-info">--</div>
  },

  determineDollarRewardStatus : function(details) {
    return details && details.rewards && details.rewards.length
                        ? this.dollarWithCommas(details.rewards[0].dollar_amount) : <div id="no-info">--</div>
  },

  numberWithCommas: function(number) {
    if (number > 0) {
      return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    } else if (number === 0) {
      return 0
    }
  },

  dollarWithCommas: function(number) {
    if (number > 0) {
      return "$" + number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    } else if (number === 0) {
      return "$" + 0
    }
  },

  determineBestOfferColor : function(bestOffer) {
    if (bestOffer === "yes") {
      return {color: 'green'}
    } else if (bestOffer === "no") {
      return {color: 'red'}
    } else if (bestOffer === "ok") {
      return {color: '#BB9D40'}
    } else {
      return {color: 'black'}
    }
  },

  renderCards: function(key) {
    if (this.props.apiUrl.indexOf("/users/") > -1 == "1"){
      return <FavoriteCard key= {this.props.cards[key].id}
                           details= {this.props.cards[key]}
                           postFavoriteCard={this.props.postFavoriteCard}
                           determinePointRewardStatus={this.determinePointRewardStatus}
                           determineDollarRewardStatus={this.determineDollarRewardStatus}
                           determineBestOfferColor={this.determineBestOfferColor}
                           removeFavoriteCard={this.props.removeFavoriteCard}
                           removeFavoriteCardFromState={this.props.removeFavoriteCardFromState}/>
    } else {
      return <Card key= {this.props.cards[key].id}
                   details= {this.props.cards[key]}
                   postFavoriteCard={this.props.postFavoriteCard}
                   determinePointRewardStatus={this.determinePointRewardStatus}
                   determineDollarRewardStatus={this.determineDollarRewardStatus}
                   determineBestOfferColor={this.determineBestOfferColor}
                   currentUser={this.props.currentUser}/>
    }
  },

  render : function() {
    return (
      <div>
        {Object.keys(this.props.cards).map(this.renderCards)}
      </div>
    );
  }
});

var LoadCards = React.createClass({
  getInitialState : function () {
    return { cards: [] };
  },

  componentDidMount: function () {
    this.loadCardsFromAPI();
  },

  loadCardsFromAPI: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (cards) {
        this.setState({cards : cards});
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
    var deletedCard = _.find(this.state.cards, function(o) { return o.id === id; })
    var newCardState = _.remove(this.state.cards, function (card) {
      return card != deletedCard
    })
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
    return (
      <div>
        <SortByName sortCardsByName={this.sortCardsByName}
                    sortCardsByAmount={this.sortCardsByAmount}
                    sortCardsByDollarAmount={this.sortCardsByDollarAmount}/>
        <CardList cards={this.state.cards}
                  postFavoriteCard={this.postFavoriteCard}
                  removeFavoriteCard={this.removeFavoriteCard}
                  apiUrl={this.props.url}
                  removeFavoriteCardFromState={this.removeFavoriteCardFromState}
                  currentUser={this.props.currentUser}/>
      </div>
    );
  }
});

window.loadCardsFlux = function(url, currentUser) {
  var FluxMixin = Fluxxor.FluxMixin(React),
      StoreWatchMixin = Fluxxor.StoreWatchMixin;

  var CardApi = React.createClass({
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
  ReactDOM.render(<CardApi flux={flux} url={url} currentUser={currentUser}/>, document.getElementById('shitty'));
}
