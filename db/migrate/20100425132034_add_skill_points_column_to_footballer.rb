class AddSkillPointsColumnToFootballer < ActiveRecord::Migration
  def self.up
    add_column :footballers, :skill_points, :integer, :null => false, :default => 15
  end

  def self.down
    remove_column :footballers, :skill_points
  end
end

