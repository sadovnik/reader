# == Schema Information
#
# Table name: sources
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  type        :integer
#  url         :string
#  site_url    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Source < ApplicationRecord
  alias_attribute :subscribers, :users

  has_many :posts
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
