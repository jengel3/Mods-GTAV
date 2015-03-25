class Download
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :submission

  field :ip_address, type: String, default: ""
end
