require 'securerandom'

class Invite < ApplicationRecord
  module States
    UNUSED = 0
    USED = 1
  end

  EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :email, :key, presence: true
  validates :email, format: { with: EMAIL_REGEXP }

  before_validation :generate_key

  state_machine :initial => :unused do
    state :unused, value: States::UNUSED
    state :used, value: States::USED

    event :use do
      transition :unused => :used
    end
  end

  private

  def generate_key
    self.key = SecureRandom.hex unless self.key
  end
end
