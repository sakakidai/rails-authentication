require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsAuthentication
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # ActiveSupport::TimeWithZone(default is utc)
    config.time_zone = 'Tokyo'

    # DB time zone
    config.active_record.default_timezone = :local

    # Set locale(default is :en)
    config.i18n.default_locale = :ja

    # Doc: https://railsguides.jp/configuring.html#config-add-autoload-paths-to-load-path
    # Doc: https://github.com/fxn/zeitwerk
    # The directories managed by Zeitwerk do not even need to be in $LOAD_PATH.
    # Confirm useing Zeitwerk at 'Rails.autoloaders.zeitwerk_enabled?'
    # Confirm load_path at 'pp $LOAD_PATH'
    # Confirm autoload_paths at 'pp ActiveSupport::Dependencies.autoload_paths'
    config.add_autoload_paths_to_load_path = false

    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
