class CreateRooms < ActiveRecord::Migration
	def change
		create_table :rooms do |t|
			t.integer :appid
			t.string :name
			t.string :backgroud
			t.integer :total_lest
			t.integer :single_lest

			t.timestamps
		end
	end
end
