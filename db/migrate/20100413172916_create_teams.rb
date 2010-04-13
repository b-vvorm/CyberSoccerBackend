class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string      :name, :null => false
      t.references  :user, :null => false
      t.datetime :created_at, :null => false
    end
    add_foreign_key :teams, :users, :dependent => :delete
  end

  def self.down
    drop_table :teams
  end
end

