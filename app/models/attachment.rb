class Attachment < ActiveRecord::Base
	mount_uploader :attachment, FileUploader
	belongs_to :micropost, :polymorphic => true

end
