$ ->

    _data = null
    _form = if $('.new_document').size() > 0 then '.new_document' else '.edit_document'

    class Document
        _node: '.file-info'

        constructor: () ->


        checkFile: =>
            types = /(\.|\/)(pdf|rtf|doc|docx|csv|xls|xlsx|ppt|pptx|txt)$/i
            types.test(@file.type) || types.test(@file.name)

        clear: ->
            $('.buttons').show()
            $(@_node).hide().html('')
            @file = null

        draw: ->
            $(@_node).html('')
            content = SMT['documents/preview'](@)
            $(@_node).show().append(content)

        hasChanged: ->
            window.doc.file = $('#document_file')[0].files[0]
            $('#file_title').val window.doc.file.name
            if window.doc.checkFile()
                window.doc.draw()

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
        type: ->
            switch @file.type
                when 'application/pdf'
                    'PDF'
                when 'application/rtf'
                    'RTF'
                when 'application/msword'
                    'DOC'
                when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                    'DOCX'
                when 'text/csv'
                    'CSV'
                when 'application/vnd.ms-excel'
                    'XLS'
                when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                    'XLSX'
                when 'application/vnd.ms-powerpoint'
                    'PPT'
                when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
                    'PPTX'
                when 'text/plain'
                    'TXT'

        title: ->
            @file.name

        size: ->
            kb = 1024
            mb = kb*kb
            if (@file.size > mb)
                (Math.round(@file.size * 100 / mb) / 100).toString() + ' MB'
            else
                (Math.round(@file.size * 100 / kb) / 100).toString() + ' KB'


    # Create singleton Document
    window.doc = new Document()

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
    $('#document_file').change window.doc.hasChanged


    $(':submit').click (e)->
        # e.preventDefault()
        if _form == '.new_document' and window.doc? and window.doc.hasFile()
            progressModal.modal('show')
            progressModal.find('.modal-footer').html window.doc.title()
        else if _form == '.edit_document'
            progressModal.modal('show')
        # $('#new_document').submit()
        # else
        # e.preventDefault()
        # alert('File can\'t be empty')

