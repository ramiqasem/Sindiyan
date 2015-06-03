class Group < ActiveRecord::Base
	has_many :user, :through => :membership,  :dependent => :destroy
	has_many :membership
	has_many :micropost, :through => :grouping,  :dependent => :destroy
	has_many :grouping
	has_and_belongs_to_many :event

	
	def increment_new 
		
		memberships = self.membership
		memberships.each do |membership|
			
			if membership.new_count
				membership.new_count += 1
			else
				membership.new_count=1
			end
			membership.save
		end
	end


 


end
