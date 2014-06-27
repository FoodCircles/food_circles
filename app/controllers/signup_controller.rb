class SignupController < ApplicationController
  def index
    enqueue_mix_panel_event "Visits Signup Sub Page"
  end
end
