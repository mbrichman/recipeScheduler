class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.date :menu_date
    end
    add_column :recipes, :menu_id, :integer
  end
end
