class Trainee::CoursesController < UsersController
  authorize_resource :course
  def index
    @courses_active = current_user.user_courses.includes(:course).active
    @courses_joined = current_user.user_courses.includes(:course).joined
  end
end
