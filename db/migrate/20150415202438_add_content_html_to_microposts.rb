class AddContentHtmlToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :content_html, :text
  end
end
