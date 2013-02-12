class AddTitleToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :title, :string
  end
end
