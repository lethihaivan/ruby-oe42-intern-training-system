class Supervisor::SubjectsController < ApplicationController
  before_action :load_users, only: %i(new)

  def new
    @subject = Subject.new
  end
end
