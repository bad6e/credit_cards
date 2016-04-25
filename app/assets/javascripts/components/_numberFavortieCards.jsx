var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

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
          <ul className="quick-menu pull">
            <li key={id}>
              <a href={"/users/" + id} key={id}>
                <ReactCSSTransitionGroup
                  transitionName="example"
                  transitionLeaveTimeout={500}
                  transitionEnterTimeout={500}
                >
                  <div key={number}>{number} Favorite Cards</div>
                </ReactCSSTransitionGroup>

              </a>
            </li>
          </ul>
        </div>
      );
    }
  });
  ReactDOM.render(<NumberOfFavoriteCards flux={flux} currentUser={currentUser} />, document.getElementById('shit'));
}

 // return (
 //      <li key={key}>
 //        <CSSTransitionGroup
 //        component="span"
 //        transitionName="count"
 //        transitionLeaveTimeout={250}
 //        transitionEnterTimeout={250}
 //        >
 //          <span key={count}>{count}</span>
 //        </CSSTransitionGroup>

 //        lbs {fish.name} {removeButton}
 //        <span className="price">{h.formatPrice(count * fish.price)}</span>
 //      </li>
 //    )
 //  },