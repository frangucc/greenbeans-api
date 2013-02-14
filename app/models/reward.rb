class Reward < ActiveRecord::Base
  attr_accessible :title, :dollar_value, :quantity, :bean_cost, :quantity_redeemed, :description, :image, :expiration_date
  belongs_to :merchant

  mount_uploader :image, RewardImageUploader
end