class AddApprovedToProtectedArea < ActiveRecord::Migration
  def change
    add_column :protected_areas, :approved, :boolean, default: true
  end
end
