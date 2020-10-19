class TurnsController < ApplicationController

  def index
    @now = Turn.where(status: 1).first
    @wait = Turn.where(status: 0)
    @absence = Turn.where(status: 2)
    @wait_people = Turn.where(status: 0).count
    @absence_people = Turn.where(status: 2).count
  end


  def new
    @examinations = Turn.new
    @today_num_end = Turn.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).maximum(:number)
    @next_num =  @today_num_end + 1
  end

  def create
    @turn = Turn.new(turn_params)
    if @turn.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def turn_params
    params.permit(:name, :number, :status)
  end

end
