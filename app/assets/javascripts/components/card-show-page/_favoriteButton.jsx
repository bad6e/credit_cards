var FavoriteButton = React.createClass({
  render : function() {
    return (
      <div>
        <LoadFavoriteIds url={this.props.url} currentUser={this.props.currentUser} cardId={this.props.id} />
      </div>
    )
  }
});

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
        this.setState({ids : ids});
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

var FavButton = React.createClass({
  onButtonClick : function() {
    var id = this.props.cardId
    document.getElementById("favorite-button-side").text="FAVORITED!";
    document.getElementById("favorite-button-side").style.backgroundColor="#e9b02b"
    this.props.postFavoriteCard(id);
  },

  checkIfFavoriteCard : function() {
    var id = this.props.cardId
    var favoriteCardIds = this.props.ids
    if (_.includes(favoriteCardIds, id)) {
      return <a className="button yellow full-width uppercase btn-small" id="favorite-button-side" onClick={this.onButtonClick}>FAVORITED!</a>
    } else {
      return <a className="button green full-width uppercase btn-small" id="favorite-button-side" onClick={this.onButtonClick}>FAVORITE CARD</a>
    }
  },

  render : function() {
    var hasCurrentUser = (this.props.currentUser != null ? true : false);
    var buttonOptions = this.checkIfFavoriteCard();
    var buttonText = (hasCurrentUser ?  buttonOptions : <a href="#" className="button sky-blue1 full-width uppercase btn-small active soap-popupbox" data-target="#travelo-login">Login to Favorite</a>);
    return (
      <div>
        {buttonText}
      </div>
    )
  }
 });