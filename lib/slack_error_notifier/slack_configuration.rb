module SlackErrorNotifier
  class SlackConfiguration
    attr_reader :slack_token, :target_channel

    def initialize
      @slack_token = SlackErrorNotifier.access_token
      @target_channel = SlackErrorNotifier.target_channel
      configure_slack_client
      check_authentication
      check_target_channel_validity
    end

    def slack_client
      @slack_client ||= Slack::Web::Client.new
    end

    private

    def check_authentication
      slack_client.auth_test
    end

    def check_target_channel_validity
      valid_channel = channel_is_user? ? check_user_exists : check_channel_exists
      raise ConfigurationError::InvalidChannel unless valid_channel
    end

    def channel_is_user?
      target_channel.start_with?('@')
    end

    def check_user_exists
      slack_client.users_info(user: target_channel)
    rescue Slack::Web::Api::Error
      return false
    end

    def check_channel_exists
      channels = slack_client.channels_list.channels
      channels.detect { |c| c.name == target_channel.gsub('#', '') }
    end

    def configure_slack_client
      Slack.configure do |config|
        config.token = slack_token
      end
    end
  end
end
