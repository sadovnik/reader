class InviteMailer < ApplicationMailer
  default from: 'invites@example.com'

  def invite(invite)
    @invite = invite
    mail(to: @invite.email, subject: 'Invite to Reader')
  end
end
