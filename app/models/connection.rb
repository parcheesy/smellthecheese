class Connection < ActiveRecord::Base
        has_many :apps
        has_many :players
end
