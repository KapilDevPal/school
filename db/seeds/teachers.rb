puts "Creating sample teachers..."

schools = School.all
if schools.empty?
  puts "No schools found! Cannot create teachers."
else
  schools.each do |school|
    5.times do
      Teacher.create!(
        first_name: 'Teacher',
        last_name: Faker::Name.last_name,
        email: Faker::Internet.unique.email,
        phone_number: Faker::PhoneNumber.phone_number,
        password: 'password',
        school: school
      )
    end
  end
end

puts "Created #{Teacher.count} teachers" 