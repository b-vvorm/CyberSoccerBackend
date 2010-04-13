class CreateFootballers < ActiveRecord::Migration
  def self.up
    create_table :footballers do |t|
      t.string      :name,          :null => false, :default => "footballer"
      t.integer     :number,        :null => false, :default => 0
      t.integer     :speed,         :null => false, :default => 0
      t.integer     :technicality,  :null => false, :default => 0
      t.integer     :fight,         :null => false, :default => 0
      t.references  :team,          :null => false
      t.timestamps
    end
    add_foreign_key :footballers, :teams, :dependent => :delete
  end

  def self.down
    drop_table :footballers
  end
end

