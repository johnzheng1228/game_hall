class CreateWealths < ActiveRecord::Migration
	def change
		create_table :wealths do |t|
			t.integer :player_id
			t.integer :gold
			t.integer :silver
			t.integer :copper

			t.timestamps
		end
	end
end
