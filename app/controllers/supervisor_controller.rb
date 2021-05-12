class SupervisorController < ApplicationController
  before_action :logged_in?

  private

  def current_ability
    @current_ability ||=
      Ability.new(current_user, Settings.controller.namespace_for_supervisor)
  end
end
