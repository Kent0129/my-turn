class Admin::TurnsController < ApplicationController
  before_action :admin_user

  def index
    @turns = User.all.order("created_at DESC")
  end

  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
