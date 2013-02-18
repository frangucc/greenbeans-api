class AddBeanCostToRaffles < ActiveRecord::Migration
  def change
    add_column :raffles, :bean_cost, :integer
  end
end
