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
end
