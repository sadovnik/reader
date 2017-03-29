class InvitesController < ApplicationController
  # GET /
  def new
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
    invite = find_invite_by_key
    invite.use!

    @user = User.find_by_email(invite.email)

    @user = User.create!(email: invite.email) unless @user

    flash.notice = @user ? 'Welcome back!' : 'Welcome!'

    login(@user)

    # redirect_to somewhere
  rescue ActiveRecord::RecordNotFound
    render :not_found, status: 404
  rescue StateMachines::InvalidTransition
    render :already_used, status: 409
  end

  private

  def find_invite_by_key
    Invite.find_by_key!(key_param)
  end

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
