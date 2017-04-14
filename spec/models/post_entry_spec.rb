# == Schema Information
#
# Table name: post_entries
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  status     :integer          default("0")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe PostEntry, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
