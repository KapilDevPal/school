module Schools
  class NoticesController < ApplicationController
    before_action :authenticate_school_owner!
    before_action :check_feature_enabled
    before_action :set_notice, only: [:show, :edit, :update, :destroy]

    def index
      @notices = current_school.notices
    end

    def show
    end

    def new
      @notice = current_school.notices.build
    end

    def create
      @notice = current_school.notices.build(notice_params)

      if @notice.save
        redirect_to schools_notices_path, notice: 'Notice was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @notice.update(notice_params)
        redirect_to schools_notices_path, notice: 'Notice was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @notice.destroy
      redirect_to schools_notices_path, notice: 'Notice was successfully deleted.'
    end

    private

    def set_notice
      @notice = current_school.notices.find(params[:id])
    end

    def notice_params
      params.require(:notice).permit(:title, :content, :start_date, :end_date, :priority)
    end

    def check_feature_enabled
      unless feature_enabled?(:notices)
        redirect_to root_path, alert: 'Notices feature is not enabled for this school.'
      end
    end
  end
end 