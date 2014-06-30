class AddCreatedByToClassiable < ActiveRecord::Migration
  def change
    add_reference :articles, :creator, index: true
    add_reference :documents, :creator, index: true
    add_reference :links, :creator, index: true
    add_reference :articles, :modifier, index: true
    add_reference :documents, :modifier, index: true
    add_reference :links, :modifier, index: true
  end
end
