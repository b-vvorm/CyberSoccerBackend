# == Schema Information
#
# Table name: footballers
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)     default("footballer"), not null
#  number       :integer(4)      default(0), not null
#  speed        :integer(4)      default(0), not null
#  technicality :integer(4)      default(0), not null
#  fight        :integer(4)      default(0), not null
#  team_id      :integer(4)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Footballer < ActiveRecord::Base

  belongs_to :team

end

