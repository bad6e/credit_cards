var LoadFavoriteIds = React.createClass({
  getInitialState : function () {
    return { ids: [] };
  },

  componentDidMount: function () {
    this.loadCardsFromAPI();
  },

  loadCardsFromAPI: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (ids) {
        this.setState({ids : ids}, function(){

        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  postFavoriteCard : function(id) {
    $.ajax({
      url: "/api/v1/favorite_cards/" + id,
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

  render : function () {
    return (
      <div>
        <FavButton ids={this.state.ids}
                   cardId={this.props.cardId}
                   currentUser={this.props.currentUser}
                   postFavoriteCard={this.postFavoriteCard}/>
      </div>
    )
  }
});

window.loadFavButtonFromFlux = function(url, currentUser, cardId) {
  var FluxMixin = Fluxxor.FluxMixin(React),
      StoreWatchMixin = Fluxxor.StoreWatchMixin;

  var FavoriteButton = React.createClass({
    mixins: [Fluxxor.FluxMixin(React), StoreWatchMixin("FluxNumberOfFavoriteCardsStore")],

    getStateFromFlux: function() {
      var flux = this.getFlux();
      return flux.store("FluxNumberOfFavoriteCardsStore").getState();
    },

    render : function() {
      return (
        <div>
          <LoadFavoriteIds url={this.props.url}
                           currentUser={currentUser}
                           cardId={cardId}
                           flux={flux}
           />
        </div>
      )
    }
  });
  ReactDOM.render(<FavoriteButton flux={flux} url={url} currentUser={currentUser} cardId={cardId}/>, document.getElementById('favorite-button'));
}

window.loadFavButtonFromFlux1 = function(url, currentUser, cardId) {
  var FluxMixin = Fluxxor.FluxMixin(React),
      StoreWatchMixin = Fluxxor.StoreWatchMixin;

  var FavoriteButton = React.createClass({
    mixins: [Fluxxor.FluxMixin(React), StoreWatchMixin("FluxNumberOfFavoriteCardsStore")],

    getStateFromFlux: function() {
      var flux = this.getFlux();
      return flux.store("FluxNumberOfFavoriteCardsStore").getState();
    },

    render : function() {
      return (
        <div>
          <LoadFavoriteIds url={this.props.url}
                           currentUser={currentUser}
                           cardId={cardId}
                           flux={flux}
           />
        </div>
      )
    }
  });
  ReactDOM.render(<FavoriteButton flux={flux} url={url} currentUser={currentUser} cardId={cardId}/>, document.getElementById('favorite-button-1'));
}
