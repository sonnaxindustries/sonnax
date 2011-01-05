require "rubygems"
require "bundler"
Bundler.setup

require 'exception_notification'

RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.load_paths += %W( #{RAILS_ROOT}/app/presenters #{RAILS_ROOT}/app/observers #{RAILS_ROOT}/app/mailers #{RAILS_ROOT}/app/sweepers #{RAILS_ROOT}/app/builders )
  config.active_record.observers = :solenoid_program_observer, :contact_observer, :catalog_request_observer, :order_observer

  config.time_zone = 'UTC'
  config.action_controller.session_store = :active_record_store

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end
