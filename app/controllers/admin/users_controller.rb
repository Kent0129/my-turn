class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @turns = Turn.all.order("created_at DESC")
  end

  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
