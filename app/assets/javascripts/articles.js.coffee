# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  $('#article_language_ids').chosen({
      width: '100%'
  })
  $('#article_published_on').datepicker({ dateFormat: 'dd/mm/yy' })


  # ----------------- SEARCH CONCEPTS
  $("input[name=search]").keyup( (e) ->
      match = $(this).val()
      if(e && e.which == $.ui.keyCode.ESCAPE || $.trim(match) == "" )
          $('a#reset').click()
          return
      n = window.tree.applyFilter(match)
      $("a#reset").attr("disabled", false)
      $("span#matches").text("(" + n + " matches)")
  ).focus()

  # ----------------- RESET BUTTON
  $("a#reset").click( (e) ->
      $("input[name=search]").val("")
      $("span#matches").html("")
      window.tree.clearFilter()
  ).attr("disabled", true)


  if ($("#articles_graph").length > 0)
      Morris.Bar
          element: 'articles_graph'
          pointSize: 1
          data: [
            {y: 'January', a: 246}
            {y: 'February', a: 103}
            {y: 'February', a: 246}
            {y: 'April', a: 103}
            {y: 'May', a: 66}
            {y: 'June', a: 204}
            {y: 'July', a: 27}
            {y: 'August', a: 246}
            {y: 'September', a: 103}
            {y: 'October', a: 66}
            {y: 'November', a: 204}
            {y: 'December', a: 27}
          ]
          xkey: 'y'
          ykeys: ['a']
          labels: ['Series a']
          barColors: [ '#86a000' ]
