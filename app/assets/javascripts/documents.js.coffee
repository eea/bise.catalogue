# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

    $('#document_published_on').datepicker();

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

    d = null
    count = 0

    $('#choose_file').click( ()->
        $('#document_file').click()
    )

    upload = $('#new_document').fileupload
        dataType: "json"    # script
        maxNumberOfFiles: 1
        dropZone: $('#dropzone')
        add: (e, data) ->
            types = /(\.|\/)(pdf|rtf|doc|docx|csv|xls|xlsx|ppt|pptx|txt)$/i
            file = data.files[0]

            if types.test(file.type) || types.test(file.name)

                if (count == 0)
                    # Draw from template
                    # data.context = $(tmpl("template-upload", file))
                    data.context = $('.upload')
                    d = data

                    fileSize = 0;
                    if (file.size > 1024 * 1024)
                        fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + ' MB'
                    else
                        fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + ' KB'

                    infoBadge = $('<span>').addClass('badge badge-success ').html(fileSize)
                    fileName = $('<strong>').append(file.name)
                    $('#document_name').val(file.name)
                    fileImage = 'default'

                    switch file.type
                        when 'application/pdf'
                            fileImage = 'pdf'
                        when 'application/rtf'
                            fileImage = 'rtf'
                        when 'application/msword'
                            fileImage = 'word'
                        when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                            fileImage = 'word2010'
                        when 'text/csv'
                            fileImage = 'csv'
                        when 'application/vnd.ms-excel'
                            fileImage = 'excel'
                        when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                            fileImage = 'excel2010'
                        when 'application/vnd.ms-powerpoint'
                            fileImage = 'powerpoint'
                        when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
                            fileImage = 'powerpoint2010'
                        when 'text/plain'
                            fileImage = 'plaintext'


                    $('#doc-preview').addClass(fileImage)

                    # FILE INFO
                    $('.file-info').html('').show()
                    $('.file-info').append(infoBadge)
                    $('.file-info').append(fileName)

                    # REMOVE BUTTON
                    $('.file-info').append(
                        $('<a>').addClass('remove').click( ()->
                            $('.buttons').show()
                            $('.file-info').hide()
                            $('#doc-preview').removeAttr('class').addClass('filetype')
                            count--
                        ).html('Remove')
                    )

                    $('.buttons').hide()
                    count++
            else
                alert("#{file.name} is not a supported file!")
        progress: (e, data) ->
            console.log ':: progress =>    ( ' + data.loaded + ' / ' + data.total + ')'
            if data.context
                progress = parseInt(data.loaded / data.total * 100, 10)
                console.log ':: progress => ' + progress + '%'
                data.context.find('.bar').css('width', progress + '%')
                if progress == 100
                    setTimeout( ()->
                        console.log 'after timeout'
                        $('#prog-modal').find('.modal-header')
                            .html('<b>Indexing...</b>')
                        loading = $('<div>').addClass('loading pull-right')
                        msg = 'This process could take a while, please wait.'
                        $('#prog-modal').find('.modal-body').html('').append(loading).append(msg)
                    , 500)
                    return

        done: (e, data) ->
            console.log ':: DONE'
            console.log data
            if (data.xhr().response != null)
                obj = $.parseJSON(data.xhr().response)
                console.log obj
                window.location = '/documents/' + obj.id
            else
                alert('Something rare happened...')
        error: (e, data) ->
            console.log ':: ERROR'
            if (e != null && e.responseText != null)
                console.log e.responseText
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
                console.log e
                console.log data
            return

        submit: (e, data) ->
            console.log 'submit'


    $(':submit').click (e)->
        e.preventDefault()
        if count > 0
            # $('#prog-modal').modal('show')
            progressModal.modal('show')
            # $('.form-actions').hide()
            # $('.btn-danger').remove()
            d.submit()
        else
            alert 'something nasty happes'


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




    # --------------------------------------------------------------









    #     $('.form-actions').hide()

    #     if (d!=null)
    #         console.log 'entra...'
    #         $('#document_file').parent().append(d.context)
    #         # d.submit()
    #     console.log 'sended'


    # $('#document_file').live('change', ()->
    #     file = document.getElementById('document_file').files[0];
    #     if (file)

    #         progressTemplate = $(tmpl("template-upload", file))

    # )

    # fileSelected:() ->
    #     console.log 'file selected...'
    #     file = document.getElementById('document_file').files[0];
    #     if (file)
    #         console.log 'has file'
    #         fileSize = 0;
    #         if (file.size > 1024 * 1024)
    #             fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB'
    #         else
    #             fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB'

    #         progressTemplate = $(tmpl("template-upload", file))
    #         document.getElementById('fileName').innerHTML = 'Name: ' + file.name;
    #         document.getElementById('fileSize').innerHTML = 'Size: ' + fileSize;
    #         document.getElementById('fileType').innerHTML = 'Type: ' + file.type;

    # uploadProgress:(e)->
    #     debugger
    #     console.log 'progress...'
    #     if (e.lengthComputable)
    #       progress = Math.round(e.loaded * 100 / e.total);
    #       document.getElementById('progressNumber').innerHTML = progress.toString() + '%';
    #     else
    #       document.getElementById('progressNumber').innerHTML = 'unable to compute';

    #     # progress = parseInt(data.loaded / data.total * 100, 10)
    #     # data.context.find('.bar').css('width', progress + '%')

    # uploadComplete:(e)->
    #     debugger
    #     console.log 'complete'

    # uploadFailed:(e)->
    #     debugger
    #     console.log 'failed'

    # uploadCanceled:(e)->
    #     debugger
    #     console.log 'canceled'



    #     xhr = new XMLHttpRequest()
    #     # fd = document.getElementById('new_document').getFormData()
    #     fd = new FormData();
    #     fd.append("document[name]", $('#document_name').val());
    #     fd.append("document[file]", document.getElementById('document_file').files[0]);
    #     fd.append("document[author]", $('#document_author').val());
    #     fd.append("document[description]", $('#document_description').val())


    #     xhr.upload.addEventListener("progress", @uploadProgress, false)
    #     xhr.addEventListener("load", @uploadComplete, false)
    #     xhr.addEventListener("error", @uploadFailed, false)
    #     xhr.addEventListener("abort", @uploadCanceled, false)

    #     xhr.open("POST", "/documents")
    #     xhr.send(fd)
    #     console.log 'sended...'




    # $('form[data-remote]')
