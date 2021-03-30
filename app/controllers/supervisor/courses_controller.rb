class Supervisor::CoursesController < ApplicationController
  before_action :logged_in?, :require_supervisor
  before_action :load_course, except: %i(index new create)
  before_action :load_users_subjects, only: %i(new create)
  before_action :load_trainees, :load_course_subjects, only: :show

  def index
    @courses = Course.create_newest.paginate page: params[:page],
      per_page: Settings.course.paginate.per_page
  end

  def new
    @course = Course.new
  end

  def show; end

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

  def load_course
    @course = Course.includes(subjects: :tasks).find_by id: params[:id]
  end

  def load_users_subjects
    @subjects = Subject.ordered_by_name
    @users = User.ordered_by_name
  end

  def load_trainees
    @trainees = @course.trainees.paginate page: params[:page],
      per_page: Settings.user.paginate.per_page
  end

  def load_course_subjects
    @course_subjects = @course.course_subjects.includes(subject: :tasks)
                              .paginate page: params[:page],
                               per_page: Settings.user.paginate.per_page
  end
end
