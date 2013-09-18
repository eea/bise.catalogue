class AddApprovedToHabitat < ActiveRecord::Migration
  def change
    add_column :habitats, :approved, :boolean, default: true
  end
end
