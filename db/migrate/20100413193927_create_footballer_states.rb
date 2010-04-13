class CreateFootballerStates < ActiveRecord::Migration
  def self.up
    create_table :footballer_states do |t|
      t.references  :footballer,    :null => false
      t.references  :game,          :null => false
      t.integer     :x,             :null => false, :default => 0
      t.integer     :y,             :null => false, :default => 0
      t.integer     :current_speed, :null => false, :default => 0
    end
    add_foreign_key :footballer_states, :games,       :dependent => :delete
    add_foreign_key :footballer_states, :footballers, :dependent => :delete
  end

  def self.down
    drop_table :footballer_states
  end
end

