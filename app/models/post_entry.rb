class PostEntry < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum status: [ :unread, :read ]
end
