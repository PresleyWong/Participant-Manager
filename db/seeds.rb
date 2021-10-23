# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# if Rails.env.production? 
#   State.create(state: "California", state_abbr: "CA")
#   State.create(state: "North Dakota", state_abbr: "ND")
# end

# if Rails.env.development?
#   for 1..25
#     Orders.create(order_num: Faker::Number:number(8), order_date: Faker::Business.credit_card_expiry_date)
#   end
# end

states = ["Kuala Lumpur", "Penang", "Selangor", "Johor", "Sarawak", "Sabah", "Melaka", "Perak"] 

Admin.create(
    email: "test1@gmail.com",
    password: "123456"
)

50.times do |n|
    Server.create(
        email: Faker::Internet.email,
        locality: states.sample,
        password: "123456"
    )
        
    Participant.create(
        english_name: Faker::Name.first_name,
        chinese_name: Faker::Name.last_name,
        gender: ["Brother", "Sister"].sample ,
        language: "English",
        academic_year: Faker::Number.between(from: 1, to: 4),
        email: Faker::Internet.email,
        phone: Faker::Number.number(digits: 12),
        remarks: Faker::Quote.yoda,
        college: Faker::University.name,
        locality: states.sample
    )

    Event.create(
        title: Faker::Hobby.activity,
        date: Faker::Date.forward(days: 23),
        start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        end_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end


60.times do |n|
    suppress(Exception) do
        Appointment.create(
            participant_id: Faker::Number.between(from: 1, to: 20), 
            event_id: Faker::Number.between(from: 1, to: 20),
            server_name: Server.order('RANDOM()').first.email
        )
    end     
end