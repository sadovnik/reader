class PostEntriesController < ApplicationController
  before_action :authorize!

  # GET /feed
  def index
    @entries = current_user.entries
      .includes(:post, :post => :source)
      .where(status: :unread)
      .order('Posts.published_at DESC')
  end

  # PUT /post_entries/:id/status
  def update_status
    @entry = PostEntry.find(entry_params[:id])

    @entry.status = entry_params[:status] || 'read'

    @entry.save!

    respond_to do |format|
      format.js {}
      format.html { redirect_to feed_path, flash: { notice: "Entry marked as #{@entry.status}." } }
    end
  end

  private

  def entry_params
    params.permit(:id, :status)
  end
end
