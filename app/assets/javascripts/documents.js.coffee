$ ->

    _doc = null
    _data = null

    _form = if $('.new_document').size() > 0 then '.new_document' else '.edit_document'

    console.log '... drawing doc viewer... '
    docUrl = 'http://www.documentcloud.org/documents/6800-memo-on-alternatives-to-comprehensive-immigration-reform.js';
    # DV.load(docUrl, {
    #     container: '#document-preview',
    #     width: 572,
    #     height: 500,
    #     sidebar: true
    # })
    # DV.load('http://www.documentcloud.org/search/embed/', {
    #     q: "projectid: 8-epa-flouride",
    #     container: "#document-previewe",
    #     order: "title",
    #     per_page: 12,
    #     search_bar: true,
    #     organization: 117
    # })


    class Document
        _node: '.file-info'

        constructor: (@file) ->
            $('.buttons').hide()
            if @checkFile()
                @draw()
            else
                alert("#{@file.name} is not a supported file!")
                $('.buttons').show()
                @clear()

        checkFile: =>
            types = /(\.|\/)(pdf|rtf|doc|docx|csv|xls|xlsx|ppt|pptx|txt)$/i
            types.test(@file.type) || types.test(@file.name)

        clear: ->
            $('.buttons').show()
            $(@_node).hide().html('')
            @file = null

        draw: ->
            content = SMT['documents/preview'](@)
            $(@_node).show().append(content)
            $(@_node).find('.btn-danger').bind('click', $.proxy(@clear, @))
            $('.buttons').hide()

        hasFile: ->
            if @file? then true else false

        image: ->
            img = 'default'
            switch @file.type
                when 'application/pdf'
                    img = 'pdf'
                when 'application/rtf'
                    img = 'rtf'
                when 'application/msword'
                    img = 'word'
                when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                    img = 'word2010'
                when 'text/csv'
                    img = 'csv'
                when 'application/vnd.ms-excel'
                    img = 'excel'
                when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                    img = 'excel2010'
                when 'application/vnd.ms-powerpoint'
                    img = 'powerpoint'
                when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
                    img = 'powerpoint2010'
                when 'text/plain'
                    img = 'plaintext'

        upload: ->

        title: ->
            @file.name

        size: ->
            kb = 1024
            mb = kb*kb
            if (@file.size > mb)
                (Math.round(@file.size * 100 / mb) / 100).toString() + ' MB'
            else
                (Math.round(@file.size * 100 / kb) / 100).toString() + ' KB'


    # ----- CALENDAR
    $('#document_published_on').datepicker();


    # ----- PROGRESS DIALOG
    progressModal = $("#prog-modal").modal({
        "backdrop"  : "static",
        "keyboard"  : true,
        "show"      : false
    })


    # FILE
    $('#file_select').click ()-> $('#document_file').click()
    $('#document_file').change ()->
        _doc = new Document $('#document_file')[0].files[0]
        $('#file_title').val $('#document_file')[0].files[0].name


    $(':submit').click (e)->
        if _form == '.new_document' and _doc? and _doc.hasFile()
            progressModal.modal('show')
            progressModal.find('.modal-footer').html _doc.title()
        else if _form == '.edit_document'
            progressModal.modal('show')
        else
            e.preventDefault()
            alert('File can\'t be empty')

