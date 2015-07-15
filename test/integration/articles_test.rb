require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest
   test "the truth" do
     article1 = FactoryGirl.create(:article)
     article2 = FactoryGirl.create(:article)
     article3 = FactoryGirl.create(:article)
     visit '/'
     visit '/about'
     assert true
   end
end
