module Schools

  class FeesController < ApplicationController

  # class FeesController < ApplicationController
    before_action :set_fee, only: [:show, :edit, :update, :destroy]
    before_action :set_students, only: [:new, :create, :edit, :update]

    def index
      @fees = current_school.fees.includes(:student)
    end

    def show
    end

    def new
      @fee = Fee.new
    end

    def edit
    end

    def create
      @fee = current_school.fees.build(fee_params)

      if @fee.save
        redirect_to schools_fee_path(@fee), notice: 'Fee was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @fee.update(fee_params)
        redirect_to schools_fee_path(@fee), notice: 'Fee was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @fee.destroy
      redirect_to schools_fees_path, notice: 'Fee was successfully deleted.'
    end

    private

    def set_fee
      @fee = current_school.fees.find(params[:id])
    end

    def set_students
      @students = current_school.students
    end

    def fee_params
      params.require(:fee).permit(:student_id, :amount, :due_date, :status, :payment_date, :payment_method)
    end
  end
end 