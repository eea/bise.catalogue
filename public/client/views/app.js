define(['jquery', 'underscore', 'backbone', 'bootstrap', 'collections/results', 'views/results', 'views/facet', 'text!template/main.html'],
  function($, _, Backbone, Bootstrap, ResultsCollection, ResultView, FacetView, mainTemplate){

  var AppView = Backbone.View.extend({

    host: null,
    el: $("#catalogue-app"),
    mainTemplate: _.template(mainTemplate),

    bise_indexes: {
      documents: 'Documents',
      links: 'Links',
      articles: 'Web Pages'
    },

    all_indexes: {
      documents: 'Documents',
      links: 'Links',
      articles: 'Webpages',
      species: 'Species',
      habitats: 'Habitats',
      protected_areas: 'Sites'
    },

    // Structure to query backend
    queryparams: {
      indexes: [],
      query: '',
      page: 1,
      per: 10
    },

    events: {
      "submit #catalogue-search-form"  : "fillQueryAndRun",
      // "change #catalogue-area"         : "setCategories",
      "click #catalogue-sort li a"     : "setSorting",
      "click #catalogue-per-page li a" : "setPerPage",
      "click .pager .p"                : "goPrevPage",
      "click .pager .n"                : "goNextPage",
      "click .switch .bise-search"     : "enableBiseSearch",
      "click .switch .advn-search"     : "enableAdvancedSearch"
    },

    initialize: function(options) {
      _.bindAll(this, 'addOne', 'addAll', 'render',
                'mergeFacet', 'removeFacet', 'isFacetSelected',
                'enableAdvancedSearch', 'enableBiseSearch')

      // Add main template
      $(this.$el.selector).append(this.mainTemplate)

      this.host = options['host']
      this.refreshEndpoint()

      // Retrieve data-query attr if present
      q = this.$el.data('query')
      if (q != 'undefined' && q != '') this.queryparams.query = q

      // Run QUERY by default
      this.queryparams.indexes = Object.keys(this.bise_indexes);
      this.runQuery()
    },

    getEndpoint: function(){
      if ($('#advanced-search').attr('checked') === 'checked'){
        this.url = 'http://' + this.host + '/api/v1/search'
      } else {
        this.url = 'http://' + this.host + '/api/v1/bise_search'
      }
      return this.url;
    },

    refreshEndpoint: function(){
      this.Results = new ResultsCollection(this.getEndpoint())
      this.Results.bind('add', this.addOne)
      this.Results.bind('reset', this.addAll)
      this.Results.bind('all', this.render)
    },

    fillQueryAndRun: function(e){
      console.log(':: fillQueryAndRun')
      e.preventDefault()
      var q = $('#catalogue-search-form #query').val()
      if (q=='') q = this.$('#catalogue-queries li').html()
      this.queryparams = {
        indexes: this._getSelectedCategories(),
        query: q.replace(/(<([^>]+)>)/ig,""),
        page: 1, per: 10
      }
      $('#catalogue-search-form input').val('')
      this.runQuery()
    },

    runQuery: function(){
      this.Results.fetch({ data: $.param(this.queryparams) })
    },

    // ----------------------- SEARCH OPTIONS ----------------------------------

    setSorting: function(e){
      this.queryparams.sort = $('#catalogue-sort select').val()
      this.runQuery()
    },
    setPerPage: function(e){
      this.queryparams.page = 1
      this.queryparams.per = parseInt($(e.target).html());
      this.runQuery()
      // this.Results.fetch({ data: $.param(this.queryparams) })
    },
    goPrevPage: function(e){
      if (this.queryparams.page > 1){
        this.queryparams.page -= 1;
        this.runQuery()
        // this.Results.fetch({ data: $.param(this.queryparams) })
      }
    },
    goNextPage: function(e){
      if (this.queryparams.page < this._getLastPage()){
        this.queryparams.page += 1;
        this.runQuery()
        // this.Results.fetch({ data: $.param(this.queryparams) })
      }
    },
    enableBiseSearch: function(e){
      var selected_in_bise = _.reject(this.queryparams.indexes, function(index){
        return _.contains(this.bise_indexes, index)
      });
      if (selected_in_bise.length == 0) selected_in_bise = Object.keys(this.bise_indexes)
      $('.advn-search').removeClass('selected')
      $(e.currentTarget).addClass('selected')
      $('#advanced-search').removeAttr('checked');
      $('#bise-search').attr('checked', 'checked');
      this.refreshEndpoint()
      this.runQuery()
    },
    enableAdvancedSearch: function(e){
      $('.bise-search').removeClass('selected')
      $(e.currentTarget).addClass('selected')
      $('#bise-search').removeAttr('checked');
      $('#advanced-search').attr('checked', 'checked');
      this.refreshEndpoint()
      this.runQuery()
    },


    // -------------------------- INTERNALS ----------------------------------

    _getSelectedCategories: function(){
      var array = _.map(this.$('#catalogue-categories input:checked'), function (x){
        return $(x).val()
      })
      if (_.isEmpty(array)) array = _.map(this.$('#catalogue-categories input'), function (x){
        return $(x).val()
      })
      return array
    },

    _drawPagination: function(){
      this.$el.find('.catalogue-status').html(this.queryparams.page + '/' + this._getLastPage())

      if (this.queryparams.page == 1) this.$('.p').parent().addClass('disabled')
      else this.$('.p').parent().removeClass('disabled')

      if (this.queryparams.page == this._getLastPage())
        this.$('.n').parent().addClass('disabled')
      else
        this.$('.n').parent().removeClass('disabled')
    },
    _getLastPage: function(){
      var pages = Math.floor(this.Results.total / this.queryparams.per)
      if (this.Results.total % this.queryparams.per > 0)
        pages += 1;
      return pages;
    },
    _drawSearches: function(){
      if (this.queryparams.query != ''){
        li = $('<li>').append(this.queryparams.query)
        this.$('#catalogue-queries ul').html(li)
      } else {
        this.$('#catalogue-queries ul').html('')
      }
    },
    _drawCount: function(){
      if (this.Results.total == undefined)
        this.$('#results-count').html("No search")
      else
        this.$('#results-count').html('<strong>' + this.Results.total + '</strong> results.')
    },
    _drawCategories: function(){
      this.$("#catalogue-categories").html('');

      var input;
      if ($('#advanced-search').attr('checked') === 'checked'){
        for (var k in this.all_indexes){
          var checked = _.contains(this.queryparams.indexes, k)
          if (this.queryparams.indexes.length == 0) checked = true;
          input = $('<input>').attr({
            type: 'checkbox',
            id:   k,
            name: k,
            value: k,
            checked: checked
          });
          this._addWrappedCategory(input, k)
        }
      } else {
        for (var k in this.bise_indexes){
          var checked = _.contains(this.queryparams.indexes, k)
          if (this.queryparams.indexes.length == 0) checked = true;
          input = $('<input>').attr({
            type: 'checkbox',
            id:   k,
            name: k,
            value: k,
            checked: checked
          })
          this._addWrappedCategory(input, k)
        }
      }
      this.$('#catalogue-categories input').on('change', $.proxy(this.fillQueryAndRun, this))
      // this.$('#catalogue-categories input').iCheck({
      //   checkboxClass: 'icheckbox_flat',
      //   radioClass: 'iradio_flat'
      // })
    },

    _addWrappedCategory: function(input, key){
      var label = $('<label>').append(input).append(this.all_indexes[key])
      // var inputWrapper = $('<div>');
      // inputWrapper.append(input).append($('<label>'));
      // inputWrapper.append(label);
      // this.$("#catalogue-categories").append(inputWrapper)
      this.$("#catalogue-categories").append(label).append('<br>')
      // this.$("#catalogue-categories").append(label).append($('<br>'))
    },

    _drawFacets: function(){
      // Clean facets
      this.$("#catalogue-facets").html('')
      // Draw facets
      if (this.Results.total > 0){
        facet_names = Object.keys(this.Results.facets)
        for (var i=0; i<facet_names.length; i++){
          title = facet_names[i]
          facet = this.Results.facets[title]
          if ((typeof(facet.terms) != 'undefined' &&
              facet.terms.length > 0) ||
              (typeof(facet.entries) != 'undefined' &&
              facet.entries.length > 0)){
            m = new Backbone.Model(facet)
            m.title = title

            var n = $('<div>').addClass('catalogue-facet '+title)
            this.$("#catalogue-facets").append(n)
            new FacetView({
              el: this.$('.catalogue-facet.'+title),
              model: m
            }).render()

            // var view = new FacetView({model: m})
            // this.$("#catalogue-facets").append(view.render().el)
          }
        }
      }
    },

    _showNoResults: function(){
      this.$('.catalogue-no-results').show()
      if (this.queryparams.query && this.queryparams.query.length > 0)
        this.$('.catalogue-no-results h1').html('No results found.')
      else
        this.$('.catalogue-no-results h1').html('')
      this.$('.catalogue-content').hide()
    },

    _showResults: function(){
      this.$('.catalogue-no-results').hide()
      this.$('.catalogue-content').show()
      this._drawPagination()
    },


    // ------------------------  FACETS ----------------------------------------

    mergeFacet: function(key, value){
      this.queryparams[key] = value
      this.queryparams['page'] = 1
      this.runQuery()
    },
    removeFacet: function(key) {
      delete this.queryparams[key];
      this.queryparams['page'] = 1
      this.runQuery()
    },
    isFacetSelected: function(key, value){
      if (_.has(this.queryparams, key))
        if (this.queryparams[key] == value)
          return true
      return false
    },

    // ------------------------  RENDER ----------------------------------------

    render: function() {
      this._drawSearches();
      this._drawCount();
      this._drawCategories();
      this._drawFacets();
      if (this.Results.total == 0) this._showNoResults(); else this._showResults();
    },
    addOne: function(result) {
      var view = new ResultView({model: result})
      this.$("#catalogue-results").append(view.render().el)
    },
    addAll: function() {
      this.$('#catalogue-results').html('')
      this.Results.each(this.addOne)
    }
  })
  return AppView
})
