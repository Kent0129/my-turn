class Admin::TurnsController < ApplicationController
  before_action :admin_check, only: [:index, :update]
  before_action :turn_params, only: [:index, :update]
  def index
    @turns = Turn.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def update
    @turn = Turn.find(params[:id])
    respond_to do |format|
      if @turn.update(turn_params)
        format.html 
        format.js 
      end
    end
  end

  private
  def turn_params
    params.permit(:name, :number, :status ).merge(user_id: current_user.id)
  end

  def admin_check
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
