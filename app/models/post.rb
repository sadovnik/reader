class Post < ApplicationRecord
  belongs_to :source, dependent: :destroy
  has_many :post_entries, dependent: :destroy

  def populize_entry(user)
    PostEntry.create!(post: self, user: user)
  end
end
