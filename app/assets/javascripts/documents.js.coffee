$ ->

    _doc = null
    _data = null

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
            console.log ":: DRAW"
            content = SMT['documents/preview'](@)
            console.log @_node
            $(@_node).show().append(content)
            $(@_node).find('.btn-danger').bind('click', $.proxy(@clear, @))
            $('.buttons').hide()

        hasFile: ->
            @file != null

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


        size: ->
            kb = 1024
            mb = kb*kb
            if (@file.size > mb)
                (Math.round(@file.size * 100 / mb) / 100).toString() + ' MB'
            else
                (Math.round(@file.size * 100 / kb) / 100).toString() + ' KB'


    # ----- CALENDAR
    $('#document_published_on').datepicker();

    # ----- DIALOGS
    progressModal = $("#prog-modal").modal({
        "backdrop"  : "static",
        "keyboard"  : true,
        "show"      : false
    })
    errorModal = $("#err-modal").modal({
        "backdrop"  : "static",
        "keyboard"  : true,
        "show"      : false
    })

    $("#err-modal").on("show", () ->
        $("#err-modal a.btn").on("click", (e) ->
            $("#err-modal").modal('hide')
            # Cancel uploads
            upload.ajaxStop()
        )
    )

    # $("#prog-modal").on("hide", () ->
    #     $("#prog-modal a.btn").off("click");
    # )

    # $("#prog-modal").on("hidden", () ->
    #     $("#prog-modal").remove();
    # )



    # Apply click event to fake button
    $('#choose_file').click ()-> $('#document_file').click()


    # ----------- FILE UPLOAD -----------

    upload = $('#new_document').fileupload
        dataType: "script"
        maxNumberOfFiles: 1
        dropZone: $('#dropzone')

        add: (e, data) ->

            data.context = $('.upload')
            _data = data
            _doc = new Document(data.files[0])

            # types = /(\.|\/)(pdf|rtf|doc|docx|csv|xls|xlsx|ppt|pptx|txt)$/i
            # file = data.files[0]

            # if types.test(file.type) || types.test(file.name)
            #     if (_doc)
            #         unless (_doc.hasFile)
            #             d = data
            #             data.context = $('.upload')

            #             document = new Document(file).draw '.file-info'

            # else
            #     alert("#{file.name} is not a supported file!")


        progress: (e, data) ->
            console.log ':: PROGRESS'
            if data.context
                progress = parseInt(data.loaded / data.total * 100, 10)

                data.context.find('.bar').css('width', progress + '%')
                if progress == 100
                    setTimeout( ()->
                        $('#prog-modal').find('.modal-header').html('<b>Indexing...</b>')
                        loading = $('<div>').addClass('loading pull-right')
                        msg = 'This process could take a while, please wait.'
                        $('#prog-modal').find('.modal-body').html('').append(loading).append(msg)
                    , 500)
                    return

        done: (e, data) ->
            console.log ':: DONE'
            if (data != null && data.xhr() != null && data.xhr().response != null)
                obj = $.parseJSON(data.xhr().response)
                window.location = '/documents/' + obj.id
            else
                alert('Something rare happened...')

        error: (e, data) ->
            console.log ':: ERROR'
            debugger
            if (e != null && e.responseText != null)

                responseObject = $.parseJSON(e.responseText)
                errors = $('<ul />');

                $.each(responseObject, (index, value) ->
                    # errors.append('<li>' + index + ':' + value + '</li>')
                    errors.append('<li>' + value + '</li>')
                )

                errorModal.find('.errors').append(errors)
                progressModal.modal('hide')
                errorModal.modal('show')
            else
                alert(':: ERROR')
                debugger
            return

        submit: (e, data) ->
            console.log ':: SUBMIT'


    $(':submit').click (e)->
        e.preventDefault()
        if _doc.hasFile()
            progressModal.modal('show')
            _data.submit()
        else
            alert ':: Something nasty did happen!!'


    $(document).bind('dragover', (e)->
        dropZone = $('#dropzone')
        timeout = window.dropZoneTimeout;

        if (!timeout)
            dropZone.addClass('in');
        else
            clearTimeout(timeout);

        if (e.target == dropZone[0])
            dropZone.addClass('hover');
        else
            dropZone.removeClass('hover');

        window.dropZoneTimeout = setTimeout( ()->
            window.dropZoneTimeout = null;
            dropZone.removeClass('in hover');
        , 100)
    )

