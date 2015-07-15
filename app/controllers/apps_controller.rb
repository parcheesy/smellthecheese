class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]

  # GET /apps
  # GET /apps.js
  def index
    # Find app based on passed appid parameter
    @app = App.find(params[:appid].to_i)
    # @app.object is the type of object the specific app uses
    # Uses connection join table to find app object that matches namesearch parameter
    @app_objects = @app.connection.send(@app.object.downcase.pluralize).search(params[:namesearch], @app.name)
    # Special behavior for campaign money app
    # Need to refactor. This logic should not be in controller
    if @app.name=="sector_campaign_money"
        @app_additional = params[:congress_house]
    end
    #Render proper javascript based on app name
    respond_to do |format|
        if @app.name=="position_shots"
                format.js { render "hchart" }
        elsif @app.name=="sector_campaign_money"
                format.js { render "campaign1" }
        else
                format.js
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params[:app]
    end
end
