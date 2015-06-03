class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

	def self.reset_count
		self.new_count = 0
	end

end
