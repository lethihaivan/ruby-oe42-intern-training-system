class SupervisorController < ApplicationController
  before_action :logged_in?, :require_supervisor

  private

  def require_supervisor
    return if current_user.supervisor?

    flash[:success] = t "session.new.not_access"
    redirect_to supervisor_course_path
  end
end
