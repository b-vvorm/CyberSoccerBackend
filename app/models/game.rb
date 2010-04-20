# == Schema Information
#
# Table name: games
#
#  id               :integer(4)      not null, primary key
#  status           :string(0)       default("created"), not null
#  first_team_id    :integer(4)      not null
#  second_team_id   :integer(4)      not null
#  game_half_length :integer(4)      default(45), not null
#  created_at       :datetime
#

class Game < ActiveRecord::Base

  belongs_to :first_team,   :class_name => "Team"
  belongs_to :second_team,  :class_name => "Team"

end

