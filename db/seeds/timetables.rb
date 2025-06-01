# Create sample timetables
puts "Creating sample timetables..."

# Get all classes, subjects, and teachers
classes = SchoolClass.all
subjects = Subject.all
teachers = Teacher.all

# Days of the week
days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']

# Time slots
time_slots = [
  { start_time: '08:00', end_time: '09:00' },
  { start_time: '09:00', end_time: '10:00' },
  { start_time: '10:00', end_time: '11:00' },
  { start_time: '11:00', end_time: '12:00' },
  { start_time: '13:00', end_time: '14:00' },
  { start_time: '14:00', end_time: '15:00' },
  { start_time: '15:00', end_time: '16:00' }
]

# Create timetables for each class
classes.each do |school_class|
  days.each do |day|
    time_slots.each do |slot|
      # Randomly assign a subject and teacher
      subject = subjects.sample
      teacher = teachers.sample

      Timetable.create!(
        school_class: school_class,
        subject: subject,
        teacher: teacher,
        day_of_week: day,
        start_time: slot[:start_time],
        end_time: slot[:end_time],
        room_number: "#{school_class.room_number}"
      )
    end
  end
end

puts "Created #{Timetable.count} timetable entries" 