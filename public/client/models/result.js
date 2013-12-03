define(['underscore', 'backbone'], function(_, Backbone) {

  var ResultModel = Backbone.Model.extend({

    idAttribute: "uri",

    // Default attributes for a result
    defaults: {
      _type                : "",
      _version             : null,
      author               : "",
      biographical_region  : null,
      content              : "",
      content_without_tags : "",
      created_at           : null,
      done                 : false,
      english_title        : null,
      highlight            : null,
      id                   : "0",
      language             : null,
      order                : 0,
      published            : null,
      published_on         : "",
      site_id              : 1,
      sort                 : null,
      source_url           : "",
      title                : "",
      updated_at           : ""
    },

    initialize: function() {

    }

  });
  return ResultModel;
});
