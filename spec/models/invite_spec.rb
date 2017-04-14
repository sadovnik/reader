# == Schema Information
#
# Table name: invites
#
#  id         :integer          not null, primary key
#  email      :string
#  key        :string
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Invite do
  describe '#save' do
    let(:invite) { Invite.new(email: 'some.guy@example.com') }

    it 'generates key validation' do
      expect(invite.key).to be_nil

      invite.valid?

      expect(invite.key).not_to be_nil
    end
  end
end
