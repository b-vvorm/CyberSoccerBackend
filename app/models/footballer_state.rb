# == Schema Information
#
# Table name: footballer_states
#
#  id            :integer(4)      not null, primary key
#  footballer_id :integer(4)      not null
#  game_id       :integer(4)      not null
#  x             :integer(4)      default(0), not null
#  y             :integer(4)      default(0), not null
#  current_speed :integer(4)      default(0), not null
#

class FootballerState < ActiveRecord::Base
end

