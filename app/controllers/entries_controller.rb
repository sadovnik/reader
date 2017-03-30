class EntriesController < ApplicationController
  before_action :authorize!

  # GET /feed
  def index
    @entries = current_user.entries
  end
end
