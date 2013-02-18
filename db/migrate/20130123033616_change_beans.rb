class ChangeBeans < ActiveRecord::Migration
  def up
    add_column :beans, :user_id, :integer
    rename_column :beans, :is_checkout, :redeemed
  end

  def down
    remove_column :beans, :user_id
    rename_column :beans, :redeemed, :is_checkout
  end
end
