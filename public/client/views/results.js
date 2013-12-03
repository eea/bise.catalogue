define([
    'jquery',
    'underscore',
    'backbone',
    'models/result',
    'text!template/result.html',
    'text!template/cells/article.html',
    'text!template/cells/document.html',
    'text!template/cells/link.html',
    'text!template/cells/species.html',
    'text!template/cells/habitat.html',
    'text!template/cells/site.html'
  ], function($, _, Backbone, Result, resultTemplate, art, doc, lnk, spc, hab, sit){

  var ResultView = Backbone.View.extend({

    model: Result,
    tagName:  "li",

    art_tmpl: _.template(art),
    doc_tmpl: _.template(doc),
    new_tmpl: '',
    lnk_tmpl: _.template(lnk),
    spc_tmpl: _.template(spc),
    hab_tmpl: _.template(hab),
    sit_tmpl: _.template(sit),

    template: _.template(resultTemplate),

    events: {
      "click a.title"     : "showResult",
    },

    initialize: function() {
      _.bindAll(this, 'render');

      this.model.bind('change', this.render, this);
      this.model.bind('destroy', this.remove, this);
    },

    formatDate: function(dateString){
      if (dateString.length == 10){
        var d = dateString.split('-')
        var dd = d[2]
        var mm = d[1]
        var yyyy = d[0]
        return dd+'/'+mm+'/'+yyyy
      } else {
        return '-'
      }
    },

    render: function() {
      var m = this.model.toJSON();

      if (m._type === "article"){
        m.published_on = this.formatDate(m.published_on)
        $(this.el).html(this.art_tmpl(m))
      } else if (m._type === "document"){
        m.published_on = this.formatDate(m.published_on)
        $(this.el).html(this.doc_tmpl(m))
      } else if (m._type === "link"){
        m.published_on = this.formatDate(m.published_on)
        $(this.el).html(this.lnk_tmpl(m))
      }
      else if (m._type === "species"){
        $(this.el).html(this.spc_tmpl(m))
      }
      else if (m._type === "protected_area"){
        $(this.el).html(this.sit_tmpl(m))
      }
      else if (m._type === "habitat"){
        $(this.el).html(this.hab_tmpl(m))
      }
      this.input = this.$('.cell');
      return this;
    },

    showResult: function(e){
      e.preventDefault()
      if (this.model.attributes._type === "document"){
        console.log('document previewing...')
      }
      if (this.model.attributes._type === "protected_area"){
        ifr = this.$el.find('iframe')
        data = {
          where: "N2K_WM_1M_Public.SITECODE='" + ifr.data('code') + "'",
          geometryType: 'esriGeometryEnvelope',
          spatialRel: 'esriSpatialRelIntersects',
          returnGeometry: true,
          returnIdsOnly: false,
          returnCountOnly: false,
          returnZ: false,
          returnM: false,
          returnDistinctValues: false,
          f: 'pjson'
        }
        $.ajax({
          url: "http://test.discomap.eea.europa.eu/arcgis/rest/services/N2K/Natura2000Query_WM/MapServer/3/query",
          data: data,
          dataType: 'json'
        }).done(function (data){
          hasGeometry = false
          if (data.features.length > 0){
            _.each( data.features, function (f){
              if (f.geometry.rings.length > 0){
                hasGeometry = true
              }
            })
          }
          console.log('hasGeometry')
          console.log(hasGeometry)
          if (hasGeometry)
            ifr.attr('src', "http://discomap.eea.europa.eu/map/Filtermap/?webmap=0b2680c2bc544431a9a97119aa63d707&SiteCode="+ifr.data('code')+"&autoquery=false&zoomto=true")
          else
            ifr.hide()
        }).fail(function (){
          ifr.hide()
        })
      }
      if (this.$el.find('.preview').length > 0){
        if (this.$el.find('.preview').css('display') == 'none'){
          $(this.el).parent().find('.preview').hide()
          $(this.el).find('.preview').show()
        }
        else
          $(this.el).find('.preview').hide()
      }
    },

    remove: function() {
      $(this.el).remove();
    },

    clear: function() {
      this.model.unbind('change', this.render, this)
      this.model.unbind('destroy', this.remove, this)
      this.model.destroy()
      this.remove()
    }

  });
  return ResultView;
});
