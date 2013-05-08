class CreateMenurecipejoins < ActiveRecord::Migration
  def change
    create_table :menurecipejoins do |t|
      t.integer :menu_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
