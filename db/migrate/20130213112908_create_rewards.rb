class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :title, :null => false
      t.integer :dollar_value, :null => false
      t.integer :quantity,  :null => false
      t.integer :bean_cost,  :null => false
      t.integer :quantity_redeemed
      t.text :description
      t.string :image
      t.datetime :expiration_date
      t.belongs_to :merchant
      t.timestamps
    end
     add_index :rewards, :merchant_id
  end
end
