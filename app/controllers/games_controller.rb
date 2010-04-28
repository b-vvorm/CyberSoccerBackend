class GamesController < ApplicationController

  before_filter :require_user
  layout 'game'

  def index
  end

  def new
    @game = Game.new
    @teams = Team.find_all_by_user_id(@current_user.id).collect {|team| [team.name, team.id]}
  end

  def create
    @game = Game.new params[:game].merge({:status => "created"})
    if @game.save
      redirect_to games_url
    else
      render :action => :new
    end
  end

  def grid_data
    games = Game.all
    respond_to do |format|
      format.json { render :json => games.to_jqgrid_json([:first_team_name, :status], params[:page], params[:rows], games.length) }
    end
  end

end

