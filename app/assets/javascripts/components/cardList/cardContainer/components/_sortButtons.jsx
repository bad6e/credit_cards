var SortByName = React.createClass({
  getInitialState: function () {
    return {
      selectedOption: 'bonus-in-dollars',
      loaderImg: false
    };
  },

  handleChange(event) {
    if (event && event.target.value) {
      this.setState({ loaderImg: true })
      this.determineSorter(event.target.value);
    }
  },

  determineSorter: function(event) {
    if (event == 'bonus-in-dollars') {
      this.props.sortCardsByDollarAmount();
    } else if (event== 'bonus-in-points') {
      this.props.sortCardsByAmount();
    } else {
      this.props.sortCardsByName();
    }
    setTimeout(function() { this.setState({loaderImg: false}); }.bind(this), 750);
  },

  render: function() {
    const loadImg = this.state.loaderImg ?  <LoaderImg /> : null
    return (
      <div>
        { loadImg }
        <div className="sort-by-section clearfix box" id="sorter-box">
          <h4 className="sort-by-title block-sm">Sort By:</h4>
          <select key="input" ref="input" name="sort-buttons" value={this.state.value} onChange={this.handleChange}>
            <option value="bonus-in-dollars">Bonus in Dollars</option>
            <option value="bonus-in-points">Bonus in Points</option>
            <option value="card-name">Card Name</option>
          </select>
        </div>
      </div>
    )
  }
})

var LoaderImg = React.createClass({
  getInitialState: function () {
    return {
      show: true
    };
  },

  render: function() {
    const sampleLoaderImg = ["https://s3.amazonaws.com/card-facebook-images/airplane.gif",
                             "https://s3.amazonaws.com/toomanymiles-svgs/briefcase_2.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/credit-card.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/hospital-bed.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/landmark.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/island.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/dollar-bill.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/airplane.svg"]
    let oneSampleLoaderImg = sampleLoaderImg[Math.floor(Math.random() * sampleLoaderImg.length)];
    return(
      <div className='loading-animation-overlay'>
        <div className='loading-animation-container'>
          <img alt="" id="loader-img-plane" src={oneSampleLoaderImg} />
          <p className="loading-cards-text">Loading your cards...</p>
        </div>
      </div>
    )
  }
})
