puts "Creating sample teachers..."

schools = School.all
if schools.empty?
  puts "No schools found! Cannot create teachers."
else
  schools.each do |school|
    # Find or create the teacher role for this school
    teacher_role = Role.find_or_create_by!(name: 'teacher', school: school)
    5.times do
      # Create user first
      user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.unique.email,
        password: 'password123',
        role: teacher_role,
        school: school
      )

      # Create teacher with all required fields
      Teacher.create!(
        user: user,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        phone_number: Faker::PhoneNumber.cell_phone_in_e164,
        password: 'password123',
        school: school,
        qualification: ['B.Ed', 'M.Ed', 'Ph.D'].sample,
        experience: rand(1..20),
        specialization: ['Mathematics', 'English', 'Science', 'History', 'Geography'].sample
      )
    end
  end
end

puts "Created #{Teacher.count} teachers" 