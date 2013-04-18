$('#prog-modal').modal('hide')

errorModal = $("#error-modal").modal({
    "backdrop"  : "static",
    "keyboard"  : true,
    "show"      : false
})

ul = $('<ul>')
errors = eval '<%= @document.errors.to_a %>'

for e in errors
    ul.append $('<li>').append e
$('#error-modal').find('.modal-body').append ul

errorModal.modal('show')


$('#error-modal').on('hidden', () ->
    $(this).find('.modal-body').empty()
)
