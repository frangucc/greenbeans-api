class Merchant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_many :raffles
  has_many :tokens
  has_many :rewards
  
  validates :email, presence: true
  validates :name, uniqueness: true, presence: true
  after_create :generate_first_token 

  private 
  def generate_first_token 
    self.tokens.create 
  end
end
