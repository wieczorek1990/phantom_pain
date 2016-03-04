require 'phantomjs'
require 'selenium-webdriver'

require_relative 'ext/web_driver'

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

