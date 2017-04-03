class PostEntriesController < ApplicationController
  before_action :authorize!

  # GET /feed
  def index
    @entries = current_user.entries
      .includes(:post, :post => :source)
      .where(status: :unread)
      .order('Posts.published_at DESC')
  end

  def read
    entry = PostEntry.find(id_param)

    entry.read!

    redirect_to entry.post.url
  end

  private

  def id_param
    params.require(:id)
  end
end
