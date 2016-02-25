# Slack Error Notifier

Simple Slack exception notification for Ruby scripts. Just wrap your code in `SlackErrorNotifier.with_notifications {}` and off you go. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_error_notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_error_notifier

## Usage

### Configuration

```ruby
SlackErrorNotifier.configuration do |config|
  config.app_name = <THE NAME OF YOUR APP OR SCRIPT>
  config.access_token = <YOUR SLACK TOKEN>
  config.target_channel = <THE CHANNEL OR USER TO POST MESSAGES TO> # include '@' or '#' as applicable
  confg.send_as_user = <TRUE/FALSE> # whether you want to send as slackbot or the user whose token you're using.   
end
```

Pro-tip: Add a bot to your Slack organization and then use its API Token. You can then configure the avatar and username you want messages to come from. 

### Catching Exceptions in Your Code

```ruby
SlackErrorNotifier.with_notifications do 
  # Commence dangerous operations here:
  NuclearLaunchCode.run!
end
```

Your target user or channel will then be notified of any unhandled exceptions that occur during the dangerous operation. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cgrdavies/slack_error_notifier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

