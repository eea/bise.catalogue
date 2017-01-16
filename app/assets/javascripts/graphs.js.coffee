# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
Graph =
  hasChanged: ->
    file = $('#graph_thumb')[0].files[0]
    Graph.checkFile(file)

  checkFile: (file) ->
    node = '.file-info'
    types = /(\.|\/)(jpg|png|jpeg)$/i
    res = types.test(file.type) || types.test(file.name)
    if (res)
      $('#thumb_title').val file.name
      img = 'default'
      type = ''
      switch file.type
        when 'image/jpeg'
          img = 'jpg'
          type = 'JPG'
        when 'image/jpg'
          img = 'jpg'
          type = 'JPG'
        when 'image/pjpeg'
          img = 'jpg'
          type = 'JPG'
        when 'image/png'
          img = 'png'
          type = 'PNG'
      console.log('rendering partial...')

      content = $('<h1 class="file-preview">')
      content.append($('<span class="mini-icon '+img+'">')).append(type)
      content.append($('<small class="pull-right">').html(Graph.size(file)))
      $(node).html('').append(content).show(0)
    else
      $(node).hide()
      $('#thumb_title').val('')

  validate: ->
    fileAdded = $('#graph_thumb')[0].files.length == 1
    form = if $('#new_graph').size() > 0 then '#new_graph' else '.edit_graph'
    if fileAdded or form == '.edit_graph'
      $(form)[0].submit()
    else
      $('input[type=submit]').attr('disabled', false)
      alert('Please, add a graph thumb image');

  size: (file) ->
    kb = 1024
    mb = kb*kb
    if (file.size > mb)
      (Math.round(file.size * 100 / mb) / 100).toString() + ' MB'
    else
      (Math.round(file.size * 100 / kb) / 100).toString() + ' KB'

$ ->
    $('#graph_published_on').datepicker({ dateFormat: 'dd/mm/yy' })
    $('#graph_language_ids').chosen({
        width: '100%'
    })

    $('#graph_thumb_select').click ()-> $('#graph_thumb').click()
    $('#graph_thumb').change(Graph.hasChanged)

    form = if $('.new_graph').size() > 0 then '.new_graph' else '.edit_graph'
    $(form).submit ->
      $('input[type=submit]').attr('disabled', true)
      Graph.validate(form)
      false

