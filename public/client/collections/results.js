define(['underscore', 'backbone', 'models/result'], function(_, Backbone, Result){

  var ResultsCollection = Backbone.Collection.extend({

    model: Result,
    url: '',

    initialize: function(host) {
      this.url = 'http://' + host + '/api/v1/bise_search'
    },

    parse: function(data) {
      this.total = data.total
      this.facets = data.facets

      return data.results;
    }

  })
  return ResultsCollection

});
