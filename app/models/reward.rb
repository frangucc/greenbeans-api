class Reward < ActiveRecord::Base
  attr_accessible :title, :dollar_value, :quantity, :bean_cost, :quantity_redeemed, :description, :image, :expiration_date
  belongs_to :merchant

  validates :title, presence: true
  validates :dollar_value, presence: true
  validates :dollar_value, numericality: true, :unless => Proc.new {|c| c.dollar_value.blank?}
  validates :quantity, presence: true
  validates :quantity,  numericality: true, :unless => Proc.new {|c| c.quantity.blank?}
  validates :bean_cost, presence: true
  validates :bean_cost,  numericality: true, :unless => Proc.new {|c| c.bean_cost.blank?}
  validates :expiration_date, presence: true
  validates :expiration_date,
    format: {
    with: /^([1]{1}[9]{1}[9]{1}\d{1}|[2-9]{1}\d{3})-([0,1]\d{1})-([0-2]\d{1}|[3][0,1]{1})\s([0]?\d|1\d|2[0-3]):([0-5]\d):([0-5]\d)\sUTC$/ ,
    message: "Format should be in 'yyyy-mm-dd hh:mm:ss'"
  }, :if => Proc.new {|c| c.expiration_date.nil?}
    
  mount_uploader :image, RewardImageUploader
end