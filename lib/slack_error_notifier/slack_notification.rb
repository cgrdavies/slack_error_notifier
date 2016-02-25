module SlackErrorNotifier
  class SlackNotification
    def initialize(error)
      @error = error
    end

    def self.send(error)
      new(error).send
    end

    def send
      slack_client.chat_postMessage(
        channel: target_channel,
        text: "",
        attachments: attachments,
        as_user: true
      )
    end

    private

    def slack_client
      SlackErrorNotifier.slack_client
    end

    def target_channel
      SlackErrorNotifier.target_channel
    end

    def send_as_user
      SlackErrorNotifier.send_as_user
    end

    def attachments
      [{
        fallback: "Error in #{app_name}",
        color: "danger",
        title: "Error in #{app_name}!",
        text: assemble_text_body,
        mrkdwn_in: ['text'],
        thumb_url: 'http://i.imgur.com/ILN6Klm.gif',
        fields: [{
             "title": "Project",
             "value": "#{app_name}",
             "short": true
        }]
      }]
    end

    def assemble_text_body
      "#{Time.new.strftime("At %I:%M%p")}, an error occurred with the following stack trace: ```#{@error.backtrace.join("\n")}```"
    end

    def app_name
      SlackErrorNotifier.app_name
    end
  end
end
