
FactoryBot.define do
  factory :idea do

    sequence(:title) { |i| "#{Faker::Cannabis.strain}-#{i}" }

    description{ Faker::Cannabis.health_benefit }
    
    association(:user, factory: :user)

  end
end
