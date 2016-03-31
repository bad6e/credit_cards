var SearchResults = React.createClass({
  loadSearchCards : function() {

  },

  getInitialState:function(){
    return{
      value:'My Value'
    }
  },

  render:function(){
    return (
      <div>
        <SearchForm loadSearchCards={this.loadSearchCards}/>
      </div>
    );
  }
});

var SearchForm = React.createClass({
  searchCards : function(event) {
    event.preventDefault();
    var searchTerm = {
      searchTerm : this.refs.term.value,
    }
    this.props.searchCards(searchTerm);
    this.refs.searchForm.reset();
  },

  render : function() {
    return (
      <form method="get" acceptCharset="UTF-8" ref="searchForm" id="search-form" role="search" className="quick-search" onSubmit={this.searchCards}>
        <div className="with-icon">
          <input type="text" name="search" ref="term" className="input-text search-input" id="select_origin" placeholder="Search for Credit Cards" />
          <button className="icon" id="search-button" type="button submit"><i className="soap-icon-search"></i></button>
        </div>
      </form>
    )
  }
});




