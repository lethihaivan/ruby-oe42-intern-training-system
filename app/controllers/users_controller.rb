class UsersController < ApplicationController
  before_action :user_signed_in?, only: :show
  def show; end

  private

  def current_ability
    @current_ability ||=
      Ability.new(current_user, Settings.controller.namespace_for_trainee)
  end
end
