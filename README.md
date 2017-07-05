# Perspective API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'perspective_api'
```

## Usage

To query the toxicity of some text:

```ruby
PerspectiveAPI.analyse_toxicity text
PerspectiveAPI.analyse_toxicity text, :plain_text
PerspectiveAPI.analyse_toxicity text, :plain_text, :api_key => "..."
PerspectiveAPI.analyse_toxicity text, :api_key => "..."
```

The second (optional) argument is the type of the text being analysed. At the time of writing, only plain text is supported by the external API, and this is what this gem defaults to.

You can set up global configuration for options you want to apply to all requests:

```ruby
PerspectiveAPI::Options.set :api_key => "...", :do_not_store => true
```

The known options [are covered in the Perspective documentation](https://github.com/conversationai/perspectiveapi/blob/master/api_reference.md#scoring-comments-analyzecomment), and also enforced in this gem (with a slightly more Rubyist syntax):

* `:api_key`
* `:context_entries` (translated to `context.entries`)
* `:attributes` (translated to `requestedAttributes`)
* `:languages`
* `:do_not_store` (translated to `doNotStore`)
* `:client_token` (translated to `clientToken`)
* `:session_id` (translated to `sessionId`)

Please note that all options should be specified with symbol keys.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/limbrup/perspective_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Perspective API project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/limbrup/perspective_api/blob/master/CODE_OF_CONDUCT.md).