# $(':submit').click (e) ->
#     # e.preventDefault()
#     $('.form-actions').hide()

        # if (d!=null)
            # $('#document_file').parent().append(d.context)
            # d.submit()


    #     data.context = $('<button/>').text('Upload').appendTo(document.body).click () ->
    #     $(this).replaceWith($('<p/>').text('Uploading...'));
    #     data.submit();


    # $('form[data-remote]').bind('ajax:success', ()->
    #     console.log ':: JON success!!'
    # )
    # $('#new_document').bind('ajax:success', ()->
    #     console.log "Success!"
    # )
    # $($(':submit')[0]).bind('ajax:success', ()->
    #     console.log "Success2!"
    # )

    # progressHandler: (e) ->
    #     console.log ':: progress handler... '

# $('#new_document').bind("ajax:success", (evt, data, status, xhr) ->
#     debugger
#     $('.progress')[0].addClass('progress-success')
#     window.location.href = '/documents'
# )


    # $('#new_document').bind("ajax:beforeSend", (evt, xhr, settings)->
    #     console.log 'before send...'

    #     debugger
    #     # xhr.upload.addEventListener('progress', progressHandler, false);

    #     # $submitButton = $(this).find('input[name="commit"]');

    #     # # Update the text of the submit button to let the user know stuff is happening.
    #     # # But first, store the original text of the submit button, so it can be restored when the request is finished.
    #     # $submitButton.data( 'origText', $(this).text() );
    #     # $submitButton.text( "Submitting..." );

    # ).bind("ajax:success", (evt, data, status, xhr)->
    #     console.log 'success'
    #     debugger
    #     # $form = $(this);

    #     # # Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
    #     # $form.find('textarea,input[type="text"],input[type="file"]').val("");
    #     # $form.find('div.validation-error').empty();

    #     # # Insert response partial into page below the form.
    #     # $('#comments').append(xhr.responseText);

    # ).bind('ajax:complete', (evt, xhr, status)->
    #     console.log 'complete'
    #     # $submitButton = $(this).find('input[name="commit"]');

    #     # # Restore the original submit button text
    #     # $submitButton.text( $(this).data('origText') );
    # ).bind("ajax:error", (evt, xhr, status, error)->
    #     console.log 'error'
    #   #   $form = $(this), errors,errorText;

    #   # try {
    #   #   # Populate errorText with the comment errors
    #   #   errors = $.parseJSON(xhr.responseText);
    #   # } catch(err) {
    #   #   # If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
    #   #   errors = {message: "Please reload the page and try again"};
    #   # }

    #   # # Build an unordered list from the list of errors
    #   # errorText = "There were errors with the submission: \n<ul>";

    #   # for ( error in errors ) {
    #   #   errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
    #   # }

    #   # errorText += "</ul>";

    #   # # Insert error list into form
    #   # $form.find('div.validation-error').html(errorText);
    # )
