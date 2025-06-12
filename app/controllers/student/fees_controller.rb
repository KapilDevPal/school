module Students
  class FeesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_student

    def index
      @student = current_user.student
      @fees = @student.fees.order(due_date: :desc)
      @total_paid = @fees.where(status: 'paid').sum(:amount)
      @total_pending = @fees.where(status: 'pending').sum(:amount)
    end

    def show
      @fee = Fee.find(params[:id])
      unless @fee.student == current_user.student
        redirect_to student_fees_path, alert: 'You do not have permission to view this fee.'
      end
    end

    private

    def ensure_student
      unless current_user.student?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
      end
    end
  end
end 