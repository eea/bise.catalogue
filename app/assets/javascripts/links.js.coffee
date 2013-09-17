# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
    $('#link_published_on').datepicker({ dateFormat: 'dd/mm/yy' })

    $('#link_language_ids').chosen({
        width: '100%'
    })
