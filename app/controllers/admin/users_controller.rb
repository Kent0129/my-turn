class Admin::UsersController < ApplicationController

  def index
    @turns = Turn.all.order("created_at DESC")
  end

end
