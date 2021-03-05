# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Idea.delete_all
Review.delete_all
User.delete_all

PASSWORD='sentence2'

super_user=User.create(
    first_name: 'Aleena',
    last_name: 'Bhari',
    email:"ab5@gmail.com",
    password: PASSWORD,
)
10.times do 
first_name=Faker::Name.first_name
last_name=Faker::Name.last_name
User.create(
    first_name:first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
)
end
users=User.all


50.times do
  created_at = Faker::Date.backward(days: 365)

  Idea.create(
    title: Faker::Hacker.say_something_smart,
    description: Faker::ChuckNorris.fact,
    created_at:created_at,
    updated_at:created_at,
    user: users.sample
  
  )
end

ideas=Idea.all

ideas.each do |i|
  5.times do
      Review.create(
          description: Faker::Lorem.paragraph,
          idea_id: i.id,
          user: users.sample     
      )
  end
end

reviews= Review.all


puts Cowsay.say("Generated #{ideas.count} ideas", :frogs)
puts Cowsay.say("Generated #{reviews.count} reviews", :bunny)
puts Cowsay.say("Created #{users.count} users", :dragon)
puts Cowsay.say("Login with #{super_user.email} and password: #{PASSWORD}", :sheep)