# Create sample fees
puts "Creating sample fees..."

schools = School.all
if schools.empty?
  puts "No schools found! Cannot create fees."
else
  schools.each do |school|
    students = school.students
    if students.empty?
      puts "No students found for school #{school.name}! Cannot create fees for this school."
      next
    end

    students.each do |student|
      # Create fees for the current month and next 2 months
      3.times do |i|
        due_date = Date.today + i.months
        status = ['pending', 'paid', 'overdue'].sample
        
        fee = Fee.new(
          amount: rand(1000..5000),
          due_date: due_date,
          status: status,
          student: student,
          school: school
        )

        if status == 'paid'
          fee.payment_date = due_date - rand(1..5).days
          fee.payment_method = ['cash', 'credit_card', 'bank_transfer'].sample
        end

        fee.save!
      end
    end
  end
end

puts "Created #{Fee.count} fees" 