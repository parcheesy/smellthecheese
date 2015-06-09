Article.destroy_all
App.destroy_all
Player.destroy_all
Season.destroy_all
Assignment.destroy_all
Connection.destroy_all

players = ActiveSupport::JSON.decode(File.read("jsons/playoff_players.json"))
seasons = ActiveSupport::JSON.decode(File.read("jsons/player_playoff_seasons.json"))

#Create players
Player.create!(players)

p "Created #{Player.count} players"

#Create seasons
Season.create!(seasons)

p "Created #{Season.count} seasons"

#Associate seasons to players
all_seasons = Season.all
all_seasons.each do |season|
        season.update(player: Player.where(name: season.name).first)
end

p "Added #{Season.where.not(player_id: nil).count} seasons to players"

#Add Articles
article = Article.create(title: "NBA Player Performance: Regular Season vs Playoffs", date: "June 3, 2015", body: "<p>Every year when the NBA playoffs arrive, pundits often repeat the idea that playoff basketball is a different beast. That opinion is especially common among former players and coaches, but is also echoed by most writers and fans of the game. The difference is attributed to a number of factors including: slower pace, more physicality, more defensive effort, pressure from the spotlight, and improved game planning when playing the same team repeatedly. But analysts that rely on statistical measures usually make predictions based on the regular season. That's reasonable because the most recent data available about the particular teams in the playoffs comes from the regular season.</p>
<p>But that means there's a disconnect between what most people readily accept as an inherent characteristic of the playoffs and the way analysts use the regular season to predict playoff results. I wanted to explore the numbers to try to identify whether the difference that is often felt when playing or watching playoff basketball shows up in the statistics. And if it does show up, what areas of the game it affects the most.</p>
<p>There will be a lot of steps in this process, but I figured that a good starting point (or the point that was easiest for me to start at) would be allowing myself and others to easily evaluate how individual players performed in the regular season versus the playoff. The above application offers just that. Type in the name of a player and see how his career regular season stats compare to his career playoff stats. As of now it only includes data from players currently in the NBA who have played in the playoffs. More on this topic to come!</p>")

app = App.create(name: "PlayoffvsRegularSeason", position: "top", object: "Player", cssid: "playoff_regular_app", citation: "Image and statistics from basketball-reference.com", html:"
        <% player=Player.where(name:'Stephen Curry').first %>

        <form accept-charset='UTF-8' action='/apps' method='get' class='special-submit' data-remote='true'>
          <div id='bloodhound'>
          <input type='hidden' name='appid' value='<%=app.id%>'>
          <input type='text' id='name-form'  class='form-control typeahead' value='<%= params[:namesearch] %>' name='namesearch' placeholder='Enter Player Name' autocomplete='off' >
          <input type='submit' value='Submit' style='display:none' >
          </div>
        </form>
                        <div class='col-sm-6 col-xs-12 text-center' id='player-wrapper'>
                                <h3><%=player.name%></h3>
                                <%= image_tag(player.image, id:'player_image') %>
                        </div>
                        <div id='table-container' class='col-sm-6 col-xs-12'>
                                <table id='stats' class='table table-bordered table-hover table-condensed table-responsive'>
                                        <thead>
                                                <tr>
                                                        <th>Career Stats</th>
                                                        <th>Regular Season</th>
                                                        <th>Postseason</th>
                                                        <th>Difference</th>
                                                </tr>
                                        </thead>
                                        <tbody>
                                                <tr id='mpg'>
                                                        <td>MPG</td>
                                                        <td class='reg_season'><%=player.minutes_pg%></td>
                                                        <td class='post_season'><%=player.playoff_minutes_pg%></td>
                                                        <% if player.diff_minutes_pg >= 0 %>
                                                        <td class='difference positive'><%=player.diff_minutes_pg%></td>
                                                        <% else %>
                                                        <td class='difference'><%=player.diff_minutes_pg%></td>
                                                        <% end %>

                                                </tr>

                                                <tr id='ppg'>
                                                        <td>PPG</td>
                                                        <td class='reg_season'><%=player.pts_pg%></td>
                                                        <td class='post_season'><%=player.playoff_pts_pg%></td>
                                                        <% if player.diff_pts_pg >= 0 %>
                                                        <td class='difference positive'><%=player.diff_pts_pg%></td>
                                                        <% else %>
                                                        <td class='difference negative'><%=player.diff_pts_pg%></td>
                                                        <% end %>

                                                </tr>
                                                <tr id='fg_perc'>
                                                        <td>FG%</td>
                                                        <td class='reg_season'><%=BigDecimal(player.fg_perc) * 100%>%</td>
                                                        <td class='post_season'><%=BigDecimal(player.playoff_fg_perc) * 100%>%</td>
                                                        <% if player.diff_fg_perc >= 0 %>
                                                        <td class='difference positive'><%=BigDecimal(player.diff_fg_perc) * 100%>%</td>
                                                        <% else %>
                                                        <td class='difference negative'><%=BigDecimal(player.diff_fg_perc) * 100%>%</td>
                                                        <% end %>

                                                </tr>
                                                <tr id='three_fg_perc'>
                                                        <td>3ptFG%</td>
                                                        <td class='reg_season'><%=BigDecimal(player.threept_perc) * 100%>%</td>
                                                        <td class='post_season'><%=BigDecimal(player.playoff_threept_perc) * 100%>%</td>
                                                        <% if player.diff_threept_perc >= 0 %>
                                                        <td class='difference positive'><%=BigDecimal(player.diff_threept_perc) * 100%>%</td>
                                                        <% else %>
                                                        <td class='difference negative'><%=BigDecimal(player.diff_threept_perc) * 100%>%</td>
                                                        <% end %>

                                                </tr>
                                                <tr id='apg'>
                                                        <td>APG</td>
                                                        <td class='reg_season'><%=player.ast_pg%></td>
                                                        <td class='post_season'><%=player.playoff_ast_pg%></td>
                                                        <% if player.diff_ast_pg >= 0 %>
                                                        <td class='difference positive'><%=player.diff_ast_pg%></td>
                                                        <% else %>
                                                        <td class='difference negative'><%=player.diff_ast_pg%></td>
                                                        <% end %>
                                                </tr>
                                               <tr id='topg'>
                                                        <td>TOPG</td>
                                                        <td class='reg_season'><%=player.to_pg%></td>
                                                        <td class='post_season'><%=player.playoff_to_pg%></td>                         
                                                        <% if player.diff_to_pg >= 0 %>
                                                        <td class='difference positive'><%=player.diff_to_pg%></td>
                                                        <% else %>
                                                        <td class='difference negative'><%=player.diff_to_pg%></td>
                                                        <% end %>
                                               </tr>
                                       </tbody>
                                </table>
                        </div>", js: "
                        
                        <%if @app_objects%>
                                $('#player-wrapper h3').text('<%= @app_objects.first.name %>');
                                $('img#player_image').attr('src', '<%= asset_path(\"ajax-loader.gif\") %>');
                                $('img#player_image').attr('src', '<%= @app_objects.first.image %>');
                                <% @rows = ['mpg', 'ppg', 'fg_perc', 'three_fg_perc', 'apg', 'topg'] %>
                                <% @stats = ['minutes_pg', 'pts_pg', 'fg_perc', 'threept_perc', 'ast_pg', 'to_pg'] %>
                                <% @rows.zip(@stats).each do |row, stat| %>
                                        <% if row == 'fg_perc' || row == 'three_fg_perc' %>
                                                $('tr#' + '<%=row%>' + ' .reg_season').text('<%= BigDecimal(@app_objects.first.send(stat)) * 100 %>%');
                                                $('tr#' + '<%=row%>' + ' .post_season').text('<%= BigDecimal(@app_objects.first.send(\"playoff_\" + stat)) * 100%>%');
                                                $('tr#' + '<%=row%>' + ' .difference').text('<%= BigDecimal(@app_objects.first.send(\"diff_\" + stat)) * 100%>%');
                                              
                                        <% else %>
                        
                                                $('tr#' + '<%=row%>' + ' .reg_season').text('<%= @app_objects.first.send(stat) %>');
                                                $('tr#' + '<%=row%>' + ' .post_season').text('<%= @app_objects.first.send(\"playoff_\" + stat)%>');
                                                $('tr#' + '<%=row%>' + ' .difference').text('<%= @app_objects.first.send(\"diff_\" + stat)%>');
                                        <% end %>
                                        <% if @app_objects.first.send('diff_' + stat) >= 0 %>
                                        $('tr#' + '<%=row%>' + ' .difference').addClass('positive');
                                        <% else %>
                                        $('tr#' + '<%=row%>' + ' .difference').removeClass('positive');
                                        <% end %>
                        
                        
                                <% end %>
                                $('#mpg .reg_season')
                                $('#name-form').val('');
                                $('.typeahead').typeahead('val', '');
                        <%end%>
                        ")


Assignment.create(app: app, article: article)

p "Loaded #{Article.count} articles with #{Assignment.count} assignments to #{App.count} apps"

#Add objects to apps
App.all.each do |app|

        c = Connection.create(name: "#{app.name} app to #{app.object}s")
        app.update(connection:c)
        Player.all.each do |player|
                player.update(connection:c)         
        end

end

p "Created #{Connection.count} connections between #{App.count} apps and #{Player.count} objects"
