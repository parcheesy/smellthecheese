class Player < ActiveRecord::Base
        has_many :seasonassociations
        has_many :seasons,  through: :seasonassociations 
        belongs_to :connection
        before_save :set_keywords
        after_create :set_totals
        
        #Search for position or name
        def self.search(namesearch, app_name)
                if namesearch.present?
                        #Checks for position match if app calls for it
                        if app_name=="position_shots"
                                where(position: namesearch)
                        #Checks for player name otherwise
                        else
                                where('keywords LIKE ?', "%#{namesearch.downcase}%")
                        end
                end                
        end
        
        #Create properly formatted percentage 
        #Should be moved out of model
        def self.sum_percents(num, denom)
                (sum(num)/sum(denom) * 100).to_f.round(2)
        end
        
        #Set career position based on last season's position
        def set_position
                self.update_attributes(position: seasons.last.position)
        end
        
        #Change height string into float
        def set_height_float
                h, f = height.split("-")
                f = f.to_f/12
                h = h.to_f
                val = h+f
                self.update_attributes(height_float:val) 
        end

        protected
                # Set search Terms
                def set_keywords
                        self.keywords = name.downcase
                end
                # Set total attempts and makes for each shot based on percentages
                def set_totals
                        if stat!="diff"
                                self.update_attributes({fga:fga_pg*games, fgm:fgm_pg*games})
                                totals_dist_att = {dist_0to3feet_fga:dist_0to3feet_percshots*fga, dist_3to10feet_fga:dist_3to10feet_percshots*fga, dist_10to16feet_fga:dist_10to16feet_percshots*fga, dist_16to3pt_fga:dist_16to3pt_percshots*fga, threept_fga:threept_percshots*fga, twopt_fga:twopt_perc_shots*fga}
                                self.update_attributes(totals_dist_att)
                                self.update_attributes({corner_fga:corner_perc3pt*threept_fga, non_corner_fga:(1-corner_perc3pt)*threept_fga})
                                totals_dist_made = {dist_0to3feet_fgm:dist_0to3feet_perc*dist_0to3feet_fga, dist_3to10feet_fgm:dist_3to10feet_perc*dist_3to10feet_fga, dist_10to16feet_fgm:dist_10to16feet_perc*dist_10to16feet_fga, dist_16to3pt_fgm:dist_16to3pt_perc*dist_16to3pt_fga, threept_fgm:threept_perc*threept_fga, twopt_fgm:twopt_perc*twopt_fga}
                                self.update_attributes(totals_dist_made)
                                self.update_attributes(corner_fgm:corner_perc*corner_fga) 
                                self.update_attributes(non_corner_fgm:threept_fgm-corner_fgm)
                        end
                end


end
