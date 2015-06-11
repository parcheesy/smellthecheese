Article.destroy_all
App.destroy_all
Player.destroy_all
Season.destroy_all
Assignment.destroy_all
Connection.destroy_all
Seasonassociation.destroy_all

players = ActiveSupport::JSON.decode(File.read("jsons/better_playoff_players.json"))
seasons = ActiveSupport::JSON.decode(File.read("jsons/better_player_playoff_seasons.json"))

#Create players
Player.create!(players)

p "Created #{Player.count} players"

#Create seasons
Season.create!(seasons)

p "Created #{Season.count} seasons"

#Associate seasons to players
all_seasons = Season.all
all_seasons.each do |season|
        every_player = Player.where(name: season.name)
        every_player.each do |player|
               Seasonassociation.create(player: player, season: season) 
        end
end
Player.all.each do |p|
        p.set_position
        p.set_height_float
end

p "Added #{Seasonassociation.count} season to player association"

#Add Articles
article1 = Article.create(title: "NBA Player Performance: Regular Season vs Playoffs", date: "June 3, 2015", body: "<p>Every year when the NBA playoffs arrive, pundits often repeat the idea that playoff basketball is a different beast. That opinion is especially common among former players and coaches, but is also echoed by most writers and fans of the game. The difference is attributed to a number of factors including: slower pace, more physicality, more defensive effort, pressure from the spotlight, and improved game planning when playing the same team repeatedly. But analysts that rely on statistical measures usually make predictions based on the regular season. That's reasonable because the most recent data available about the particular teams in the playoffs comes from the regular season.</p>
<p>But that means there's a disconnect between what most people readily accept as an inherent characteristic of the playoffs and the way analysts use the regular season to predict playoff results. I wanted to explore the numbers to try to identify whether the difference that is often felt when playing or watching playoff basketball shows up in the statistics. And if it does show up, what areas of the game it affects the most.</p>
<p>There will be a lot of steps in this process, but I figured that a good starting point (or the point that was easiest for me to start at) would be allowing myself and others to easily evaluate how individual players performed in the regular season versus the playoff. The above application offers just that. Type in the name of a player and see how his career regular season stats compare to his career playoff stats. As of now it only includes data from players currently in the NBA who have played in the playoffs. More on this topic to come!</p>")

app1 = App.create(name: "player_career_playoffs_vs_regular", position: "top", object: "Player", cssid: "playoff_regular_app", citation: "Image and statistics from basketball-reference.com", html:"
        <% players=Player.where(name:'Stephen Curry') %>
        <% player_regular = players.where(stat:'regular').first %>
        <% player_playoff = players.where(stat:'playoff').first %>
        <% player_diff = players.where(stat:'diff').first %>

        <form accept-charset='UTF-8' action='/apps' method='get' class='special-submit' data-remote='true'>
          <div id='bloodhound'>
          <input type='hidden' name='appid' value='<%=app.id%>'>
          <input type='text' id='name-form'  class='form-control typeahead' value='<%= params[:namesearch] %>' name='namesearch' placeholder='Enter Player Name' autocomplete='off' >
          <input type='submit' value='Submit' style='display:none' >
          </div>
        </form>
                        <div class='col-sm-6 col-xs-12 text-center' id='player-wrapper'>
                                <h4><%=player_regular.name%></h4>
                                <%= image_tag(player_regular.image, id:'player_image') %>
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
                                                        <td class='reg_season'><%=player_regular.minutes_pg%></td>
                                                        <td class='post_season'><%=player_playoff.minutes_pg%></td>
                                                        <% if player_diff.minutes_pg >= 0 %>
                                                        <td class='difference positive'><%=player_diff.minutes_pg%></td>
                                                        <% else %>
                                                        <td class='difference'><%=player_diff.minutes_pg%></td>
                                                        <% end %>

                                                </tr>

                                                <tr id='ppg'>
                                                        <td>PPG</td>
                                                        <td class='reg_season'><%=player_regular.pts_pg%></td>
                                                        <td class='post_season'><%=player_playoff.pts_pg%></td>
                                                        <% if player_diff.pts_pg >= 0 %>
                                                        <td class='difference positive'><%=player_diff.pts_pg%></td>
                                                        <% else %>
                                                        <td class='difference negative'><%=player_diff.pts_pg%></td>
                                                        <% end %>

                                                </tr>
                                                <tr id='fg_perc'>
                                                        <td>FG%</td>
                                                        <td class='reg_season'><%=BigDecimal(player_regular.fg_perc) * 100%>%</td>
                                                        <td class='post_season'><%=BigDecimal(player_playoff.fg_perc) * 100%>%</td>
                                                        <% if player_diff.fg_perc >= 0 %>
                                                        <td class='difference positive'><%=BigDecimal(player_diff.fg_perc) * 100%>%</td>
                                                        <% else %>
                                                        <td class='difference negative'><%=BigDecimal(player_diff.fg_perc) * 100%>%</td>
                                                        <% end %>

                                                </tr>
                                                <tr id='three_fg_perc'>
                                                        <td>3ptFG%</td>
                                                        <td class='reg_season'><%=BigDecimal(player_regular.threept_perc) * 100%>%</td>
                                                        <td class='post_season'><%=BigDecimal(player_playoff.threept_perc) * 100%>%</td>
                                                        <% if player_diff.threept_perc >= 0 %>
                                                        <td class='difference positive'><%=BigDecimal(player_diff.threept_perc) * 100%>%</td>
                                                        <% else %>
                                                        <td class='difference negative'><%=BigDecimal(player_diff.threept_perc) * 100%>%</td>
                                                        <% end %>

                                                </tr>
                                                <tr id='apg'>
                                                        <td>APG</td>
                                                        <td class='reg_season'><%=player_regular.ast_pg%></td>
                                                        <td class='post_season'><%=player_playoff.ast_pg%></td>
                                                        <% if player_diff.ast_pg >= 0 %>
                                                        <td class='difference positive'><%=player_diff.ast_pg%></td>
                                                        <% else %>
                                                        <td class='difference negative'><%=player_diff.ast_pg%></td>
                                                        <% end %>
                                                </tr>
                                               <tr id='topg'>
                                                        <td>TOPG</td>
                                                        <td class='reg_season'><%=player_regular.to_pg%></td>
                                                        <td class='post_season'><%=player_playoff.to_pg%></td>                         
                                                        <% if player_diff.to_pg >= 0 %>
                                                        <td class='difference positive'><%=player_diff.to_pg%></td>
                                                        <% else %>
                                                        <td class='difference negative'><%=player_diff.to_pg%></td>
                                                        <% end %>
                                               </tr>
                                       </tbody>
                                </table>
                        </div>", js: "

                        <%if @app_objects%>
                                <% player_regular = @app_objects.where(stat:'regular').first %>
                                <% player_playoff = @app_objects.where(stat:'playoff').first %>
                                <% player_diff = @app_objects.where(stat:'diff').first %>

                                $('#player-wrapper h4').text('<%= player_regular.name %>');
                                $('img#player_image').attr('src', '<%= asset_path(\"ajax-loader.gif\") %>');
                                $('img#player_image').attr('src', '<%= player_regular.image %>');
                                <% @rows = ['mpg', 'ppg', 'fg_perc', 'three_fg_perc', 'apg', 'topg'] %>
                                <% @stats = ['minutes_pg', 'pts_pg', 'fg_perc', 'threept_perc', 'ast_pg', 'to_pg'] %>
                                <% @rows.zip(@stats).each do |row, stat| %>
                                        <% if row == 'fg_perc' || row == 'three_fg_perc' %>
                                                $('tr#' + '<%=row%>' + ' .reg_season').text('<%= BigDecimal(player_regular.send(stat)) * 100 %>%');
                                                $('tr#' + '<%=row%>' + ' .post_season').text('<%= BigDecimal(player_playoff.send(stat)) * 100%>%');
                                                $('tr#' + '<%=row%>' + ' .difference').text('<%= BigDecimal(player_diff.send(stat)) * 100%>%');
                                              
                                        <% else %>
                        
                                                $('tr#' + '<%=row%>' + ' .reg_season').text('<%= player_regular.send(stat) %>');
                                                $('tr#' + '<%=row%>' + ' .post_season').text('<%= player_playoff.send(stat)%>');
                                                $('tr#' + '<%=row%>' + ' .difference').text('<%= player_diff.send(stat)%>');
                                        <% end %>
                                        <% if player_diff.send(stat) >= 0 %>
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


Assignment.create(app: app1, article: article1)

article2 = Article.create(title:"Shot Efficiency in NBA Playoffs", date:"June 9, 2015", body:"<p>This is an attempt at understanding how the playoffs affect shooting efficiency. There is an expected decrease in shooting efficiency across the board in the playoffs simply because of better competition. However, certain superstars have a reputation of raising their level of play in the playoffs.</p>

<p>One hope of this analysis is to get a better understanding of how different shots vary when it comes to the regular season versus the playoffs. Shots that tend to become much less efficient might be more affected by increased effort and better defenses in the playoffs. Meanwhile, shots that don't become much less efficient might be a result of those shots being more dependent on the skills of the offensive player rather than the defense played on that player.</p>

")

app2 = App.create(name:"position_shots", position:"top", object:"Player", html:"
<div class='col-xs-12 text-center position_shots'>
        <form accept-charset='UTF-8' action='/apps' method='get' class='special-submit' data-remote='true'>
          <input type='hidden' name='appid' value='<%=app.id%>'>
          <select name='namesearch' onchange=\"$(this.form).submit();\"> 
                <option value='PG' selected>Point Guards</option>
                <option value='SG'>Shooting Guards</option>
                <option value='SF'>Small Forwards</option>
                <option value='PF'>Power Forwards</option>
                <option value='C'>Center</option>
          </select>
          <input type='submit' value='Submit' style='display:none' >

        </form>
        
</div>
<div class='col-xs-12 col-sm-6 text-center position_shots' >

        <% p1 = Player.where(stat:'regular').where(position:'PG') %>
        <h5>Regular Season<h5>
        <%= pie_chart(fg_type_taken_hash(p1)) %> 
        <%= column_chart(dist_taken_hash(p1)) %>

</div>

<div class='col-xs-12 col-sm-6 text-center position_shots'>

        <% p2 = Player.where(stat:'playoff').where(position:'PG') %>
        <h5>Playoffs<h5>
        <%= pie_chart(fg_type_taken_hash(p2)) %>
        <%= column_chart(dist_taken_hash(p2)) %>

</div>
<div class='col-xs-12 text-center position_shots'>
        <%= column_chart [
                {name: 'Regular Season', data: dist_taken(p1)},
                {name: 'Playoffs', data: dist_taken(p2)}
        ] %>
</div>

")

Assignment.create(app: app2, article: article2)

p "Loaded #{Article.count} articles with #{Assignment.count} assignments to #{App.count} apps"

#Add objects to apps
App.all.each do |app|
        c = Connection.where(name: "#{app.object}").first
        if c
           app.update(connection: c)     
        else
                nc = Connection.create(name: "#{app.object}")
                app.update(connection: nc)
                app.object.constantize.all.each do |p|
                        p.update(connection:nc)         
                end
        end
end

p "Created #{Connection.count} connections between #{App.count} apps and #{Player.count} objects"
