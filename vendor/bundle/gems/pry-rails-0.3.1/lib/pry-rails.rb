# encoding: UTF-8

require 'pry'
require 'pry-rails/version'

if defined?(Rails) && !ENV['DISABLE_PRY_RAILS']
  require 'pry-rails/railtie'
  require 'pry-rails/commands'
end
