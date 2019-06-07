require_relative 'ext/tor_controller'

class CookieTorController < Tor::Controller
  def initialize(control_auth_cookie_path, options = {}, &block)
    cookie = `hexdump -e '32/1 "%02x""\n"' #{control_auth_cookie_path}`
    options[:cookie] = cookie.chomp
    super(options, &block)
  end
end

