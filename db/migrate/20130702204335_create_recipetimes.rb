class CreateRecipetimes < ActiveRecord::Migration
  def change
    create_table :recipetimes do |t|
      t.integer :amount
      t.string  :interval
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
