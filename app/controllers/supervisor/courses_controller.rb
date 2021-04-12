class Supervisor::CoursesController < ApplicationController
  before_action :logged_in?, :require_supervisor
  before_action :load_course, except: %i(index new create)
  before_action :load_users_subjects, only: %i(new create edit update)
  before_action :load_trainees, :load_course_subjects, only: :show
  before_action :check_avalible_course, only: :add_trainee
  before_action :check_trainee_on_course, only: :delete_trainee

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
      redirect_to supervisor_courses_path
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

  def start
    if @course.open?
      update_when_start_course
    else
      flash[:warning] = t "courses.supervisor.start_course_not_allow"
    end
    respond_to do |format|
      format.html{redirect_to request.referer}
    end
  end

  def finish
    if @course.start?
      update_when_finish_course
    else
      flash[:warning] = t "courses.supervisor.finish_course_not_allow"
    end
    respond_to do |format|
      format.html{redirect_to request.referer}
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
    render json: {success: t("courses.add_trainee_success")}
  rescue StandardError
    flash[:error] = t "alert.erros"
  ensure
    respond_to do |format|
      format.html
      format.js
    end
  end

  def delete_trainee
    ActiveRecord::Base.transaction do
      destroy_trainee = proc{|n| n.destroy!}
      @course.course_subjects.each do |course_subject|
        course_subject.user_subjects
                      .by_user(@trainee.user_id).map(&destroy_trainee)
      end
      @trainee.destroy!
    end
    render json: {success: t("courses.delete_trainee_success")}
  rescue StandardError
    flash[:error] = t "alert.erros"
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

  def check_trainee_on_course
    @trainee = UserCourse.find_by user_id: params[:user_id],
                                  course_id: @course.id
    return if @trainee

    flash[:warning] = t("courses.supervisor.load_course.trainee_course?")
    redirect_to supervisor_courses_path
  end

  def update_when_start_course
    ActiveRecord::Base.transaction do
      cou_sub_ids = @course.course_subjects
                           .pluck(:id)
                           .map{|id| {course_subject_id: id, status: :joined}}
      @course.start!
      chage_status = proc{|n| n.active!}
      @course.user_courses.map(&chage_status)
      @course.trainees.each do |trainee|
        trainee.user_subjects.create! cou_sub_ids
      end
    end
    flash[:success] = t("courses.supervisor.start_success")
  rescue StandardError
    flash[:danger] = t("courses.supervisor.start_fail")
  end

  def update_when_finish_course
    ActiveRecord::Base.transaction do
      @course.finished!
      chage_status = proc{|n| n.finished!}
      @course.course_subjects.map(&chage_status)
      @course.course_subjects.each do |course_subject|
        course_subject.user_subjects.map(&chage_status)
        course_subject.user_subjects.each do |user_subject|
          user_subject.user_tasks.map(&chage_status)
        end
      end
    end
    flash[:success] = t "courses.supervisor.finish_course_sussccess"
  rescue StandardError
    flash[:danger] = t "courses.supervisor.finish_course_fail"
  end
end
