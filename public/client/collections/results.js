define(['underscore', 'backbone', 'models/result'], function(_, Backbone, Result){

  var ResultsCollection = Backbone.Collection.extend({

    model: Result,
    url: '',

    initialize: function(url) {
      this.url = url;
    },

    parse: function(data) {
      this.total = data.total
      this.facets = data.facets

      return data.results;
    }

  })
  return ResultsCollection

});
