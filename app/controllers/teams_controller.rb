class TeamsController < ApplicationController

  before_filter :require_user
  layout 'game'

  def index
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      redirect_to teams_url
    else
      render :action => :new
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to teams_url
    else
      render :action => :edit
    end
  end

  def show
  end

  def edit
    @team = Team.find(params[:id])
  end

  def destroy
  end

  def grid_data
    teams = Team.find_all_by_user_id @current_user.id
    respond_to do |format|
      format.html
      format.json { render :json => teams.to_jqgrid_json([:name], params[:page], params[:rows], teams.length) }
    end
  end

end

