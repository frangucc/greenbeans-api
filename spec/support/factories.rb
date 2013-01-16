FactoryGirl.define do
  factory :merchant do
    name Faker::Name.name 
    email Faker::Internet.email
    password 'password'
    password_confirmation 'password'
  end
  
  tier_hash = {:first => 100, :second => 50, :third => 20}
  factory :raffle do
    name Faker::Lorem.words(2)
    num_of_winner 3
    description Faker::Lorem.words(10)
    drawing_time Time.now + 10
    repeat  false
    factory :prize do
      p_type Prize::TYPE.sample
      tier tier_hash
    end
  end
   
end
