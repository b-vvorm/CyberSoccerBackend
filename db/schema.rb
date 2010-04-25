# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100425132034) do

  create_table "footballer_states", :force => true do |t|
    t.integer "footballer_id",                :null => false
    t.integer "game_id",                      :null => false
    t.integer "x",             :default => 0, :null => false
    t.integer "y",             :default => 0, :null => false
    t.integer "current_speed", :default => 0, :null => false
  end

  add_index "footballer_states", ["footballer_id"], :name => "footballer_states_footballer_id_fk"
  add_index "footballer_states", ["game_id"], :name => "footballer_states_game_id_fk"

  create_table "footballers", :force => true do |t|
    t.string   "name",         :default => "footballer", :null => false
    t.integer  "number",       :default => 0,            :null => false
    t.integer  "speed",        :default => 0,            :null => false
    t.integer  "technicality", :default => 0,            :null => false
    t.integer  "fight",        :default => 0,            :null => false
    t.integer  "team_id",                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skill_points", :default => 15,           :null => false
  end

  add_index "footballers", ["team_id"], :name => "footballers_team_id_fk"

  create_table "game_states", :force => true do |t|
    t.integer "first_team_score",  :default => 0, :null => false
    t.integer "second_team_score", :default => 0, :null => false
    t.integer "ball_x",            :default => 0, :null => false
    t.integer "ball_y",            :default => 0, :null => false
    t.integer "game_id",                          :null => false
  end

  add_index "game_states", ["game_id"], :name => "game_states_game_id_fk"

  create_table "games", :force => true do |t|
    t.string   "status",           :limit => 0, :default => "created", :null => false
    t.integer  "first_team_id",                                        :null => false
    t.integer  "second_team_id",                                       :null => false
    t.integer  "game_half_length",              :default => 45,        :null => false
    t.datetime "created_at"
  end

  add_index "games", ["first_team_id"], :name => "games_first_team_id_fk"
  add_index "games", ["second_team_id"], :name => "games_second_team_id_fk"

  create_table "teams", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
  end

  add_index "teams", ["user_id"], :name => "teams_user_id_fk"

  create_table "users", :force => true do |t|
    t.string   "email",             :null => false
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "footballer_states", "footballers", :name => "footballer_states_footballer_id_fk", :dependent => :delete
  add_foreign_key "footballer_states", "games", :name => "footballer_states_game_id_fk", :dependent => :delete

  add_foreign_key "footballers", "teams", :name => "footballers_team_id_fk", :dependent => :delete

  add_foreign_key "game_states", "games", :name => "game_states_game_id_fk", :dependent => :delete

  add_foreign_key "games", "teams", :name => "games_first_team_id_fk", :column => "first_team_id", :dependent => :delete
  add_foreign_key "games", "teams", :name => "games_second_team_id_fk", :column => "second_team_id", :dependent => :delete

  add_foreign_key "teams", "users", :name => "teams_user_id_fk", :dependent => :delete

end
