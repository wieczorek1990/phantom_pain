require_relative 'phantom_pain/cookie_tor_controller'
require_relative 'phantom_pain/web_driver_factory'

class PhantomPainFactory
  def initialize(control_auth_cookie_path = "#{Dir.home}/.tor/control_auth_cookie",
                 proxy_host = '127.0.0.1', proxy_port = '9050')
    @tor_controller = CookieTorController.new control_auth_cookie_path
    @web_driver_factory = WebDriverFactory.new proxy_host, proxy_port
  end

  def create(&block)
    web_driver = @web_driver_factory.create
    block.call web_driver
    web_driver.quit
    @tor_controller.restart
  end

  def relieve
    @tor_controller.quit
  end
end

