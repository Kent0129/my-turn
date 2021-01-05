class Admin::TurnsController < ApplicationController
  before_action :admin_user

  def index
    @turns = Turn.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
