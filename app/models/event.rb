class Event < ActiveRecord::Base
	has_and_belongs_to_many :group
	accepts_nested_attributes_for :group
	belongs_to :user
end
