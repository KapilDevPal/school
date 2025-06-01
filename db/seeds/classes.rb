# Create sample classes
puts "Creating sample classes..."

schools = School.all
if schools.empty?
  puts "No schools found! Cannot create classes."
else
  grades = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
  sections = ['A', 'B', 'C']
  schools.each do |school|
    teachers = school.teachers
    if teachers.empty?
      puts "No teachers found for school #{school.name}! Cannot create classes for this school."
      next
    end
    grades.each do |grade|
      sections.each do |section|
        SchoolClass.create!(
          name: "Grade #{grade} Section #{section}",
          grade: grade,
          section: section,
          teacher: teachers.sample,
          room_number: "#{grade}#{section}",
          capacity: rand(20..30),
          school: school
        )
      end
    end
  end
end

puts "Created #{SchoolClass.count} classes" 