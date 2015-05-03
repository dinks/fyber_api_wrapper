# FyberApiWrapper

This serves as a Wrapper to `http://developer.fyber.com/content/ios/offer-wall/offer-api/`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fyber_api_wrapper', git: 'git@github.com:dinks/fyber_api_wrapper.git'
```


And then execute:

    $ bundle

## Usage


For the Fyber API to work, you must have an API Key which is available on demand.

Please have a look at [the api documantation](http://developer.fyber.com/content/ios/offer-wall/offer-api/).

With Rails, set up the configuration

	require 'fyber_api_wrapper'

	FyberApiWrapper.configure do |config|
  		config.format = :json
		config.appid = 157
		config.offer_types = [ 112 ]
		config.api_key = ENV['FYBER_API_KEY']
	end

where `FYBER_API_KEY` is set up as an environment variable. Now you are ready to use the `FyberApiWrapper` to access the `offers` api.

Use `FyberApiWrapper.offers(options)` to get a `FyberApiWrapper::Request` object. Call this object with `.get` to get the response.

	FyberApiWrapper.offers(options).get(more_options)
	
The response could be a `FyberApiWrapper::Response` if all goes well. 

If exceptions are raised, then it could be one of 

- `FyberApiWrapper::UnauthorizedError` - 401 Httpstatus
- `FyberApiWrapper::BadRequestError`   - 400 Httpstatus
- `FyberApiWrapper::ResponseError`     - all the others

Specs were written using `Rspec`. The requests were recorded using `vcr` and stored so that it can be replayed. 


## Contributing

1. Fork it ( https://github.com/[my-github-username]/fyber_api_wrapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
