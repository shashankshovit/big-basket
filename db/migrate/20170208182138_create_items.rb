class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.integer :quantity
      t.text :description
      t.string :category
      t.string :subcategory
      t.string :image

      t.timestamps
    end
  end
end
