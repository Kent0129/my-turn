class Admin::TurnsController < ApplicationController
  before_action :admin_user

  def index
    @turns = Turn.all
  end

  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
