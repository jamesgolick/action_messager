$LOAD_PATH.reject! { |p| p.include? 'TextMate' }
require "test/unit"
require "rubygems"
require "mocha"
require "shoulda"
require File.dirname(__FILE__)+'/../lib/action_messager'