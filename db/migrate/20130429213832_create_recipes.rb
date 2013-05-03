class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :time
      t.string :source
      t.text :url

      t.timestamps
    end
  end
end
