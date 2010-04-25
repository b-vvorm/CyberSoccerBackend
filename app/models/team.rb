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

end

