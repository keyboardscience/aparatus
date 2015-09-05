ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'ansible'
