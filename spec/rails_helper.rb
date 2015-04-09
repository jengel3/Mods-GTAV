ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.before(:each) do
     Submission.delete_all

     Image.delete_all
     Comment.delete_all

     Download.delete_all
     Upload.delete_all

     User.delete_all
     ApiKey.delete_all

     BlogPost.delete_all
  end
  config.infer_spec_type_from_file_location!
end