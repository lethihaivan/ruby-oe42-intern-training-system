class Supervisor::CoursesController < ApplicationController
  before_action :logged_in?, :require_supervisor
  before_action :load_course, except: %i(index new create)
  before_action :load_users_subjects, only: %i(new create edit update)
  before_action :load_trainees, :load_course_subjects, only: :show
  before_action :check_avalible_course, only: :add_trainee
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

  def edit; end

  def update
    if @course.update course_params
      flash[:success] = t("courses.supervisor.update.success")
      redirect_to supervisor_courses_path
    else
      flash.now[:danger] = t("courses.supervisor.update.fail")
      render :edit
    end
  end

  def assign_trainee
    @users = User.not_exit_on_course(@course).paginate page: params[:page],
      per_page: Settings.course.paginate.per_page
    respond_to do |format|
      format.js
    end
  end

  def add_trainee
    trainee_ids = params[:trainee_ids]
    ActiveRecord::Base.transaction do
      trainee_ids.each do |trainee_id|
        @course.user_courses.create! user_id: trainee_id
      end
    end
    render json: User.by_ids(trainee_ids).select(:id, :name)
  rescue StandardError
    flash[:error] = t "alert.erros"
  ensure
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def check_avalible_course
    return if @course.open?

    flash[:warning] = t("courses.supervisor.load_course.check_open?")
    redirect_to root_path
  end

  def course_params
    params.require(:course).permit :name, :time, :status, :start_date,
                                   :end_date, :image, subject_ids: []
  end

  def require_supervisor
    return if current_user.supervisor?

    flash[:success] = t "session.new.not_access"
    redirect_to supervisor_course_path
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
