# == Schema Information
#
# Table name: post_entries
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  status     :integer          default("unread")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorite   :integer          default(0)
#

class PostEntry < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum status: [ :unread, :read ]
  enum favorite_status: [ :not_favorite, :favorite ]
end
