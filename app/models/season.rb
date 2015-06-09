class Season < ActiveRecord::Base
        has_many :seasonassociations
        has_many :players, through: :seasonassociations

end
