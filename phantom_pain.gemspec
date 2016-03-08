# encoding: UTF-8

Gem::Specification.new do |s|
  s.name        = 'phantom_pain'
  s.version     = '0.0.1'
  s.date        = '2016-03-04'
  s.summary     = "Phantom Pain"
  s.description = "Bot factory with PhantomJS, Selenium and Tor"
  s.authors     = ["Łukasz Wieczorek"]
  s.email       = 'wieczorek1990@gmail.com'
  s.files       = ["lib/phantom_pain.rb"]
  s.homepage    = "https://github.com/wieczorek1990/phantom_pain"
  s.license     = 'GPL-3.0'
  s.add_runtime_dependency "phantomjs", "~> 2"
  s.add_runtime_dependency "selenium-webdriver", "~> 2"
  s.add_runtime_dependency "tor", "~> 0.1"
  s.add_runtime_dependency "webdriver-user-agent", "~> 7"
end

