# ruby-bandwidth

[![Build](https://travis-ci.org/bandwidthcom/ruby-bandwidth.png)](https://travis-ci.org/bandwidthcom/ruby-bandwidth)

Bandwidth Catapult Ruby API

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
* **Get user id, api token and secret**- to use the Catapult API you need these data.  You can get them [here](https://catapult.inetwork.com/pages/catapult.jsf) on the tab "Account",
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

```
  calls = Bandwidth::Call.list({:from => "+19195551212"})
```

List all received messages

```
  messages = Bandwidth::Message.list({:state => "received"})
```

Send SMS

```
  message = Bandwidth::Message.create({:from => "+19195551212", :to => "+191955512142", :text => "Test"})
```

Upload file 

```
  Bandwidth::Media.upload("avatar.png", File.open("/local/path/to/file.png", "r"), "image/png")
```

Make a call

```
  Bandwidth::Call.create({:from => "+19195551212", :to => ""+191955512142"})
```

Reject incoming call

```
  call.reject_incoming()
```

Connect 2 calls to a bridge

```
  Bandwidth::Bridge.create({:call_ids => [call_id1, call_id2]})
```

Search available local numbers to buy

```
  numbers = Bandwidth::AvailableNumber.search_local({:state =>"NC", :city => "Cary"})
```
Get CNAM info for a number

```
  info = Bandwidth::NumberInfo.get("+19195551212")
```

Buy a phone number

```
  number = Bandwidth::PhoneNumber.create({:number => "+19195551212"})
```

See directory `samples` for more examples.
See [ruby-bandwidth-example](https://github.com/bandwidthcom/ruby-bandwidth-example) for more complex examples of using this module.



# Documentation generation

Generates documentation:

    yard doc


