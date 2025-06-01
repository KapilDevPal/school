module Schools
  class PayslipsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :set_payslip, only: [:show, :edit, :update, :destroy, :download, :mark_as_paid]

    def index
      @month = params[:month] ? Date.parse(params[:month]) : Date.today
      @payslips = current_school.payslips
                               .includes(:teacher)
                               .where(month: @month.month, year: @month.year)
    end

    def show
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "payslip_#{@payslip.teacher.full_name}_#{@payslip.month_year}",
                 template: "schools/payslips/show",
                 layout: 'pdf',
                 disposition: 'inline'
        end
      end
    end

    def new
      @payslip = current_school.payslips.build(
        teacher: @teacher,
        month: Date.today.month,
        year: Date.today.year
      )
    end

    def create
      @payslip = current_school.payslips.build(payslip_params)
      @payslip.teacher = @teacher

      if @payslip.save
        redirect_to schools_payslips_path, notice: 'Payslip was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @payslip.update(payslip_params)
        redirect_to schools_payslips_path, notice: 'Payslip was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @payslip.destroy
      redirect_to schools_payslips_path, notice: 'Payslip was successfully deleted.'
    end

    def download
      respond_to do |format|
        format.pdf do
          render pdf: "payslip_#{@payslip.teacher.full_name}_#{@payslip.month_year}",
                 template: "schools/payslips/show",
                 layout: 'pdf',
                 disposition: 'attachment'
        end
      end
    end

    def mark_as_paid
      if @payslip.update(status: 'paid', paid_at: Date.today)
        redirect_to schools_payslips_path, notice: 'Payslip was marked as paid.'
      else
        redirect_to schools_payslips_path, alert: 'Failed to mark payslip as paid.'
      end
    end

    private

    def set_teacher
      @teacher = current_school.teachers.find(params[:teacher_id]) if params[:teacher_id]
    end

    def set_payslip
      @payslip = current_school.payslips.find(params[:id])
    end

    def payslip_params
      params.require(:payslip).permit(
        :month,
        :year,
        :salary_structure_id,
        :notes
      )
    end
  end
end 