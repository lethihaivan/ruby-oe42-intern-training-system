class Trainee::UserCoursesController < UsersController
  before_action :load_user_course, only: :show
  before_action :correct_user

  def show
    @course = @user_course.course
    @course_subjects = @course.course_subjects.includes :subject
    @trainees = @user_course.course.trainees.paginate page: params[:page],
      per_page: Settings.course.paginate.per_page
  end

  private

  def load_user_course
    @user_course = UserCourse.find_by id: params[:id]
    return if @user_course

    flash[:warning] = t("courses.subject.user_course_not_found")
    redirect_to root_path
  end

  def correct_user
    redirect_to root_url unless current_user? @user_course.user
  end
end
