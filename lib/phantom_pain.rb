require 'phantomjs'
require 'selenium-webdriver'
require 'tor'
require 'webdriver-user-agent'

class Tor::Controller
  def signal(name)
    send_command :signal, name
    read_reply
  end

  def restart
    signal :newnym
  end
end

module Webdriver
  module UserAgent
    module Devices
      public :random_user_agent
    end
  end
end

class WebDriverFactory
  def initialize(proxy_host, proxy_port)
    Selenium::WebDriver::PhantomJS.path = Phantomjs.path
    @user_agents = Class.new.extend(Webdriver::UserAgent::Devices)
    @base_desired_capabilities = {
      'phantomjs.cli.args' => ["--proxy=#{proxy_host}:#{proxy_port}", '--proxy-type=socks5']
    }
  end

  def random_user_agent
    @user_agents.random_user_agent.chomp
  end

  def create
    desired_capabilities = {
      'phantomjs.page.settings.userAgent' => random_user_agent
    }
    desired_capabilities.merge! @base_desired_capabilities
    Selenium::WebDriver.for :phantomjs, desired_capabilities: desired_capabilities
  end
end

class CookieTorController < Tor::Controller
  def initialize(control_auth_cookie_path, options = {}, &block)
    cookie = `hexdump -e '32/1 "%02x""\n"' #{control_auth_cookie_path}`.chomp
    options[:cookie] = cookie
    super(options, &block)
  end
end

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

