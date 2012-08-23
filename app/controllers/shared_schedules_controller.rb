class SharedSchedulesController < ApplicationController
  def create
    ap params
    to_send = SharedSchedule.new
    
  end
end