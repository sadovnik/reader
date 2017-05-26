# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  internal_id  :string
#  title        :string
#  summary      :string
#  url          :string
#  source_id    :integer
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :source
  has_many :post_entries, dependent: :destroy

  def populize_entry(user)
    PostEntry.create!(post: self, user: user)
  end
end
