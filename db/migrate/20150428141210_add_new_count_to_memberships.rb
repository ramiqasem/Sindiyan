class AddNewCountToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :new_count, :integer, :default => 0
    
  end
end
