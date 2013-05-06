class RenameTypeColumn < ActiveRecord::Migration
  def change
    rename_column :ingredients, :type, :step_type
  end
end
