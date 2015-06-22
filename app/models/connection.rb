class Connection < ActiveRecord::Base
        has_many :apps
        has_many :players
        has_many :sectors
end
