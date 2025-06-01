# Create sample subjects
puts "Creating sample subjects..."

schools = School.all
if schools.empty?
  puts "No schools found! Cannot create subjects."
else
  subjects_data = [
    { name: 'Mathematics', code: 'MATH', description: 'Basic mathematics and algebra', credits: 4 },
    { name: 'Science', code: 'SCI', description: 'General science', credits: 4 },
    { name: 'English', code: 'ENG', description: 'English language and literature', credits: 3 },
    { name: 'History', code: 'HIST', description: 'World history', credits: 3 },
    { name: 'Geography', code: 'GEO', description: 'Physical and human geography', credits: 3 },
    { name: 'Computer Science', code: 'CS', description: 'Programming and computer basics', credits: 4 },
    { name: 'Physical Education', code: 'PE', description: 'Sports and physical activities', credits: 2 },
    { name: 'Art', code: 'ART', description: 'Visual arts and crafts', credits: 2 },
    { name: 'Music', code: 'MUSIC', description: 'Music theory and practice', credits: 2 }
  ]

  schools.each do |school|
    subjects_data.each do |subject_data|
      Subject.create!(
        name: subject_data[:name],
        code: subject_data[:code],
        description: subject_data[:description],
        credits: subject_data[:credits],
        school: school
      )
    end
  end
end

puts "Created #{Subject.count} subjects" 