# == Schema Information
#
# Table name: teams
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     not null
#  user_id    :integer(4)      not null
#  created_at :datetime        not null
#

class Team < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :name

  def create_default_footballers
    skill_points = 15
    (1..5).each do |i|
      Footballer.create :name => "footballer#{i}",
                        :number => i,
                        :speed => skill_points/3,
                        :technicality => skill_points/3,
                        :fight => skill_points/3,
                        :team_id => id,
                        :skill_points => skill_points
    end
  end

end

