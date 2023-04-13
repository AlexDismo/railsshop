class CreateOrderDescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :order_descriptions do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end