class Trainee::CourseSubjectsController < UsersController
  before_action :load_course_subject, :load_user_subject,
                :load_user_tasks, :load_subject, :load_tasks, only: :show

  def show; end

  private

  def load_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    return if @course_subject

    flash[:warning] = t("courses.subject.course_subject_not_found")
    redirect_to root_path
  end

  def load_user_subject
    @user_subject = current_user.user_subjects
                                .find_by course_subject_id: @course_subject.id
    return if @user_subject

    flash[:warning] = t("courses.subject.user_subject_not_found")
    redirect_to root_path
  end

  def load_user_tasks
    @user_tasks = @user_subject.user_tasks
    return if @user_tasks

    flash[:warning] = t("courses.subject.user_tasks_not_found")
    redirect_to root_path
  end

  def load_subject
    @subject = @course_subject.subject
  end

  def load_tasks
    @report_tasks = @subject.tasks.not_exit_in_user_task @user_subject
  end
end
