class Competition < ActiveRecord::Base
	serialize :entered, Array
	has_many :pictures
end
