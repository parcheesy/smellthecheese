class Article < ActiveRecord::Base
        has_many :assignments 
        has_many :apps, through: :assignments
end
