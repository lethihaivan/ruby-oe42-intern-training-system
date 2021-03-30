module CoursesHelper
  def load_coures_statuses
    @statuses = Course.statuses.keys
  end
end
