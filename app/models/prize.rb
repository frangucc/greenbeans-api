class Prize < ActiveRecord::Base
  belongs_to :raffle
  attr_accessible :p_type, :tier
  
  serialize :tier, Hash
  TYPE = ['money', 'gift', 'voucher']
  
  validates :p_type, :inclusion => { :in => TYPE }
  validate :validate_tier

  def validate_tier
    begin
    self.errors.add(:tier, "should be an number")\
      if self.tier.values.all?{|tier_val| tier_val =~ /[A-Za-z]/}
    end unless self.nil?
  end

end
