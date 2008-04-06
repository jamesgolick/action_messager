$LOAD_PATH.unshift(File.dirname(__FILE__))
require "rubygems"
require "json"
require "xmpp4r-simple"
require "activesupport"
require "action_messager/version"
require "action_messager/base"

module ActionMessager
  NAME = 'action_messager'
end
