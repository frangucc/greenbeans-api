class RemoveDefaultTierForRaffles < ActiveRecord::Migration
  def up
    change_column_default(:prizes, :tier, nil)
  end

  def down
    change_column_default(:prizes, :tier, default: { first: 0, second: 0, third: 0 }.to_yaml)
  end
end
