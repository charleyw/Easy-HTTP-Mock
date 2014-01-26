$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'easy-http-mock/version'

Gem::Specification.new 'Easy-HTTP-Mock', EasyHTTPMock::VERSION do |s|
  s.description       = 'Easy HTTP Mock is a tool aim at quickly mock http service'
  s.summary           = 'Mock HTTP service at minutes'
  s.authors           = ['Wang Chao']
  s.email             = 'cwang8023@gmail.com'
  s.homepage          = 'https://github.com/charleyw/Easy-HTTP-Mock'
  s.license           = 'MIT'
  s.files             = `git ls-files`.split("\n") - %w[.gitignore .travis.yml .ruby-version .ruby-gemset test.yml]
  s.test_files        = s.files.select { |p| p =~ /^spec\/.*_spec.rb/ }
  s.executables = ['ehm', 'easyhttpmock']
  s.add_dependency 'sinatra', '~> 1.4.4'
end
