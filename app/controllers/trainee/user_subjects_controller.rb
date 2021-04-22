class Trainee::UserSubjectsController < UsersController
  before_action :load_user_subject, :correct_user

  def finish
    user_subject = @user_subject.course_subject
    if @user_subject.joined? || @user_subject.finished?
      flash[:danger] = t "user_subjects.not_active_finished"
      return redirect_to trainee_course_subject_path user_subject
    end
    update_finish_user_subject @user_subject
  end

  private

  def load_user_subject
    @user_subject = UserSubject.find_by id: params[:id]
    return if @user_subject

    flash[:warning] = t("courses.supervisor.load_course.check_open?")
    redirect_to root_path
  end

  def correct_user
    redirect_to root_path unless current_user? @user_subject.user
  end

  def update_finish_user_subject user_subject
    UserSubject.transaction do
      user_subject.finished!
      user_subject.user_tasks.each do |user_task|
        user_task.finished!
        user_task.update! finish_at: Time.current
      end
    end
    flash[:success] = t "user_subjects.finish_success"
  rescue StandardError
    flash[:danger] = t "user_subjects.finish_fail"
  ensure
    redirect_to trainee_course_subject_path @user_subject.course_subject
  end
end
