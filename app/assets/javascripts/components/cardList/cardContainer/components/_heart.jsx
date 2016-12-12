var Heart = React.createClass({
  getInitialState: function () {
    return {
      empty: null
    };
  },

  handleChange: function (event) {
    if (event) {
      this.setState(
        { empty: 'heart' }, this.props.addFavoriteCard
      )
    }
  },

  render: function() {
    return(
      <svg className={this.state.empty || this.props.cssClass}
           onClick={this.handleChange}
           viewBox="-2 -2 35 33">
        <path d="M23.6,0c-3.4,0-6.3,2.7-7.6,5.6C14.7,2.7,11.8,0,8.4,0C3.8,0,0,3.8,0,8.4c0,9.4,9.5,11.9,16,21.2
                c6.1-9.3,16-12.1,16-21.2C32,3.8,28.2,0,23.6,0z"/>
      </svg>
    )
  }
})