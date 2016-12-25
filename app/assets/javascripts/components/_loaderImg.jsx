var LoaderImg = React.createClass({
  getInitialState: function () {
    const sampleLoaderImg = ["https://s3.amazonaws.com/card-facebook-images/airplane.gif",
                             "https://s3.amazonaws.com/toomanymiles-svgs/briefcase_2.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/credit-card.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/hospital-bed.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/landmark.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/island.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/dollar-bill.svg",
                             "https://s3.amazonaws.com/toomanymiles-svgs/airplane.svg"]
    return {
      oneSampleLoaderImg: sampleLoaderImg[Math.floor(Math.random() * sampleLoaderImg.length)]
    };
  },

  render: function() {
    return(
      <div className='loading-animation-overlay'>
        <div className='loading-animation-container'>
          <img alt="" id="loader-img-plane" src={this.state.oneSampleLoaderImg} />
          <p className="loading-cards-text">Loading your { this.props.object }...</p>
        </div>
      </div>
    )
  }
})
