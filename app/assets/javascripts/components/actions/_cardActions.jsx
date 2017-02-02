var LoadCards = React.createClass({
  getInitialState : function () {
    return {
      cards: [],
      favIds: [],
      searchTerm: '',
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
              cards: cards.cards,
              favIds: cards.meta.favorite_card_ids,
              searchTerm: cards.meta.search_term,
              loaderImg: false
            }
          )
        }.bind(this), 500);
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
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

  removeFavoriteCardFromState : function(id) {
    var deletedCard = _.find(this.state.cards, function(o) { return o.id === id })
    var newCardState = _.remove(this.state.cards, function (card) { return card != deletedCard })
    this.setState({ cards: newCardState })
  },

  render : function () {
    const loadImg = this.state.loaderImg ?  <LoaderImg object={ "cards" } /> : null

    return (
      <div>
        { loadImg }
        <Cards
          key={1}
          cards={this.state.cards}
          searchTerm={this.state.searchTerm}
          favIds={this.state.favIds}
          postFavoriteCard={this.postFavoriteCard}
          removeFavoriteCard={this.removeFavoriteCard}
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
