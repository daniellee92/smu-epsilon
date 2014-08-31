class Feedback < ActiveRecord::Base
	belongs_to :user
	# belongs_to :agency

	# has_many :comments
	# has_many :votes
	# has_many :notifications
	# has_many :agency_updates
	has_many :annotations

	attr_accessible :title, :details, :status, :address, :latitude, :longitude, :detailed_location, :last_acted_at, :reported_by, :id, :created_at, :image1, :image2, :image3, :image4, :image5
	# geocoded_by :address
	# after_validation :geocode, :if => :address_changed?

	# reverse_geocoded_by :latitude, :longitude
	# after_validation :reverse_geocode, :if => :address_changed?

end
