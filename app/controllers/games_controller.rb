class GamesController < ApplicationController

  before_filter :require_user
  layout 'game'

  def index
  end

end
