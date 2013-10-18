class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :password
      t.string :nick_name
      t.string :token
      t.string :serial_number
      t.integer :level,default: 1

      t.timestamps
    end
  end
end
