class Supervisor::CourseSubjectsController < SupervisorController
  before_action :authenticate_user!
  before_action :require_supervisor,
                :load_course_subject, :load_subject,
                :load_tasks

  def show; end

  def start
    cou_id = @course_subject.course_id
    if @course_subject.finished?
      flash[:danger] = t "course_subjects.not_accepted"
      return redirect_to supervisor_course_course_subject_path cou_id
    end
    update_when_supervisor_start_subject
  end

  def finish
    cou_id = @course_subject.course_id
    if @course_subject.finished?
      flash[:danger] = t "course_subjects.not_accepted"
      return redirect_to supervisor_course_course_subject_path cou_id
    end
    update_when_supervisor_finsh_subject
  end

  private

  def load_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    return if @course_subject

    flash[:warning] = t("courses.subject.course_subject_not_found")
    redirect_to root_path
  end

  def load_course
    @course = Course.find(params[:course_id])
    return if @course

    flash[:warning] = t("courses.subject.course_subject_not_found")
    redirect_to root_path
  end

  def load_subject
    @subject = @course_subject.subject
  end

  def load_tasks
    @tasks = @subject.tasks.newest.paginate page: params[:page],
      per_page: Settings.user.paginate.per_page
  end

  def update_course_subject course_subject
    dead_line = Time.current + course_subject.subject.time.days
    course_subject.update! start_date: Time.current,
                           end_date: dead_line, status: :active
    course_subject.user_subjects.each do |user_subject|
      user_subject.active!
      chage_status = proc{|n| n.inprogess!}
      user_subject.user_tasks.map(&chage_status)
    end
  end

  def transaction_finsh_subject course_subject
    course_subject.finished!
    chage_status = proc{|n| n.finished!}
    course_subject.user_subjects.map(&chage_status)
    course_subject.user_subjects.each do |u_s|
      u_s.user_tasks.each do |task|
        task.update! status: :finished, finish_at: Time.current
      end
    end
  end

  def update_when_supervisor_start_subject
    ActiveRecord::Base.transaction do
      update_course_subject @course_subject
    end
    flash[:success] = t "course_subjects.start_success"
  rescue StandardError
    flash[:danger] = t "user_subjects.start_fail"
  ensure
    respond_to do |format|
      format.html{redirect_to request.referer}
    end
  end

  def update_when_supervisor_finsh_subject
    ActiveRecord::Base.transaction do
      transaction_finsh_subject @course_subject
    end
    flash[:success] = t "course_subjects.finish_success"
  rescue StandardError
    flash[:danger] = t "user_subjects.finish_fail"
  ensure
    respond_to do |format|
      format.html{redirect_to request.referer}
    end
  end
end
