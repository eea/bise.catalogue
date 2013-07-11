# Hide progress modal
$('#prog-modal').modal('hide')

# Clean previous errors
errorModal = $("#success-modal").modal({
  "backdrop"  : "static",
  "keyboard"  : true,
  "show"      : true
})

$('#success-modal').on('hidden', () ->
  doc_url = "<%= document_path(@document) %>"
  window.location = doc_url
)
