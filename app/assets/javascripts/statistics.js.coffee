# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  if ( $('#tag-cloud').length > 0)
    $("#tag-cloud").jQCloud($("#tag-cloud").data('cloud'), {
      height: 340,
      shape: 'rectangular',
      click: ()->
        console.log("it works!");
    })
  return
