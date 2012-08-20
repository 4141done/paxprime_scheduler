class PagesController < ApplicationController
  def index
    @panelists = Panelist.all
  end

end