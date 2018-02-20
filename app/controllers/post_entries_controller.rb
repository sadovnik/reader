class PostEntriesController < ApplicationController
  before_action :authorize!

  # GET /feed
  def index
    @entries = current_user.unread_entries
  end

  # GET /favorites
  def index_favorite
    @entries = current_user.entries.where(favorite_status: :favorite)
  end

  # PUT /feed/entries/:id/status
  def update_status
    @entry = PostEntry.find(entry_params[:id])

    return head :forbidden if @entry.user_id != current_user.id

    @entry.tap do |entry|
      entry.status = entry_params[:status] || 'read'
      entry.save!
    end

    respond_to do |format|
      format.js
      format.html { redirect_to feed_path, flash: { notice: "Entry was marked as #{@entry.status}." } }
    end
  end

  # PUT /feed/entries/:id/favorite_status
  def update_favorite_status
    @entry = PostEntry.find(entry_params[:id])

    return head :forbidden if @entry.user_id != current_user.id

    @entry.tap do |entry|
      entry.favorite_status = entry_params[:favorite_status]
      entry.save!
    end

    respond_to do |format|
      format.js
      format.html { redirect_to feed_path, flash: { notice: "Entry was marked as #{@entry.favorite_status}." } }
    end
  end

  # PUT /feed/entries/status
  def mark_all_read
    entries_to_mark_all_read.mark_read!

    redirect_to feed_path, flash: { notice: 'All entries marked as read.' }
  end

  private

  def entries_to_mark_all_read
    entries = current_user.post_entries

    if params[:except_favorites]
      entries.not_favorite
    else
      entries
    end
  end

  def entry_params
    params.permit(:id, :status, :favorite_status)
  end
end
