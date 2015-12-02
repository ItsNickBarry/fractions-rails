# == Schema Information
#
# Table name: plots
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  world_id   :integer          not null
#  x          :integer          not null
#  z          :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PlotTest < ActiveSupport::TestCase
  # test 'the truth' do
  #   assert true
  # end
end
