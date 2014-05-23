class RenameTargetToStrategyTarget < ActiveRecord::Migration
  def change
    rename_column :catalogue_searches, :target, :strategytarget
  end
end
