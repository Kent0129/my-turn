class TurnsController < ApplicationController
  before_action :now_status, only: [:index, :show]
  before_action :set_turn, only: [:update, :show]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :admin_check, only: [:update]
  before_action :qrcode, only:[:show]

  def index
    @wait = Turn.where(status: 0)
    @absence = Turn.where(status: 2)
  end


  def new
    @examinations = Turn.new
    @today_num_end = Turn.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).maximum(:number)

  end

  def create
    @turn = Turn.new(turn_params)
    if @turn.save
      require 'rqrcode'
      text = turn_path(@turn.id)
      @qr = RQRCode::QRCode.new(text).as_svg.html_safe
      render :create
    else
      render :new
    end
  end

  def update
    @turn.update(turn_params)
  end

  def show
  end

  private
  def turn_params
    params.permit(:name, :number, :status ).merge(user_id: current_user.id)
  end

  def set_turn
    @turn = Turn.find(params[:id])
  end

  def now_status
    @now = Turn.where(status: 1).first
    @wait_people = Turn.where(status: 0).count
    @absence_people = Turn.where(status: 2).count
  end

  def admin_check
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def qrcode
    require 'rqrcode'
    text = turn_path(@turn.id)
    @qr = RQRCode::QRCode.new(text).as_svg.html_safe
  end

end
