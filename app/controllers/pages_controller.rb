class PagesController < ApplicationController
  before_filter :load_or_create_user
  
  def index
    @user = @current_user
    ap @user
    @panelists = Panelist.all
  end

  def load_or_create_user
    user_identifier = request.fullpath.gsub(/\//,"")
    if user_identifier
      @current_user = User.find_by_identifier user_identifier
      return if @current_user
    end
    @current_user = User.new :identifier => User.generate_identifier
    if User.find_by_identifier(@current_user.identifier).nil?
      @current_user.schedule = Schedule.new
      @current_user.save!
    else
      load_or_create_user
    end
    flash[:welcome] = "Hi! Looks like it's your first time here.  Logging in sucks.  So just bookmark this page or remember the url.  Your unique identifier is #{@current_user.identifier}"
  end
end