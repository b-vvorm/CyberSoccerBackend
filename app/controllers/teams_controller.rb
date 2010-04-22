class TeamsController < ApplicationController

  before_filter :require_user
  layout 'game'

  def index

  end

  def grid_data
    teams = [Team.new(:name => "ManUtd"), Team.new(:name => "Liverpool"), Team.new(:name => "Arsenal"), Team.new(:name => "Chelsea")]
    respond_to do |format|
      format.html
      format.json { render :json => teams.to_jqgrid_json([:name], params[:page], params[:rows], teams.length) }
    end
  end

  def show
  end

  def edit
  end

end

