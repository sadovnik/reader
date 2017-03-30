class SessionsController < ApplicationController
  before_action :authorize!

  # POST /logout
  def destroy
    logout
    flash.notice = 'See ya!'
    redirect_to(root_path)
  end
end
