# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $('a.btn').click ()->
    $(this).removeClass('active')
    return

  $('a.btn.back').click ()->
    window.history.back()
    return false
