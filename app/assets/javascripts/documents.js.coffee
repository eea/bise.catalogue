Document =
  hasChanged: ->
    file = $('#document_file')[0].files[0]
    Document.checkFile(file)

  checkFile: (file) ->
    node = '.file-info'
    types = /(\.|\/)(pdf|rtf|doc|docx|csv|xls|xlsx|ppt|pptx|txt)$/i
    res = types.test(file.type) || types.test(file.name)
    if (res)
      $('#file_title').val file.name
      img = 'default'
      type = ''
      switch file.type
        when 'application/pdf'
          img = 'pdf'
          type = 'PDF'
        when 'application/rtf'
          img = 'rtf'
          type = 'RTF'
        when 'application/msword'
          img = 'word'
          type = 'DOC'
        when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
          img = 'word2010'
          type = 'DOCX'
        when 'text/csv'
          img = 'csv'
          type = 'CSV'
        when 'application/vnd.ms-excel'
          img = 'excel'
          type = 'XLS'
        when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
          img = 'excel2010'
          type = 'XLSX'
        when 'application/vnd.ms-powerpoint'
          img = 'powerpoint'
          type = 'PPT'
        when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
          img = 'powerpoint2010'
          type = 'PPTX'
        when 'text/plain'
          img = 'plaintext'
          type = 'TXT'

      console.log('rendering partial...')

      content = $('<h1 class="file-preview">')
      content.append($('<span class="mini-icon '+img+'">')).append(type)
      content.append($('<small class="pull-right">').html(Document.size(file)))
      $(node).html('').append(content).show(0)
    else
      $(node).hide()
      $('#file_title').val('')

  validate: ->
    fileAdded = $('#document_file')[0].files.length == 1
    if fileAdded
      form = if $('#new_document').size() > 0 then '#new_document' else '#edit_document'
      progressModal.modal('show')
      # progressModal.find('.modal-footer').html window.doc.title()
      $(form)[0].submit()
    else
      $('input[type=submit]').attr('disabled', false)
      alert('Please, add a file');

  send: ->
    $('#new_user')[0].submit()

  size: (file) ->
    kb = 1024
    mb = kb*kb
    if (file.size > mb)
      (Math.round(file.size * 100 / mb) / 100).toString() + ' MB'
    else
      (Math.round(file.size * 100 / kb) / 100).toString() + ' KB'


$ ->

  $('#document_language_ids').chosen({ width: '100%' })
  $('#document_published_on').datepicker({ dateFormat: 'dd/mm/yy' });
  $('#file_select').click ()-> $('#document_file').click()
  $('#document_file').change(Document.hasChanged)

  progressModal = $("#prog-modal").modal({
    backdrop: "static",
    keyboard: true,
    show: false
  })

  form = if $('.new_document').size() > 0 then '#new_document' else '#edit_document'
  $(form).submit ->
    $('input[type=submit]').attr('disabled', true)
    Document.validate(form)
    false

