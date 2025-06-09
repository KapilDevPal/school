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
    email: 'school.owner@example.com',
    password: 'password123'
  )

  school_owner2 = SchoolOwner.create!(
    first_name: 'Sarah',
    last_name: 'Johnson',
    email: 'school.owner2@example.com',
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
    email: 'admin@example.com',
    password: 'password123',
    role: :admin,
    school: school1
  )
rescue => e
  puts "Error creating admin users: #{e.message}"
  raise e
end

# Create Teachers
puts "Creating teachers..."
begin
  # Teacher 1
  teacher1_user = User.create!(
    first_name: "John",
    last_name: "Doe",
    email: "teacher@example.com",
    password: "password123",
    role: :teacher,
    school: school1
  )
  teacher1 = Teacher.create!(
    user_id: teacher1_user.id,
    first_name: "John",
    last_name: "Doe",
    email: "teacher@example.com",
    school: school1,
    phone_number: '1112223333',
    password: 'password123',
    qualification: 'M.Ed',
    experience: 5,
    specialization: 'Mathematics'
  )

  # Teacher 2
  teacher2_user = User.create!(
    first_name: 'Jane',
    last_name: 'Smith',
    email: 'teacher2@example.com',
    password: 'password123',
    role: :teacher,
    school: school1
  )
  teacher2 = Teacher.create!(
    user_id: teacher2_user.id,
    first_name: 'Jane',
    last_name: 'Smith',
    email: 'teacher2@example.com',
    phone_number: '4445556666',
    school: school1,
    password: 'password123',
    qualification: 'B.Ed',
    experience: 3,
    specialization: 'English'
  )
rescue => e
  puts "Error creating teachers: #{e.message}"
  raise e
end

# Create Students
puts "Creating students..."
begin
  # Student 1
  student1_user = User.create!(
    first_name: 'Alex',
    last_name: 'Johnson',
    email: 'student@example.com',
    password: 'password123',
    role: :student,
    school: school1
  )
  student1 = Student.create!(
    user_id: student1_user.id,
    first_name: 'Alex',
    last_name: 'Johnson',
    email: 'student@example.com',
    school: school1,
    password: 'password123',
    admission_number: 'ST001',
    class_section: '10A',
    date_of_birth: '2005-05-15'
  )

  # Student 2
  student2_user = User.create!(
    first_name: 'Emma',
    last_name: 'Williams',
    email: 'student2@example.com',
    password: 'password123',
    role: :student,
    school: school1
  )
  student2 = Student.create!(
    user_id: student2_user.id,
    first_name: 'Emma',
    last_name: 'Williams',
    email: 'student2@example.com',
    school: school1,
    password: 'password123',
    admission_number: 'ST002',
    class_section: '10B',
    date_of_birth: '2005-06-20'
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
rescue => e
  puts "Error creating school owner associations: #{e.message}"
  raise e
end

# Create School Classes
puts "Creating school classes..."
begin
  class1 = SchoolClass.create!(
    name: '10A',
    grade: '10',
    section: 'A',
    room_number: 'A1',
    capacity: 30,
    school: school1,
    teacher_id: teacher1.id
  )
  class2 = SchoolClass.create!(
    name: '10B',
    grade: '10',
    section: 'B',
    room_number: 'B1',
    capacity: 28,
    school: school1,
    teacher_id: teacher2.id
  )
rescue => e
  puts "Error creating school classes: #{e.message}"
  raise e
end

# Associate Teachers with Classes
puts "Associating teachers with classes..."
begin
  TeacherClass.create!(teacher: teacher1, school_class: class1)
  TeacherClass.create!(teacher: teacher2, school_class: class2)
rescue => e
  puts "Error associating teachers with classes: #{e.message}"
  raise e
end

# Associate Students with Classes
puts "Associating students with classes..."
begin
  StudentClass.create!(student: student1, school_class: class1)
  StudentClass.create!(student: student2, school_class: class2)
rescue => e
  puts "Error associating students with classes: #{e.message}"
  raise e
end

puts "Seed data created successfully!"
puts "\nTest Accounts:"
puts "=============="
puts "School Owner:"
puts "  Email: school.owner@example.com"
puts "  Password: password123"
puts "\nTeacher:"
puts "  Email: teacher@example.com"
puts "  Password: password123"
puts "\nStudent:"
puts "  Email: student@example.com"
puts "  Password: password123"

# Load all seed files
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed_file|
  puts "Loading #{seed_file}..."
  load seed_file
end
