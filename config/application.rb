require File.expand_path('../boot', __FILE__)

require "rails/all"

Bundler.require(*Rails.groups)

module ModsGtav
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
    config.generators do |g| 
      g.test_framework :rspec, 
      :fixtures => true, 
      :view_specs => false, 
      :helper_specs => false, 
      :routing_specs => false, 
      :controller_specs => true, 
      :request_specs => true 
      g.fixture_replacement :factory_girl, :dir => "spec/factories" 
    end
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
      html_tag.html_safe
    end
  end
end
