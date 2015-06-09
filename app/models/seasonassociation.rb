class Seasonassociation < ActiveRecord::Base
        belongs_to :player
        belongs_to :season
end
