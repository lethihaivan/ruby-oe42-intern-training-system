class Trainee::CoursesController < UsersController
  def index
    @courses_active = current_user.user_courses.includes(:course).active
    @courses_joined = current_user.user_courses.includes(:course).joined
  end
end
