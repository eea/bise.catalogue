define(['jquery', 'underscore', 'backbone', 'models/facet', 'text!template/facet.html'], function($, _, Backbone, Facet, facetTemplate) {

  var FacetView = Backbone.View.extend({

    model: Facet,
    //tagName: "div",
    template: _.template(facetTemplate),

    titles: {
      site: 'Source',
      author: 'Author',
      countries: 'Country',
      biographical_region: 'Biogeographical Region',
      languages: 'Language',
      source_db: 'Source Dataset',
      kingdom: 'Kingdom',
      phylum: 'Phylum',
      classis: 'Classis',
      species_group: 'Species Group',
      taxonomic_rank: 'Taxonomic Rank',
      genus: 'Genus',
      published_on: 'Timeline'
    },

    events: {
      "click .facet-link": "applyFilter",
      "click .facet-remove": "unapplyFilter"
    },

    initialize: function() {
      _.bindAll(this, 'render');

      // Add the node, and link the element
      // var parent = options['parent']
      // $(parent).append($('<div class="catalogue-facet">').addClass(this.model.title))
      // var tmp = parent + ' > .' + this.model.title
      //this.el = options['el']

    },

    render: function() {
      console.log($(this.el));
      $(this.el).html(this.template(this.model.toJSON()));
      // this.delegateEvents()
      return this;
    },

    applyFilter: function(e) {
      console.log('apply filter...')
      el = $(e.currentTarget)
      Catalogue.mergeFacet(el.data('facet'), el.data('value'))
    },

    unapplyFilter: function(e) {
      el = $(e.currentTarget)
      Catalogue.removeFacet(el.data('facet'))
    },

    titleFor: function(facet) {
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