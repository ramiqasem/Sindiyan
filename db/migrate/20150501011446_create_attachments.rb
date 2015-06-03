class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.integer :micropost_id
    	t.string :name
    	t.string :description
    	t.string :attachment

      t.timestamps null: false
    end
  end
end
