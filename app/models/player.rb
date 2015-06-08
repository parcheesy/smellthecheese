class Player < ActiveRecord::Base
        has_many :seasons
        belongs_to :connection
        before_save :set_keywords
        
        def self.search(namesearch)
                if namesearch.present?
                        where('keywords LIKE ?', "%#{namesearch.downcase}%")
                end                

        end

        protected
                def set_keywords
                        self.keywords = name.downcase
                end
end
