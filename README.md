
# UriFor

UriFor helps to generate http and https URIs from simple hashes using ruby stdlib's URI module.
If you don't provide e.g., the host, port, etc. UriFor tries to use the values from your controller, if possible.

## Installation

Add this line to your application's Gemfile:

    gem "uri_for", :git => "git://github.com/mrkamel/uri_for.git"

And then execute:

    $ bundle

## Usage

In your standard or mailer views, controllers and models, simply use:

<pre>
uri_for :host => "example.org", :path => "/path/to/file" # => "http://example.org/path/to/file
</pre>

Or the short way:

<pre>
irb> uri_for :path => "/path/to/file
=> "http://example.org/path/to/file" # example.org is taken from the current request
</pre>

However, usually, you want to provide the uri via your models:

<pre>
class SomeModel < ActiveRecord::Base
  def image_uri
    { :host => APP_CONFIG["image_host"], :path => "/path/to/file" }
  end
end

# In your views:

uri_for SomeModel.first # => "http://example.org/path/to/file"
</pre>

UriFor even takes control of whether to use http or https:

<pre>
uri_for :port => 443, :path => "/path/to/file" # => "https://example.org/path/to/file"
</pre>

Again, if you don't provide the port with the hash, UriFor will try to use it from
the current request, if accessible.

Within mailer views and models UriFor of course can't use the current
request to set these smart defaults. Smart defaults are only available within
your controllers and standard views. However, you can always provide the
port and host manually.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

