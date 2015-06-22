Article.destroy_all
App.destroy_all
Player.destroy_all
Season.destroy_all
Sector.destroy_all
Assignment.destroy_all
Connection.destroy_all
Seasonassociation.destroy_all

players = ActiveSupport::JSON.decode(File.read("jsons/better_playoff_players.json"))
seasons = ActiveSupport::JSON.decode(File.read("jsons/better_player_playoff_seasons.json"))
sectors = ActiveSupport::JSON.decode(File.read("jsons/opengov.json"))

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

#Create sectors
Sector.create!(sectors)

p "Created #{Sector.count} sectors"



#Add Articles
article1 = Article.create(title: "NBA Regular Season vs Playoffs: Player Performance", date: "June 3, 2015", topic: "sports", body: "

<p>Every year when the NBA playoffs arrive, pundits often repeat the idea that playoff basketball is a different beast. That opinion is especially common among former players and coaches, but is also echoed by most writers and fans of the game. The difference is attributed to a number of factors including: slower pace, more physicality, more defensive effort, pressure from the spotlight, and improved game planning when playing the same team repeatedly. But analysts that rely on statistical measures usually make predictions based on the regular season. That's reasonable because the most recent data available about the particular teams in the playoffs comes from the regular season.</p>

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

article2 = Article.create(title:"NBA Regular Season vs Playoffs: Shot Share", date:"June 9, 2015", topic:"sports", body:"

<p>As mentioned in my previous post, the NBA playoffs are often considered a 'different beast' from the regular season. One aspect of that is the type of shots available in the postseason as opposed to the regular season. So I thought I'd explore that with the charts above. </p>

<p>The charts show the total percentage of shots taken in different distance intervals in the regular season versus the playoffs. They are grouped by position for a more nuanced understanding. The data used is the entirety of field goals attempted by all players currently in the league that have been in the playoffs. A better dataset is definitely needed. But I thought this would be a way to begin exploring how the playoffs affect shot choice. Of course, this leaves plenty to be desired, but might help us understand the playoffs a little better.</p> 

<p>One glaring weakness is that the players and teams in the playoffs are a different set than the ones playing in the regular season. It's fair to assume that playoff teams are better and are attempting more efficient shots than non-playoff teams would. Another problem is that positions, especially in today's game, are flexibile and players spend time playing different roles. This includes different shots. Hopefully I can address some of these problems in future posts.</p>

<p>A quick look at the charts shows that there aren't any drastic changes to shot selection. But some of the small changes are interesting. For example, point guards seem to attempt less three pointers and more shots close to the rim. And big men attempt a greater percentage of mid-range shots. This could indicate that in the playoffs, perimeter players are forced to drive more and big men are pushed away from the rim, presumably out of their respective comfort zones. This isn't enough to draw any conclusions, but it is a clue. Later on, I'll try to perform hypothesis tests with better data to see if these differences show that the playoffs result in a statistically significant difference in shot selection.</p>

")

app2 = App.create(name:"position_shots", position:"top", object:"Player", citation:"Statistics from basketball-reference.com, Chart uses higcharts.js", html:"
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
<div class='col-xs-12 col-sm-6 text-center position_shots chart' id='chart-1' >
</div>
<div class='col-xs-12 col-sm-6 text-center position_shots chart' id='chart-2' >
</div>

")

Assignment.create(app: app2, article: article2)

article3 = Article.create(title:"Campaign Finance During Major Legislative Change", date:"June 17, 2015", topic:"government", body:"

<p>A big issue in the upcoming presidential election will undoubtedly be the presence and influence of money in politics. Whether that means something will actually change is another question entirely. This will be the first of many posts trying to visualize how money influences politics. The ultimate goal will be a detailed look at how ties to certain industries determines voting on particular bills. But that is probably a long ways away because it involves analyzing bill language and seeing which industries are hurt or helped by certain legislation.</p>

<p>Until then, the graphs above give a general sense of how contributions to congress from different industries have changed over the last two decades. I've marked some major events on the graph to give context. Of particular note is the huge spike in contributions during the financial crisis of 2008. It's as if every industry knew that the financial crisis would lead to major reforms and wanted to make sure its own voice was heard. There definitely could have been other factors including the historic nature of the 2008 election. But regardless, it's interesting that companies increased campaign contributions during a time when they were hemorrhaging money and heavily laying off workers. Oddly, the contribution spike is much more prominent on the senate side rather than the house side.</p>

<p>Of course more research and work is needed. My knowledge of the political and economic landscapes at these different times leaves a lot to be desired. Interesting to look at though.</p>


")

app3 = App.create(name:"sector_campaign_money", position:"top", object:"Sector", citation:"Statistics from OpenSecrets.org, Chart uses higcharts.js", html:"
<form accept-charset='UTF-8' action='/apps' method='get' class='special-submit' data-remote='true'>
        <input type='hidden' name='appid' value='<%=app.id%>'>
        <input type='hidden' name='congress_house' value='senate'>
        <div class='col-xs-12 text-center input-group'>
               <div class='input-group-btn'>
                      <button type='submit' name='congress_house' value='senate' class='special btn btn-default active' selected>Senate</button>
                      <button type='submit' name='congress_house' value='house' class='special btn btn-default'>House</button>
               </div>
        </div>

        <div class='col-xs-12 text-center industry_money'>
                <select class='sector_select'  name='namesearch' onchange=\"$(this.form).submit();\"> 
                      <option value='Agribusiness' selected>Agribusiness</option>
                      <option value='Communications/Electronics'>Communications/Electronics</option>
                      <option value='Construction'>Construction</option>
                      <option value='Defense'>Defense</option>
                      <option value='Energy/Natural Resources'>Energy/Natural Resources</option>
                      <option value='Finance/Insurance/Real Estate'>Finance/Insurance/Real Estate</option>
                      <option value='Health'>Health</option>
                      <option value='Lawyers & Lobbyists'>Lawyers & Lobbyists</option>
                      <option value='Transportation'>Transportation</option>
                      <option value='Misc Business'>Misc Business</option>
                      <option value='Labor'>Labor</option>
                      <option value='Ideology/Single-Issue'>Ideology/Single-Issue</option>
                      <option vaule='Other'>Other</option>
                </select>
        </div>
</form>
        
<div class='col-xs-12 text-center position_shots chart' id='chart-3' >
</div>
")

Assignment.create(app:app3, article:article3)

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
