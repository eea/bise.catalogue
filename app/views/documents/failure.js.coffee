# Hide progress modal
$('#prog-modal').modal('hide')

# Clean previous errors
$('#error-modal').find('.modal-body').html('')


errorModal = $("#error-modal").modal({
  "backdrop"  : "static",
  "keyboard"  : true,
  "show"      : false
})

# Create error list and show modal
ul = $('<ul>')
<% @document.errors.to_a.each do |e| %>
ul.append($('<li>').append('<%= e %>'))
<% end %>
$('#error-modal').find('.modal-body').append ul
errorModal.modal('show')


# After remote submit, file disappears
if $('#document_file')[0].files.length == 0
  $('.file-info').html('').hide()
  $('#file_title').val('')
  $('#document_file').change window.doc.hasChanged


$('#error-modal').on('hidden', () ->
    $("#error-modal").find('.modal-body ul').remove()
)

