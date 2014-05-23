class RenameActionsToStrategyActions < ActiveRecord::Migration
  def change
    rename_table :actions, :strategy_actions
  end
end
