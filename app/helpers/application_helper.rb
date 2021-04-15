module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "notice"
      type = "error"   if type == "alert"
      type = "warning" if type == "danger"
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text if message
    end
    flash_messages.join("\n")
  end

  def number_to_percent value, sum
    sum.zero? ? 0 : ((value / sum.to_f) * 100).round(0)
  end

  def task_of_course course
    Task.of_subjects course.subject_ids
  end

  def user_task_finished course, user
    UserSubject.task_by_course course, user
  end

  def status_user_subject user_subject
    return I18n.t("status_user_subject.joined") if user_subject.joined?
    return I18n.t("status_user_subject.active") if user_subject.active?

    I18n.t("status_user_subject.finished")
  end

  def status_user_course user_course
    return I18n.t("status_user_course.joined") if user_course.joined?
    return I18n.t("status_user_course.active") if user_course.active?

    I18n.t("status_user_course.finished")
  end

  def status_course_subject_bg course_subject
    return "bg-primary" if course_subject.joined?
    return "bg-info" if course_subject.active?

    "bg-success"
  end

  def status_course_subject_item course_subject
    return "list-group-item-primary" if course_subject.joined?
    return "list-group-item-info" if course_subject.active?

    "list-group-item-success"
  end

  def course_subject_status_badge course_subject
    return "badge badge-primary" if course_subject.joined?
    return "badge badge-info" if course_subject.active?

    "badge badge-success"
  end

  def status_stask_trainee user_task
    return "list-group-item-dark" if user_task.inprogess?
    return "list-group-item-success" if user_task.finished?

    "list-group-item-danger"
  end
end
