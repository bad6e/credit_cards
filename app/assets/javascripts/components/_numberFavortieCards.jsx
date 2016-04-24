window.loadNumberOfFavoriteCards = function(currentUser) {
  var FluxMixin = Fluxxor.FluxMixin(React),
      StoreWatchMixin = Fluxxor.StoreWatchMixin;

  var NumberOfFavoriteCards = React.createClass({
    mixins: [Fluxxor.FluxMixin(React), StoreWatchMixin("FluxNumberOfFavoriteCardsStore")],

    getStateFromFlux: function() {
      var flux = this.getFlux();
      return flux.store("FluxNumberOfFavoriteCardsStore").getState();
    },

    render: function() {
      var number = this.props.flux.stores.FluxNumberOfFavoriteCardsStore.number;
      var id = this.props.currentUser
      return (
        <div>
          <ul className="quick-menu pull-left">
            <li><a href={"/users/" + id} >{number} Favorite Cards</a></li>
          </ul>
        </div>
      );
    }
  });
  ReactDOM.render(<NumberOfFavoriteCards flux={flux} currentUser={currentUser} />, document.getElementById('shit'));
}
