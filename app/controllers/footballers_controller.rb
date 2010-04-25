class FootballersController < ApplicationController

  before_filter :require_user
  layout 'game'

  def edit
    @footballer = Footballer.find params[:id]
  end

  def update
    @footballer = Footballer.find(params[:id])
    if @footballer.update_attributes(params[:footballer])
      flash.now[:notice] = I18n.translate(:"footballers.messages.success_save", :footballer_name => @footballer.name)
      flash.keep(:notice)
      redirect_to edit_team_url(@footballer.team_id)
    else
      render :action => :edit
    end
  end

  def grid_data
    footballers = Footballer.find_all_by_team_id params[:team_id]
    respond_to do |format|
      format.html
      format.json { render :json => footballers.to_jqgrid_json([:name, :skill_points, :speed, :technicality, :fight], params[:page], params[:rows], footballers.length) }
    end
  end

end

