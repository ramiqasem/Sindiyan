class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
  has_many :group, :through => :membership
  has_many :membership, :dependent => :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :event
  
  attr_accessor :remember_token, :activation_token
	
	before_save { self.email = email.downcase }
	before_create :create_activation_digest 

	validates :name, presence: true, length: {maximum:50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum:255}, 
		format: {with: VALID_EMAIL_REGEX}, 
		uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 6 }, allow_blank: true

	mount_uploader :avatar, AvatarUploader

  	def User.digest(string)
  		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      	BCrypt::Password.create(string, cost: cost)
  	end

  	def User.new_token
	   SecureRandom.urlsafe_base64
  	end

  	def remember
    	self.remember_token = User.new_token
    	update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end

  	def forget
      update_attribute(:remember_digest, nil)
  	end

   

    def follow(other_user)
      active_relationships.create(followed_id: other_user.id)
    end

    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
    end

    def following?(other_user)
      following.include?(other_user)
    end

    def admin?(group)
      self.owned_groups.include?(group)
    end

    def owned_groups
      group_ids = "SELECT group_id FROM memberships WHERE user_id = :user_id && owner=true"
      Group.where("id IN (#{group_ids})", user_id: id)
    end

    #def feed
     # following_ids = "SELECT followed_id FROM relationships
     #                WHERE  follower_id = :user_id"
      #Micropost.where("user_id IN (#{following_ids})
      #               OR user_id = :user_id", user_id: id)
    #end

    def post_feed
      group_ids = "SELECT group_id FROM memberships
                     WHERE  user_id = :user_id"

      microposts_ids = "SELECT micropost_id from groupings WHERE group_id IN (#{group_ids})"

      Micropost.where("id IN (#{microposts_ids})", user_id: id)
    end

    def event_feed
      group_ids = "SELECT group_id FROM memberships
                     WHERE  user_id = :user_id"

      events_ids = "SELECT event_id from events_groups WHERE group_id IN (#{group_ids})"

      Event.where("id IN (#{events_ids})", user_id: id)
    end

    def feed
      (post_feed + event_feed).sort_by(&:created_at).reverse
    end

    # move to group model

    def group_feed(group_id)
     microposts_ids = "SELECT micropost_id from groupings WHERE group_id IN (#{group_id})"

      Micropost.where("id IN (#{microposts_ids})")
    end

    def unread(group_id)

    end

    private

  	def create_activation_digest
  		self.activation_token = User.new_token
  		self.activation_digest = User.digest(activation_token)
  	end

end