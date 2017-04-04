class InviteMailer < ApplicationMailer
  def invite(invite)
    @invite = invite
    mail(to: @invite.email, subject: 'Invite to Reader')
  end
end
