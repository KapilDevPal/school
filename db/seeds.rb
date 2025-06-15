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
admin_user = User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@school.com",
  password: "admin123",
  role: :admin,
  school: school1
)

# Create Teachers
puts "Creating teachers..."
user1 = User.create!(
  first_name: "John",
  last_name: "Doe",
  email: "john.doe@school.com",
  password: "teacher123",
  role: :teacher,
  school: school1,
  phone_number: "+1234567890"
)

teacher1 = Teacher.create!(
  user: user1,
  first_name: "John",
  last_name: "Doe",
  email: "john.doe@school.com",
  phone_number: "+1234567890",
  password: "teacher123",
  school: school1,
  qualification: "M.Ed",
  experience: 5,
  specialization: "Mathematics" 
)

user2 = User.create!(
  first_name: "Jane",
  last_name: "Smith",
  email: "jane.smith@school.com",
  password: "teacher123",
  role: :teacher,
  school: school1,
  phone_number: "+1234567891"
)

teacher2 = Teacher.create!(
  user: user2,
  first_name: "Jane",
  last_name: "Smith",
  email: "jane.smith@school.com",
  phone_number: "+1234567891",
  password: "teacher123",
  school: school1,
  qualification: "M.Sc",
  experience: 3,
  specialization: "Science"
)

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

# Create Students
puts "Creating students..."
user3 = User.create!(
  first_name: "Alice",
  last_name: "Johnson",
  email: "alice.johnson@school.com",
  password: "student123",
  role: :student,
  school: school1
)

student1 = Student.create!(
  user: user3,
  first_name: "Alice",
  last_name: "Johnson",
  email: "alice.johnson@school.com",
  phone_number: "+1234567892",
  password: "student123",
  school: school1,
  admission_number: "S001",
  roll_number: "1",
  gender: "female",
  date_of_birth: Date.new(2010, 1, 1),
  parent_name: "Mary Johnson",
  parent_phone: "+1234567893",
  parent_email: "mary.johnson@email.com",
  address: "123 Student Street, City",
  class_section: "A",
  school_class: class1
)

user4 = User.create!(
  first_name: "Bob",
  last_name: "Wilson",
  email: "bob.wilson@school.com",
  password: "student123",
  role: :student,
  school: school1
)

student2 = Student.create!(
  user: user4,
  first_name: "Bob",
  last_name: "Wilson",
  email: "bob.wilson@school.com",
  phone_number: "+1234567894",
  password: "student123",
  school: school1,
  admission_number: "S002",
  roll_number: "2",
  gender: "male",
  date_of_birth: Date.new(2010, 2, 1),
  parent_name: "John Wilson",
  parent_phone: "+1234567895",
  parent_email: "john.wilson@email.com",
  address: "456 Student Avenue, City",
  class_section: "B",
  school_class: class2
)

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

# Create sample timetables
school = School.first
teacher = Teacher.first
school_class = SchoolClass.first

# Create subjects
subjects = [
  { name: 'Mathematics', code: 'MATH101' },
  { name: 'Science', code: 'SCI101' },
  { name: 'English', code: 'ENG101' },
  { name: 'History', code: 'HIST101' },
  { name: 'Geography', code: 'GEO101' }
].map do |subject_data|
  Subject.create!(
    name: subject_data[:name],
    code: subject_data[:code],
    school: school,
    credits: 3,
    description: "#{subject_data[:name]} course for grade #{school_class.name}"
  )
end

# Create timetables for each weekday (Monday to Friday)
%w[Monday Tuesday Wednesday Thursday Friday].each do |day|
  start_times = ['09:00', '10:00', '11:00', '12:00', '14:00', '15:00']
  start_times.each_with_index do |time, index|
    Timetable.create!(
      school: school,
      school_class: school_class,
      subject: subjects[index % subjects.length],
      teacher: teacher,
      day_of_week: day,
      start_time: Time.parse(time),
      end_time: Time.parse(time) + 45.minutes,
      room_number: "Room #{index + 1}"
    )
  end
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
