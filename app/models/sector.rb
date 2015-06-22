class Sector < ActiveRecord::Base
        belongs_to :connection
        before_save :set_keywords

        def self.search(namesearch, app_name)
                if namesearch.present?
                                where('keywords LIKE ?', "%#{namesearch.downcase}%")
                end                
        end

protected

        def set_keywords
                self.keywords = sector.downcase
        end

end
