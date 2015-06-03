class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
       	t.integer :group_id
    	t.integer :micropost_id
    end
    
    add_index :groupings, :micropost_id
    add_index :groupings, :group_id
   
   end
 end
