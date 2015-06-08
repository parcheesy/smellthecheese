class App < ActiveRecord::Base
        has_many :assignments 
        has_many :articles, through:  :assignments
        belongs_to :connection
end
