class Raffle < ActiveRecord::Base
  belongs_to :merchant
  attr_accessible :description, :drawing_time, :instructions, :name, :num_of_winner, :repeat, :prize_attributes
  
  has_one :prize
  accepts_nested_attributes_for :prize
  
  validates :name, presence: true
  validates :drawing_time, presence: true
  validates :num_of_winner, presence: true, numericality: true
  validates :prize, :presence => true
  validates_associated :prize
  
  scope :actives, lambda {where(['drawing_time > ?', DateTime.now])}

  validate :validate_no_of_winners_and_tiers, :validate_drawing_time

  def validate_no_of_winners_and_tiers
    puts "-" * 50
    puts self.inspect
        puts "-" * 50
    puts self.prize.inspect
        puts "-" * 50
    begin
    unless self.num_of_winner == self.prize.tier.size
      self.errors.add(:prize, "Number and winners number donot match")
    end
    end unless self.prize.nil?
  end

  def validate_drawing_time
    if self.drawing_time <= (Time.now + 300)
      self.errors.add(:drawing_time, "should be atleast 5 mins ahead of current time")
    end
  end

end
