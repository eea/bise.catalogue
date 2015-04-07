ActiveAdmin.register UnprocessedObject do
  menu parent: 'Others'
  config.comments = false

  index do
    selectable_column
    id_column
    column :model
    column :http_method
    column :field
    column :message
    column :ip
    column :params
    actions
  end

  controller do
    def permitted_params
      params.require(:unprocessed_object).permit(:model, :http_method, :field, :message, :ip, :params)
    end
  end
end

