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

require 'rails_helper'

describe Post, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
