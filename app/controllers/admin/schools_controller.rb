module Admin
  class SchoolsController < ApplicationController
    before_action :authenticate_user_or_school_owner!
    before_action :set_school, only: [:show, :edit, :update, :destroy]

    def index
      @schools = School.all
    end

    def show
    end

    def new
      @school = School.new
    end

    def edit
    end

    def create
      @school = School.new(school_params)

      if @school.save
        redirect_to admin_school_path(@school), notice: 'School was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @school.update(school_params)
        redirect_to admin_school_path(@school), notice: 'School was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @school.destroy
      redirect_to admin_schools_path, notice: 'School was successfully destroyed.'
    end

    private

    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(
        :name,
        :domain,
        :plan_id,
        :subscription_ends_at,
        features_enabled: []
      )
    end
  end
end 