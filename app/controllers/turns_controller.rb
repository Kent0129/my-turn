class TurnsController < ApplicationController
  before_action :now_status, only: [:index, :show]
  before_action :today_create, only:[:index, :show, :new]
  before_action :set_turn, only: [:update, :show]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :admin_check, only: [:update]
  before_action :qrcode, only:[:show]

  def index
    @wait = @today.where(status: "待ち")
    @absence = @today.where(status: "不在")
  end


  def new
    @examinations = Turn.new
    @today_num_end = @today.maximum(:number)
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
    @myturn = @today.where(status: "診察").ids.index(@turn.id)
    @end = @today.where(status: "終了").ids.include?(@turn.id)
    @count = @today.where(status: "待ち").ids.index(@turn.id)
    @absence = @today.where(status: "不在").ids.include?(@turn.id)
  end

  private
  def turn_params
    params.permit(:name, :number, :status ).merge(user_id: current_user.id)
  end

  def set_turn
    @turn = Turn.find(params[:id])
  end

  def today_create
    @today = Turn.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def now_status
    @today = Turn.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @now = @today.where(status: "診察").first
    @wait_people = @today.where(status: "待ち").count
    @absence_people = @today.where(status: "不在").count
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
