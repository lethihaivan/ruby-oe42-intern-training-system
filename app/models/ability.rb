class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    alias_action :index, :show, to: :read
    alias_action :receive, :finish, to: :receive_finish_task
    case controller_namespace
    when Settings.controller.namespace_for_supervisor
      authorize_to_supervisor if user.supervisor?
    when Settings.controller.namespace_for_trainee
      authorize_to_trainee if user.trainee?
    end
  end

  private

  def authorize_to_supervisor
    can :manage, :all
  end

  def authorize_to_trainee
    can %i(read receive_finish_task), Task
    can :read, CourseSubject
    can :read, Course
    can :read, UserCourse
    can :finish, UserSubject
  end
end
