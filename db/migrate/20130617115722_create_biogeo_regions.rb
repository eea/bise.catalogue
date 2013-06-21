class CreateBiogeoRegions < ActiveRecord::Migration
  def change
    create_table :biogeo_regions do |t|
      t.string :code
      t.string :area_name

      t.timestamps
    end
  end
end
