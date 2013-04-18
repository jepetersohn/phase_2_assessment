require 'faker'

User.delete_all
Event.delete_all

# Create 5,000 users
users = 10.times.map do
  User.create :first_name => Faker::Name.first_name,
              :last_name  => Faker::Name.last_name,
              :password   => "monkey",
              :email      => Faker::Internet.email
end

10.times do
  start_time = Time.now + (rand(61) - 30).days
  end_time   = start_time + (1 + rand(6)).hours

  Event.create :user_id    => users[rand(users.length)].id,
               :name       => Faker::Company.name,
               :location   => "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
               :starts_at  => start_time,
               :ends_at    => end_time
end
