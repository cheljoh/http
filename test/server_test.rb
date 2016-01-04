#require './lib/server'

require "hurley"

# If you prefer Addressable::URI, require this too:
# This is required automatically if `Addressable::URI` is defined when Hurley
# is being loaded.
require "hurley/addressable"

client = Hurley::Client.new "https://api.github.com"
client.header[:accept] = "application/vnd.github+json"
client.query["a"] = "?a is set on every request too"

client.scheme # => "https"
client.host   # => "api.github.com"
client.port   # => 443

# See Hurley::RequestOptions in lib/hurley/options.rb
client.request_options.timeout = 3

# See Hurley::SslOptions in lib/hurley/options.rb
client.ssl_options.ca_file = "path/to/cert.crt"

# Verbs head, get, put, post, patch, delete, and options are supported.
response = client.get("users/tater") do |req|
  # These properties can be changed on a per-request basis.
  req.header[:accept] = "application/vnd.github.preview+json"
  req.query["a"] = "override!"

  req.options.timeout = 1
  req.ssl_options.ca_file = "path/to/cert.crt"

  req.verb   # => :get
  req.scheme # => "https"
  req.host   # => "api.github.com"
  req.port   # => 443
end

# You can also use Hurley class level shortcuts, which use Hurley.default_client.
response = Hurley.get("https://api.github.com/users/tater")

response.header[:content_type] # => "application/json"
response.status_code           # => 200
response.body                  # => {"id": 1, ...}
response.request               # => same as `request`

# Is this a 2xx response?
response.success?

# Is this a 3xx redirect?
response.redirection?

# Is this is a 4xx response?
response.client_error?

# Is this a 5xx response?
response.server_error?

# What kind of response is this?
response.status_type # => One of :success, :redirection, :client_error, :server_error, or :other

# Timing of the response, in ms
response.ms

# Responses automatically follow 5 redirections by default.

response.via      # Array of Request objects that redirected.
response.location # => New Request built from Location header URL.

# You can tune the number of redirections, or disable them per Client or Request.

# This client follows up to 10 redirects
client.request_options.redirection_limit = 10
client.get "/foo" do |req|
  # this specific request never follows any redirects.
  req.options.redirection_limit = 0
end
