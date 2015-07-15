require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'keywords set before save' do
    player = FactoryGirl.build(:player)
    player.save
    assert_equal 'michael jordan', player.keywords
  end

  test 'totals set after create' do
    player = FactoryGirl.create(:player)
    assert_equal (player.dist_0to3feet_percshots * player.fga), player.dist_0to3feet_fga
  end

  test 'sum_percents returns percent from numerator and denominator' do
    assert_equal 28.99, Player.sum_percents(245, 845.0)
  end

  test 'set_position' do
    player = FactoryGirl.create(:player_with_seasons)
    player.set_position
    assert_equal player.position, player.seasons.last.position
  end

  test 'search for name' do
    player =  FactoryGirl.create(:player)
    assert_equal player, Player.search("michael jordan", "test").first  
  end

  test 'search for position' do
    player = FactoryGirl.create(:player_with_seasons)
    player.set_position
    assert_equal player, Player.search("C", "position_shots").first
  end
end
