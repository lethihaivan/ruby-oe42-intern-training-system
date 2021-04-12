class SubjectsController < ApplicationController
  before_action :load_subject, except: %i(index new create subjects_by_ids)
  before_action :load_users, only: %i(new create edit update)
  before_action :load_tasks, :load_courses, only: :show

  def index
    @subjects = Subject.includes(:tasks).newest.paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end

  def show; end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    respond_to do |format|
      if @subject.save
        flash[:success] = t "subjects.subject.create_success"
        activity_log current_user, @subject, t("activities.create")
        redirect_to subject_path @subject
      else
        @ers = @subject.errors.full_messages
      end
      format.js
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @subject.update_attributes subject_params
        flash[:success] = t("subjects.subject.update_success")
        redirect_to subject_path @subject
      else
        @ers = @subject.errors.full_messages
      end
      format.js
    end
  end

  private

  def subject_params
    params.require(:subject).permit :name, :description, :time,
     tasks_attributes: [:id, :name, :_destroy]
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    @subject || redirect_with_format(t("subjects.not_found"))
  end

  def load_users
    @users = User.ordered_by_name
  end

  def load_tasks
    @tasks = @subject.tasks.newest.paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end

  def load_courses
    @courses = @subject.courses.newest.paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end
end
