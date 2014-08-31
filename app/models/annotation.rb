class Annotation < ActiveRecord::Base
	belongs_to :feedback

	attr_accessible :id, :x_axis, :y_axis, :details, :image_id, :feedback_id
end
