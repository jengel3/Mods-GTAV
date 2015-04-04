class Download
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :submission

  scope :daily, -> { where(:created_at.gte => Date.today - 24.hours) }
  scope :weekly, -> { where(:created_at.gte => Date.today - 1.week) }

  field :ip_address, type: String, default: ""
end
