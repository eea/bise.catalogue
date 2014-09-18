class ChkInput < SimpleForm::Inputs::BooleanInput
  def input
    input_html_options = {class: [:chk, :optional], style: 'display: inline'}
    @builder.check_box(attribute_name, input_html_options, checked_value, unchecked_value)
  end
end