window.loadNumberOfFavoriteCards = function() {
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
      return (
        <div>
          <ul className="quick-menu pull-left">
            <li><a href="/">{number} Favorite Cards</a></li>
          </ul>
        </div>
      );
    }
  });
  ReactDOM.render(<NumberOfFavoriteCards flux={flux} />, document.getElementById('shit'));
}
