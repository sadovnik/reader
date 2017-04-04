class InvitesController < ApplicationController
  layout 'site'

  # GET /
  def new
    redirect_to(feed_path) if logged_in?

    @invite = Invite.new
  end

  # POST /invites
  def create
    return redirect_to action: :bummer if invite_created_recently?

    @invite = Invite.new(invite_params)

    if @invite.save
      InviteMailer.invite(@invite).deliver
      return redirect_to action: :done
    end

    render :new
  end

  # GET /invites/done
  def done
  end

  # GET /invites/bummer
  def bummer
  end

  # GET /invites/:key/use
  def use
    invite = Invite.find_by_key!(key_param)
    invite.use!

    @user = User.find_by_email(invite.email)

    flash.notice = @user ? 'Welcome back!' : 'Welcome!'

    @user = User.create!(email: invite.email) unless @user

    login(@user)

    redirect_to(feed_path)
  rescue ActiveRecord::RecordNotFound
    render :not_found, status: 404
  rescue StateMachines::InvalidTransition
    render :already_used, status: 409
  end

  private

  def key_param
    params.require(:key)
  end

  def invite_params
    params.require(:invite).permit(:email)
  end

  def invite_created_recently?
    Invite.where(
      'created_at > ? and state = ?',
      2.minutes.ago,
      Invite::States::UNUSED
    ).exists?
  end
end
