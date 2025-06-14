class StaffMailer < ApplicationMailer
  def welcome_email(staff, password)
    @staff = staff
    @password = password
    @school = staff.school

    mail(
      to: @staff.email,
      subject: "Welcome to #{@school.name} - Your Account Details"
    )
  end
end 