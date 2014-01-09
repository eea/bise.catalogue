define(['jquery', 'underscore', 'backbone', 'models/facet', 'text!template/facet.html'], function($, _, Backbone, Facet, facetTemplate){

  var FacetView = Backbone.View.extend({

    model: Facet,
    tagName:  "div",
    template: _.template(facetTemplate),

    titles: {
      site:                 'Source' ,
      author:               'Author',
      countries:            'Country',
      biographical_region:  'Biogeographical Region',
      languages:            'Language',
      source_db:            'Source Dataset',
      kingdom:              'Kingdom',
      phylum:               'Phylum',
      classis:              'Classis',
      species_group:        'Species Group',
      taxonomic_rank:       'Taxonomic Rank',
      genus:                'Genus',
      published_on:         'Timeline'
    },

    events: {
      "click .facet-link"         : "applyFilter",
      "click .facet-remove"       : "unapplyFilter"
    },

    initialize: function() {
      _.bindAll(this, 'render');
    },

    render: function() {
      $(this.el).html(this.template(this.model.toJSON()));
      return this;
    },

    applyFilter: function(e) {
      el =$(e.currentTarget)
      Catalogue.mergeFacet( el.data('facet'), el.data('value'))
    },

    unapplyFilter: function(e) {
      Catalogue.removeFacet(el.data('facet'))
    },

    titleFor: function(facet){
      return this.titles[facet]
    },

    remove: function() {
      $(this.el).remove();
    },

    clear: function() {
      this.model.unbind('change', this.render, this);
      this.model.unbind('destroy', this.remove, this);
      this.model.destroy();
      this.remove();
    }

  })
  return FacetView;
});
