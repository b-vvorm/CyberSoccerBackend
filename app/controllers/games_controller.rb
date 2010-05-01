class GamesController < ApplicationController

  before_filter :require_user

  def index
  end

  def new
    @game = Game.new
    @teams = Team.find_all_by_user_id(@current_user.id).collect {|team| [team.name, team.id]}
  end

  def create
    @game = Game.new params[:game].merge({:status => "created"})
    if @game.save
      flash.now[:notice] = I18n.translate(:"games.messages.success_create")
      flash.keep(:notice)
      redirect_to :action => :show, :id => @game.id
    else
      render :action => :new
    end
  end

  def update
    @game = Game.find params[:id]
    if @game.update_attributes(params[:game].merge({:status => "started"}))
      flash.now[:notice] = I18n.translate(:"games.messages.success_connect")
      flash.keep(:notice)
      redirect_to :action => :show
    else
      redirect_to games_url
    end
  end

  def show
    layout 'game'
    @game = Game.find params[:id]
  end

  def start
    @game = Game.find params[:id]
  end

  def edit
    @game = Game.find params[:id]
    @teams = Team.find_all_by_user_id(@current_user.id).collect {|team| [team.name, team.id]}
  end

  def grid_data
    games = Game.find_all_by_status("created")
    respond_to do |format|
      format.json { render :json => games.to_jqgrid_json([:first_team_name, :status], params[:page], params[:rows], games.length) }
    end
  end

end

