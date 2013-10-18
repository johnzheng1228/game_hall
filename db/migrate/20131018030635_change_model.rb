class ChangeModel < ActiveRecord::Migration
  def change
    rename_column :wealths, :silver, :diamond
    remove_column :wealths, :copper
  end
end
