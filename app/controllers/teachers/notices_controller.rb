module Teachers
  class NoticesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :set_notice, only: [:show, :edit, :update, :destroy]

    def index
      @notices = @teacher.notices.order(created_at: :desc)
    end

    def new
      @notice = @teacher.notices.build
    end

    def create
      @notice = @teacher.notices.build(notice_params)

      if @notice.save
        redirect_to teachers_notice_path(@notice), notice: 'Notice was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      if @notice.update(notice_params)
        redirect_to teachers_notice_path(@notice), notice: 'Notice was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @notice.destroy
      redirect_to teachers_notices_path, notice: 'Notice was successfully deleted.'
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def set_notice
      @notice = @teacher.notices.find(params[:id])
    end

    def notice_params
      params.require(:notice).permit(:title, :content, :notice_type, :target_audience, school_class_ids: [])
    end
  end
end 