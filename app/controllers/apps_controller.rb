class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]

  # GET /apps
  # GET /apps.js
  def index
    @app = App.find(params[:appid].to_i)
    @app_objects = @app.connection.send(@app.object.downcase.pluralize).search(params[:namesearch], @app.name)
    respond_to do |format|
        if @app.name=="position_shots"
                format.js { render "hchart" }
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
