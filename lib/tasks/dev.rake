namespace(:dev) do
  desc "Hydrate the database with some dummy data to look at so that developing is easier"
  task({ :prime => :environment}) do
    User.destroy_all
    Flight.destroy_all

    alice = User.new
    alice.email = "alice@example.com"
    alice.password = "password"
    alice.phone_number = "+19876543210"
    alice.save
    
    p alice.errors.full_messages

    50.times do
      flight = Flight.new
      flight.user_id = alice.id
      flight.description = Faker::Address.city
      flight.departs_at =  Faker::Time.between(from: DateTime.now - 2.days, to: DateTime.now + 2.days)
      flight.save
      
      p flight.errors.full_messages
    end
  end
end
