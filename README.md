# Pivit 

Pivit is a api wrapper for the Pivotal Tracker API. Most features are currently
build out but some are still being implemented.

## Installation

Add this line to your application's Gemfile:

    gem 'pivit'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pivit

## Documentation

http://rdoc.info/github/jasontruluck/pivit/master/index

## Configuration

Configuration allows for specifying your Pivotal Tracker instances variables. To connect to the API you only need either the `api_token` or the `username` and `password` not both.

`api_token` - The api token provided via Pivotal Tracker

`username`  - The username of the user you use for Pivotal Tracker

`password`  - The password associated with your account

`ssl`       - If you would like to use SSL to communicate with Pivotal Tracker (default: true)

Within an initializer `config/initializer/pivit.rb`

```ruby
Pivit.configure do |c|
  c.ssl   = true
  c.api_token = "super-secret-token"
end
```

### Setting up a new client

```ruby
client = Pivit::Client.new(:username => "username", :password =>"super-secret")
```
or
```ruby
client = Pivit.new(:username => "username", :password =>"super-secret")
```

You can also pass configuration keys such as  etc. as well.

### Using Limit and Offset

For methods that allow you to specify a limit and/or offset simply pass the limit or offset you want via an option

```ruby
client.iteration(My-Awesome-Project-ID, {:limit => 1})
```

## Testing

This gem uses VCR to record requests to the api so you must test using a valid Pivotal Tracker server and credentails to test

Add a sample authentications file to your `spec/fixtures` directory:

```ruby
#spec/fixtures/authentications.yml
USERNAME:   myusername
PASSWORD:   supersecret
TOKEN:      supersecret
PROJECT:    "12345"                      # ID of a project
STORY:      "12345"                      # ID of a story
STORY_B:    "12345"                      # ID of an alternate story
MEMBERSHIP: "12345"                      # a id of a membership of a user in your project
NOTE:       "This some note text"        # Some test text
TASK:       "12345"                      # ID of a task within your pivotal tracker project 
FILE:       "../../../fixtures/test.png" # File locatin of the image/doc/text you would like to use to test with
```

sample is included in the [source](https://github.com/jasontruluck/pivit/blob/master/spec/fixtures/authentications.yml.sample).

*Note: for tests concerning disabling, deleting, restarting, etc they are mocked explicitly with webmock and will not effect your project*

## Contributing
  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request</job>)
