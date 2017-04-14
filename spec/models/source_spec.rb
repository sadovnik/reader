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

require 'rails_helper'

describe Source, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
