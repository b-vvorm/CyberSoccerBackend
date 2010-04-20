# == Schema Information
#
# Table name: game_states
#
#  id                :integer(4)      not null, primary key
#  first_team_score  :integer(4)      default(0), not null
#  second_team_score :integer(4)      default(0), not null
#  ball_x            :integer(4)      default(0), not null
#  ball_y            :integer(4)      default(0), not null
#  game_id           :integer(4)      not null
#

class GameState < ActiveRecord::Base
end

