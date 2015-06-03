class Micropost < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  has_and_belongs_to_many :group
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence:true
  validate  :picture_size
  has_many :group, :through => :grouping,  :dependent => :destroy
  has_many :grouping
  has_many :attachment
  accepts_nested_attributes_for :grouping, :attachment

	mount_uploader :picture, AvatarUploader
  mount_uploader :file, FileUploader
  

  auto_html_for :content do
    html_escape
    image
    youtube(:width => 400, :height => 250, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

def picture_size
     if picture.size > 2.megabytes
       errors.add(:picture, "should be less than 2MB")
     end
end


end
