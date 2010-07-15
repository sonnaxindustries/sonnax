class SolenoidsController < ApplicationController
  def new
    @solenoid = SolenoidProgram.new
  end
  
  def thanks
  end

  def create
    begin
      @solenoid = SolenoidProgram.new(params[:solenoid])
      @solenoid.save!
      flash_and_redirect(thanks_solenoid_path, '')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
end
