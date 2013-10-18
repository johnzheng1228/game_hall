class CreateActiveDevices < ActiveRecord::Migration
  def change
    create_table :active_devices do |t|
      t.string :device
      t.string :serail

      t.timestamps
    end
  end
end
