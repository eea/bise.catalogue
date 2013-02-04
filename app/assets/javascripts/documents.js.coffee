# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    d = null

    $('#new_document').fileupload
        dataType: "script"
        add: (e, data) ->
            console.log ':: adding fileupload'


            types = /(\.|\/)(doc|docx|xls|xlsx|pdf|png)$/i
            file = data.files[0]
            if types.test(file.type) || types.test(file.name)
                # Draw from template
                console.log ':: file added...'
                # data.context = 'added...'
                data.context = $(tmpl("template-upload", file))
                d = data
            else
                alert("#{file.name} is not a supported file!")
        progress: (e, data) ->
            if data.context
                progress = parseInt(data.loaded / data.total * 100, 10)
                data.context.find('.bar').css('width', progress + '%')
        done: (e, data) ->
            data.context.text('Upload finished.')



    # $('form[data-remote]')
    $(':submit').click (e) ->
        e.preventDefault()
        $('.form-actions').hide()

        if (d!=null)
            $('#document_file').parent().append(d.context)
            d.submit()


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
