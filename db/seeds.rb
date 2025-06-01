# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Cleaning database..."
begin
  SchoolOwnerSchool.destroy_all
  SchoolOwner.destroy_all
  School.destroy_all
  Plan.destroy_all
  User.destroy_all
rescue => e
  puts "Error cleaning database: #{e.message}"
end

# Create Plans
puts "Creating plans..."
begin
  basic_plan = Plan.create!(
    name: 'Basic',
    price: 99.99,
    features_enabled: ['students', 'teachers', 'classes', 'exams']
  )

  premium_plan = Plan.create!(
    name: 'Premium',
    price: 199.99,
    features_enabled: ['students', 'teachers', 'classes', 'exams', 'finance', 'library', 'transport', 'attendance', 'timetable', 'notices', 'fees']
  )
rescue => e
  puts "Error creating plans: #{e.message}"
  raise e
end

# Create Schools
puts "Creating schools..."
begin
  school1 = School.create!(
    name: 'St. Mary\'s High School',
    domain: 'stmarys.edu',
    plan: premium_plan,
    subscription_ends_at: 1.year.from_now,
    features_enabled: ['students', 'teachers', 'classes', 'exams', 'finance', 'library']
  )

  school2 = School.create!(
    name: 'Sunshine Public School',
    domain: 'sunshine.edu',
    plan: basic_plan,
    subscription_ends_at: 1.year.from_now,
    features_enabled: ['students', 'teachers', 'classes', 'exams']
  )
rescue => e
  puts "Error creating schools: #{e.message}"
  raise e
end

# Create School Owners
puts "Creating school owners..."
begin
  school_owner1 = SchoolOwner.create!(
    first_name: 'John',
    last_name: 'Smith',
    email: 'john@example.com',
    password: 'password123'
  )

  school_owner2 = SchoolOwner.create!(
    first_name: 'Sarah',
    last_name: 'Johnson',
    email: 'sarah@example.com',
    password: 'password123'
  )

  school_owner3 = SchoolOwner.create!(
    first_name: 'Michael',
    last_name: 'Brown',
    email: 'michael@example.com',
    password: 'password123'
  )
rescue => e
  puts "Error creating school owners: #{e.message}"
  raise e
end

# Create Admin Users
puts "Creating admin users..."
begin
  admin1 = User.create!(
    first_name: 'Admin',
    last_name: 'User',
    email: 'admin@stmarys.edu',
    password: 'password123',
    role: :admin,
    school: school1
  )

  admin2 = User.create!(
    first_name: 'Admin',
    last_name: 'User',
    email: 'admin@sunshine.edu',
    password: 'password123',
    role: :admin,
    school: school2
  )
rescue => e
  puts "Error creating admin users: #{e.message}"
  raise e
end

# Create Teachers
puts "Creating teachers..."
begin
  teacher1 = Teacher.create!(
    first_name: 'Emma',
    last_name: 'Wilson',
    email: 'emma@stmarys.edu',
    phone_number: '1112223333',
    school: school1,
    password: 'password123'
  )

  teacher2 = Teacher.create!(
    first_name: 'James',
    last_name: 'Anderson',
    email: 'james@stmarys.edu',
    phone_number: '4445556666',
    school: school1,
    password: 'password123'
  )

  teacher3 = Teacher.create!(
    first_name: 'Lisa',
    last_name: 'Martinez',
    email: 'lisa@sunshine.edu',
    phone_number: '7778889999',
    school: school2,
    password: 'password123'
  )
rescue => e
  puts "Error creating teachers: #{e.message}"
  raise e
end

# Create Students
puts "Creating students..."
begin
  student1 = Student.create!(
    first_name: 'Alex',
    last_name: 'Johnson',
    email: 'alex@stmarys.edu',
    # phone: '1231231234',
    school: school1,
    password: 'password123',
    admission_number: 'ST001',
    class_section: '10A',
    date_of_birth: '2005-05-15'
  )

  student2 = Student.create!(
    first_name: 'Sophia',
    last_name: 'Williams',
    email: 'sophia@stmarys.edu',
    # phone: '2342342345',
    school: school1,
    password: 'password123',
    admission_number: 'ST002',
    class_section: '10B',
    date_of_birth: '2005-06-20'
  )

  student3 = Student.create!(
    first_name: 'Noah',
    last_name: 'Brown',
    email: 'noah@sunshine.edu',
    # phone: '3453453456',
    school: school2,
    password: 'password123',
    admission_number: 'ST003',
    class_section: '9A',
    date_of_birth: '2006-03-10'
  )
rescue => e
  puts "Error creating students: #{e.message}"
  raise e
end

# Associate Schools with School Owners
puts "Associating schools with owners..."
begin
  SchoolOwnerSchool.create!(
    school_owner: school_owner1,
    school: school1
  )

  SchoolOwnerSchool.create!(
    school_owner: school_owner2,
    school: school2
  )

  SchoolOwnerSchool.create!(
    school_owner: school_owner3,
    school: school1
  )

  SchoolOwnerSchool.create!(
    school_owner: school_owner3,
    school: school2
  )
rescue => e
  puts "Error creating school owner associations: #{e.message}"
  raise e
end

puts "Seed data created successfully!"

# Load all seed files in specific order
seed_files = [
  'teachers.rb',    # Create teachers first
  'subjects.rb',    # Then subjects
  'classes.rb',     # Then classes (depends on teachers)
  'timetables.rb',  # Then timetables (depends on classes, subjects, and teachers)
  'fees.rb'         # Finally fees (depends on students)
]

seed_files.each do |seed_file|
  puts "\nLoading seed file: #{seed_file}"
  load File.join(Rails.root, 'db', 'seeds', seed_file)
end
