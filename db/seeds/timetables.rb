puts "Creating timetables..."

# Get all subjects and teachers for reference
subjects = Subject.all
teachers = Teacher.all

if subjects.empty? || teachers.empty?
  puts "No subjects or teachers found! Cannot create timetables."
else
  SchoolClass.find_each do |school_class|
    # Create timetables for each day of the week (Monday to Friday)
    %w[Monday Tuesday Wednesday Thursday Friday].each_with_index do |day, day_index|
      # Create 8 periods per day (assuming 40-minute periods with breaks)
      (1..8).each do |period|
        start_time = Time.new(2024, 1, 1, 8, 0) + day_index.days + (period - 1) * 45.minutes
        end_time = start_time + 40.minutes

        # Assign random subject and teacher
        subject = subjects.sample
        teacher = teachers.sample

        Timetable.create!(
          school_class: school_class,
          subject: subject,
          teacher: teacher,
          day_of_week: day,
          start_time: start_time,
          end_time: end_time,
          room_number: "Room #{rand(1..20)}"
        )
      end
    end
  end
  puts "Created timetables for all school classes"
end 