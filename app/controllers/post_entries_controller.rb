class PostEntriesController < ApplicationController
  before_action :authorize!

  # GET /feed
  def index
    @entries = current_user.entries
      .includes(:post, :post => :source)
      .where(status: :unread)
      .order('Posts.published_at DESC')
  end
end
