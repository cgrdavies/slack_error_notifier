require 'slack-ruby-client'

require "slack_error_notifier/version"
require "slack_error_notifier/helpers/configuration"
require "slack_error_notifier/slack_configuration"
require "slack_error_notifier/slack_notification"


module SlackErrorNotifier
  extend Configuration

  define_setting :access_token
  define_setting :target_channel
  define_setting :send_as_user
  define_setting :app_name

  def self.with_notifications
    check_configuration(block_given?)
    configure_slack_client
    yield
  rescue => error
    puts "Encountered #{error}. Sending Notification to #{target_channel}."
    send_notification(error)
  end

  def self.configure_slack_client
    @slack_configuration = SlackConfiguration.new
  end

  def self.slack_client
    @slack_configuration.slack_client
  end

  def self.send_notification(error)
    SlackNotification.send(error)
  end

  def self.check_configuration(block_given)
    raise ConfigurationError::NoBlockGivenError unless block_given
    raise ConfigurationError::MissingConfiguration unless access_token && target_channel
  end

  module ConfigurationError
    class NoBlockGivenError < StandardError; end
    class MissingConfiguration < StandardError; end
    class InvalidChannel < StandardError; end
  end
end
