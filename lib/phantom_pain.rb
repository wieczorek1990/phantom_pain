require_relative 'cookie_tor_controller'
require_relative 'web_driver_factory'

class PhantomPainFactory
  def initialize(control_auth_cookie_path, proxy_host, proxy_port)
    @tor_controller = CookieTorController.new control_auth_cookie_path
    @web_driver_factory = WebDriverFactory.new(proxy_host, proxy_port)
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

