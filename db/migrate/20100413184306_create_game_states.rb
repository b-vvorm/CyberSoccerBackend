class CreateGameStates < ActiveRecord::Migration
  def self.up
    create_table :game_states do |t|
      t.integer     :first_team_score,    :null => false, :default => 0
      t.integer     :second_team_score,   :null => false, :default => 0
      t.integer     :ball_x,              :null => false, :default => 0
      t.integer     :ball_y,              :null => false, :default => 0
      t.references  :game,                :null => false
    end
    add_foreign_key :game_states, :games, :dependent => :delete
  end

  def self.down
    drop_table :game_states
  end
end

