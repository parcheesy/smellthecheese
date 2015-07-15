require 'test_helper'

class SectorTest < ActiveSupport::TestCase

  test 'keywords set upon save' do
    sector = FactoryGirl.create(:sector)
    assert_equal 'healthcare', sector.keywords
  end

  test 'search based on sector' do
    sector = FactoryGirl.create(:sector)
    assert_equal sector, Sector.search('healthcare', 'test').first
  end

end
