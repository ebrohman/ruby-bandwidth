# ruby-bandwidth

[![Build](https://travis-ci.org/Bandwidth/ruby-bandwidth.png)](https://travis-ci.org/Bandwidth/ruby-bandwidth)

Bandwidth [Bandwidth's App Platform](http://ap.bandwidth.com/?utm_medium=social&utm_source=github&utm_campaign=dtolb&utm_content=) Ruby SDK

Notice: As of April 2019, versions of ruby-bandwidth less than 2.0.0 will not be compatible with Bandwidth's V2 Messaging. If you are using Bandwidth's V2 Messaging, you will need to update your ruby-bandwidth gem version to 2.0.0 or above. If you are not using Bandwidth's V2 Messaging, you do not need to update. 

With ruby-bandwidth  you have access to the entire set of API methods including:
* **Account** - get user's account data and transactions,
* **Application** - manage user's applications,
* **AvailableNumber** - search free local or toll-free phone numbers,
* **Bridge** - control bridges between calls,
* **Call** - get access to user's calls,
* **Conference** - manage user's conferences,
* **ConferenceMember** - make actions with conference members,
* **Domain** - get access to user's domains,
* **EntryPoint** - control of endpoints of domains,
* **Error** - list of errors,
* **Media** - list, upload and download files to Bandwidth API server,
* **Message** - send SMS/MMS, list messages,
* **NumberInfo** - receive CNUM info by phone number,
* **PhoneNumber** - get access to user's phone numbers,
* **Recording** - mamange user's recordings.

Also you can work with Bandwidth XML using special types (in namespace `Bandwidth::Xml`). 
## Install

Via rubygems:

    gem install ruby-bandwidth

or add to your Gemfile:

    gem "ruby-bandwidth"


## Getting Started

* Install `ruby-bandwidth`,
* **Get user id, api token and secret** - to use the Catapult API you need these data.  You can get them [here](https://catapult.inetwork.com/pages/catapult.jsf) on the tab "Account",
* **Set user id, api token and secret** - you can do that with 2 ways:

```ruby
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  
# Or you can use default client instance
# Do that only once
  Client.global_options = {:user_id => "userId", :api_token => "token", :api_secret => "secret"}
```



## Usage

All "static" (classs) functions support 2 ways to be called: with client instance as first arg or without client instance (default client instance will be used then)

```ruby
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  calls = Bandwidth::Call.list(client, {:page => 1})

# Or you can use default client instance
# You should set up its global options before using of api functions
  calls = Bandwidth::Call.list(:page=>1)
```

Read [Catapult Api documentation](https://catapult.inetwork.com/docs/api-docs/) for more details

## Examples
*All examples assume you have already setup your auth data!*

List all calls from special number

```ruby
  calls = Bandwidth::Call.list({:from => "+19195551212"})
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  calls = Bandwidth::Call.list(client, {:from => "+19195551212"})
```

List all received messages

```ruby
  messages = Bandwidth::Message.list({:state => "received"})
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  messages = Bandwidth::Message.list(client, {:state => "received"})
```

Send SMS

```ruby
  message = Bandwidth::Message.create({:from => "+19195551212", :to => "+191955512142", :text => "Test"})
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  message = Bandwidth::Message.create(client, {:from => "+19195551212", :to => "+191955512142", :text => "Test"})
```

Send some SMSes

```ruby
  statuses = Bandwidth::Message.create([{:from => "+19195551212", :to => "+191955512142", :text => "Test"}, {:from => "+19195551212", :to => "+191955512143", :text => "Test2"}])
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  statuses = Bandwidth::Message.create(client, [{:from => "+19195551212", :to => "+191955512142", :text => "Test"}, {:from => "+19195551212", :to => "+191955512143", :text => "Test2"}])
```

Upload file 

```ruby
  Bandwidth::Media.upload("avatar.png", File.open("/local/path/to/file.png", "r"), "image/png")
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  Bandwidth::Media.upload(client, "avatar.png", File.open("/local/path/to/file.png", "r"), "image/png")
```

Make a call

```ruby
  call = Bandwidth::Call.create({:from => "+19195551212", :to => ""+191955512142"})
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  call = Bandwidth::Call.create(client, {:from => "+19195551212", :to => ""+191955512142"})
```

Reject incoming call

```ruby
  call.reject_incoming()
```

Create a gather
```ruby
  gather = call.create_gather({:max_digits => 3, :inter_digit_timeout => 5, :prompt => {:sentence => "Please enter 3 digits"}})
```

Start a conference
```ruby
  conference = Bandwidth::Conference.create({:from => "+19195551212"})
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  conference = Bandwidth::Conference.create(client, {:from => "+19195551212"})
```

Connect 2 calls to a bridge

```ruby
  bridge = Bandwidth::Bridge.create({:call_ids => [call_id1, call_id2]})
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  bridge = Bandwidth::Bridge.create(client, {:call_ids => [call_id1, call_id2]})
```

Search available local numbers to buy

```ruby
  numbers = Bandwidth::AvailableNumber.search_local({:state =>"NC", :city => "Cary"})
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  numbers = Bandwidth::AvailableNumber.search_local(client, {:state =>"NC", :city => "Cary"})
```
Get CNAM info for a number

```ruby
  info = Bandwidth::NumberInfo.get("+19195551212")
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  info = Bandwidth::NumberInfo.get(client, "+19195551212")
```

Buy a phone number

```ruby
  number = Bandwidth::PhoneNumber.create({:number => "+19195551212"})
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  number = Bandwidth::PhoneNumber.create(client, {:number => "+19195551212"})
```

List recordings

```ruby
  list = Bandwidth::Recording.list()
  #or
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  list = Bandwidth::Recording.list(client)
```

Generate Bandwidth XML

```ruby
  response = Bandwidth::Xml::Response.new()
  speak_sentence = Bandwidth::Xml::Verbs::SpeakSentence.new({:sentence => "Transferring your call, please wait.", :voice => "paul", :gender => "male", :locale => "en_US"})
  transfer = Bandwidth::Xml::Verbs::Transfer.new({
            :transfer_to => "+13032288849",
            :transfer_caller_id => "private",
            :speak_sentence => {
                :sentence => "Inner speak sentence.",
                :voice => "paul",
                :gender => "male",
                :locale => "en_US"
            }
        })

  hangup = Bandwidth::Xml::Verbs::Hangup.new()
  response << speak_sentence << transfer << hangup 

  # as alternative way we can pass list of verbs to constructor of Response
  # response = Bandwidth::Xml::Response.new([speak_sentence, transfer, hangup])

  puts response.to_xml()
```


See directory `samples` for more examples.
See [ruby-bandwidth-example](https://github.com/bandwidthcom/ruby-bandwidth-example) for more complex examples of using this module.

### Messaging 2.0
Send SMS (v2)

```ruby
  auth_data = {user_name: 'user', password: 'password', account_id: 'accountId', subaccount_id: 'subaccountId'}

  # Before sending sms you should have nessagin application on Bandwidth dashboard. You should create it by next call
  application = Bandwidth::V2::Message.create_messaging_application(auth_data, {
      :name => 'My messaging application',
      :callback_url => 'http://server/to/handle/messages/events',
      :location_name => 'current',
      :is_default_location => false,
      :sms_options => {:toll_free_enabled => true},
      :mms_options => {:enabled => true}
  })

  # After that you should reserve 1 or some phone nubmers on Bandwidth Dashboard
  numbers = Bandwidth::V2::Message.search_and_order_numbers(auth_data, application) do |query|
      query.AreaCodeSearchAndOrderType do |b|
         b.AreaCode("910")
         b.Quantity(1)
      end
  end

  # Now you can send messages from reserved numbers. Don't forget to pass :application_id
  client = Bandwidth::Client.new(:user_id => "userId", :api_token => "token", :api_secret => "secret")
  message = Bandwidth::V2::Message.create(client, {:from => numbers[0], :to => ["+191955512142"], :text => "Test", :application_id => application[:application_id]})
```

# Documentation generation

Generates documentation:

    yard doc

# Samples
[More sample applications](https://github.com/bandwidthcom/ruby-bandwidth-example)
