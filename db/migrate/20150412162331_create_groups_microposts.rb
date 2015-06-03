class CreateGroupsMicroposts < ActiveRecord::Migration
  def change
    create_table :groups_microposts, :id=> false do |t|
    	t.integer :micropost_id
    	t.integer :group_id
    end
  end
end
