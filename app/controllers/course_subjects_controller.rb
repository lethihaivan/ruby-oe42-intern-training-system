class CourseSubjectsController < ApplicationController
  before_action :load_course_subject, :load_subject, :load_tasks, :load_courses

  def show; end

  private

  def load_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    return if @course_subject

    flash[:warning] = t("courses.subject.course_subject_not_found")
    redirect_to root_path
  end

  def load_subject
    @subject = @course_subject.subject
  end

  def load_tasks
    @tasks = @subject.tasks.newest.paginate page: params[:page],
      per_page: Settings.course.paginate.per_page
  end

  def load_courses
    @courses = @subject.courses.paginate page: params[:page],
      per_page: Settings.course.paginate.per_page
  end
end
