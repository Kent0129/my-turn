class TurnsController < ApplicationController

  def index
    @now = Turn.where(status: 1).first
    @wait = Turn.where(status: 0)
    @absence = Turn.where(status: 2)
    @wait_people = Turn.where(status: 0).count
    @absence_people = Turn.where(status: 2).count
  end
  
end
