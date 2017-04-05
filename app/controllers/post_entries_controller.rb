class PostEntriesController < ApplicationController
  before_action :authorize!

  # GET /feed
  def index
    @entries = current_user.entries
      .includes(:post, :post => :source)
      .where(status: :unread)
      .order('Posts.published_at DESC')
  end

  # PUT /feed/entries/:id/status
  def update_status
    @entry = PostEntry.find(entry_params[:id])

    return head :forbidden if @entry.user_id != current_user.id

    @entry.status = entry_params[:status] || 'read'

    @entry.save!

    respond_to do |format|
      format.js
      format.html { redirect_to feed_path, flash: { notice: "Entry marked as #{@entry.status}." } }
    end
  end

  # PUT /feed/entries/status
  def mark_all_read
    current_user.post_entries.update_all(status: :read)

    redirect_to feed_path, flash: { notice: 'All entries marked as read.' }
  end

  private

  def entry_params
    params.permit(:id, :status)
  end
end
