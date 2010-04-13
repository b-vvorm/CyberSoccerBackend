class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.column    :status, "enum('created','started','finished')", :null => false, :default => "created"
      t.integer   :first_team_id,         :null => false
      t.integer   :second_team_id,        :null => false
      t.integer   :game_half_length,      :null => false, :default => 45
      t.datetime  :created_at
    end
    add_foreign_key :games, :teams, :column => "first_team_id",   :dependent => :delete
    add_foreign_key :games, :teams, :column => "second_team_id",  :dependent => :delete
  end

  def self.down
    drop_table :games
  end
end

