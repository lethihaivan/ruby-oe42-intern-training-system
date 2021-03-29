class Supervisor::CoursesController < ApplicationController
  before_action :logged_in?, :require_supervisor
  before_action :load_course, except: %i(index new create)

  def index
    @courses = Course.create_newest.paginate page: params[:page],
      per_page: Settings.course.paginate.per_page
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "courses.supervisor.create.add_success"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit :name, :time, :status, :start_date,
                                   :end_date, :image, subject_ids: []
  end

  def require_supervisor
    return if current_user.supervisor?

    flash[:success] = t "session.new.not_access"
    redirect_to root_path
  end
end
