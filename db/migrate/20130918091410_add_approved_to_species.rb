class AddApprovedToSpecies < ActiveRecord::Migration
  def change
    add_column :species, :approved, :boolean, default: true
  end
end
